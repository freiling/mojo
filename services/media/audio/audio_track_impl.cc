// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <algorithm>
#include <limits>

#include "base/logging.h"
#include "mojo/services/media/common/cpp/linear_transform.h"
#include "services/media/audio/audio_output_manager.h"
#include "services/media/audio/audio_server_impl.h"
#include "services/media/audio/audio_track_impl.h"
#include "services/media/audio/audio_track_to_output_link.h"

namespace mojo {
namespace media {
namespace audio {

constexpr size_t AudioTrackImpl::PTS_FRACTIONAL_BITS;

// TODO(johngro): If there is ever a better way to do this type of static-table
// initialization using mojom generated structs, we should switch to it.
static const struct {
  AudioSampleFormat sample_format;
  uint32_t min_channels;
  uint32_t max_channels;
  uint32_t min_frames_per_second;
  uint32_t max_frames_per_second;
} kSupportedAudioTypeSets[] = {
  {
    .sample_format = AudioSampleFormat::UNSIGNED_8,
    .min_channels = 1,
    .max_channels = 2,
    .min_frames_per_second = 1000,
    .max_frames_per_second = 48000,
  },
  {
    .sample_format = AudioSampleFormat::SIGNED_16,
    .min_channels = 1,
    .max_channels = 2,
    .min_frames_per_second = 1000,
    .max_frames_per_second = 48000,
  },
};

AudioTrackImpl::AudioTrackImpl(InterfaceRequest<AudioTrack> iface,
                               AudioServerImpl* owner)
  : owner_(owner),
    binding_(this),
    pipe_(this, owner) {
  CHECK(nullptr != owner_);
  binding_.Bind(iface.Pass());
  binding_.set_connection_error_handler([this]() -> void {
    Shutdown();
  });
}

AudioTrackImpl::~AudioTrackImpl() {
  // assert that we have been cleanly shutdown already.
  MOJO_DCHECK(!binding_.is_bound());
}

AudioTrackImplPtr AudioTrackImpl::Create(InterfaceRequest<AudioTrack> iface,
                                         AudioServerImpl* owner) {
  AudioTrackImplPtr ret(new AudioTrackImpl(iface.Pass(), owner));
  ret->weak_this_ = ret;
  return ret;
}

void AudioTrackImpl::Shutdown() {
  // If we are unbound, then we have already been shut down and are just waiting
  // for the service to destroy us.  Run some DCHECK sanity checks and get out.
  if (!binding_.is_bound()) {
    DCHECK(!pipe_.IsInitialized());
    DCHECK(!rate_control_.is_bound());
    DCHECK(!outputs_.size());
    return;
  }

  // Close the connection to our client
  binding_.set_connection_error_handler(mojo::Closure());
  binding_.Close();

  // reset all of our internal state and close any other client connections in
  // the process.
  pipe_.Reset();
  rate_control_.Reset();
  outputs_.clear();

  DCHECK(owner_);
  AudioTrackImplPtr thiz = weak_this_.lock();
  owner_->RemoveTrack(thiz);
}

void AudioTrackImpl::Describe(const DescribeCallback& cbk) {
  // Build a minimal descriptor
  //
  // TODO(johngro): one day, we need to make this description much more rich and
  // fully describe our capabilities, based on things like what outputs are
  // available, the class of hardware we are on, and what options we were
  // compiled with.
  //
  // For now, it would be nice to just be able to have a static const tree of
  // capabilities in this translational unit which we could use to construct our
  // message, but the nature of the structures generated by the C++ bindings
  // make this difficult.  For now, we just create a trivial descriptor entierly
  // by hand.
  AudioTrackDescriptorPtr desc(AudioTrackDescriptor::New());

  desc->supported_media_types =
    Array<MediaTypeSetPtr>::New(arraysize(kSupportedAudioTypeSets));

  for (size_t i = 0; i < desc->supported_media_types.size(); ++i) {
    const MediaTypeSetPtr& mts =
      (desc->supported_media_types[i] = MediaTypeSet::New());

    mts->medium    = MediaTypeMedium::AUDIO;
    mts->encodings = Array<String>::New(1);
    mts->details   = MediaTypeSetDetails::New();

    mts->encodings[0] = MediaType::kAudioEncodingLpcm;

    const auto& s = kSupportedAudioTypeSets[i];
    AudioMediaTypeSetDetailsPtr audio_detail = AudioMediaTypeSetDetails::New();

    audio_detail->sample_format = s.sample_format;
    audio_detail->min_channels = s.min_channels;
    audio_detail->max_channels = s.max_channels;
    audio_detail->min_frames_per_second = s.min_frames_per_second;
    audio_detail->max_frames_per_second = s.max_frames_per_second;
    mts->details->set_audio(audio_detail.Pass());
  }

  cbk.Run(desc.Pass());
}

void AudioTrackImpl::Configure(AudioTrackConfigurationPtr configuration,
                               InterfaceRequest<MediaConsumer> req) {
  // Are we already configured?
  if (pipe_.IsInitialized()) {
    LOG(ERROR) << "Attempting to reconfigure a configured audio track.";
    Shutdown();
    return;
  }

  // Check the requested configuration.
  if ((configuration->media_type->medium != MediaTypeMedium::AUDIO) ||
      (configuration->media_type->encoding != MediaType::kAudioEncodingLpcm) ||
      (!configuration->media_type->details->is_audio())) {
    LOG(ERROR) << "Unsupported configuration requested in "
                  "AudioTrack::Configure.  Media type must be LPCM audio.";
    Shutdown();
    return;
  }

  // Search our supported configuration sets to find one compatible with this
  // request.
  auto& cfg = configuration->media_type->details->get_audio();
  size_t i;
  for (i = 0; i < arraysize(kSupportedAudioTypeSets); ++i) {
    const auto& cfg_set = kSupportedAudioTypeSets[i];

    if ((cfg->sample_format == cfg_set.sample_format) &&
        (cfg->channels >= cfg_set.min_channels) &&
        (cfg->channels <= cfg_set.max_channels) &&
        (cfg->frames_per_second >= cfg_set.min_frames_per_second) &&
        (cfg->frames_per_second <= cfg_set.max_frames_per_second)) {
      break;
    }
  }

  if (i >= arraysize(kSupportedAudioTypeSets)) {
    LOG(ERROR) << "Unsupported LPCM configuration requested in "
                  "AudioTrack::Configure.  "
               << "(format = " << cfg->sample_format
               << ", channels = "
               << static_cast<uint32_t>(cfg->channels)
               << ", frames_per_second = " << cfg->frames_per_second
               << ")";
    Shutdown();
    return;
  }

  // Sanity check the ratio which relates audio frames to media time.
  int32_t  numerator   = static_cast<int32_t>(configuration->audio_frame_ratio);
  uint32_t denominator = static_cast<int32_t>(configuration->media_time_ratio);
  if ((numerator < 1) || (denominator < 1)) {
    LOG(ERROR) << "Invalid (audio frames:media time ticks) ratio ("
               << numerator << "/" << denominator << ")";
    Shutdown();
    return;
  }


  // Figure out the rate we need to scale by in order to produce our fixed
  // point timestamps.
  LinearTransform::Ratio frac_scale(1 << PTS_FRACTIONAL_BITS, 1);
  LinearTransform::Ratio frame_scale(LinearTransform::Ratio(numerator,
                                                            denominator));
  bool no_loss = LinearTransform::Ratio::Compose(frac_scale,
                                                 frame_scale,
                                                 &frame_to_media_ratio_);
  if (!no_loss) {
    LOG(ERROR) << "Invalid (audio frames:media time ticks) ratio ("
               << numerator << "/" << denominator << ")";
    Shutdown();
    return;
  }

  // Figure out how many bytes we need to hold the requested number of nSec of
  // audio.
  switch (cfg->sample_format) {
    case AudioSampleFormat::UNSIGNED_8:
      bytes_per_frame_ = 1;
      break;

    case AudioSampleFormat::SIGNED_16:
      bytes_per_frame_ = 2;
      break;

    case AudioSampleFormat::SIGNED_24_IN_32:
      bytes_per_frame_ = 4;
      break;

    default:
      DCHECK(false);
      bytes_per_frame_ = 2;
      break;
  }
  bytes_per_frame_ *= cfg->channels;

  // Bind our pipe to the interface request.
  if (pipe_.Init(req.Pass()) != MOJO_RESULT_OK) {
    LOG(ERROR) << "Failed to media pipe to interface request.";
    Shutdown();
    return;
  }

  // Stash our configuration.
  format_ = cfg.Pass();

  // Have the audio output manager initialize our set of outputs.  Note; there
  // is currently no need for a lock here.  Methods called from our user-facing
  // interfaces are seriailzed by nature of the mojo framework, and none of the
  // output manager's threads should ever need to manipulate the set.  Cleanup
  // of outputs which have gone away is currently handled in a lazy fashion when
  // the track fails to promote its weak reference during an operation involving
  // its outputs.
  //
  // TODO(johngro): someday, we will need to deal with recalculating properties
  // which depend on a track's current set of outputs (for example, the minimum
  // latency).  This will probably be done using a dirty flag in the track
  // implementations, and scheduling a job to recalculate the properties for the
  // dirty tracks and notify the users as appropriate.

  // If we cannot promote our own weak pointer, something is seriously wrong.
  AudioTrackImplPtr strong_this(weak_this_.lock());
  DCHECK(strong_this);
  DCHECK(owner_);
  owner_->GetOutputManager().SelectOutputsForTrack(strong_this);
}

void AudioTrackImpl::GetRateControl(InterfaceRequest<RateControl> req) {
  if (!rate_control_.Bind(req.Pass())) {
    Shutdown();
  }
}

void AudioTrackImpl::SetGain(float db_gain) {
  if (db_gain >= AudioTrack::kMaxGain) {
    LOG(ERROR) << "Gain value too large (" << db_gain << ") for audio track.";
    Shutdown();
    return;
  }

  db_gain_ = db_gain;

  for (const auto& output : outputs_) {
    DCHECK(output);
    output->UpdateGain();
  }
}

void AudioTrackImpl::AddOutput(AudioTrackToOutputLinkPtr link) {
  // TODO(johngro): assert that we are on the main message loop thread.
  DCHECK(link);
  auto res = outputs_.emplace(link);
  DCHECK(res.second);
  link->UpdateGain();
}

void AudioTrackImpl::RemoveOutput(AudioTrackToOutputLinkPtr link) {
  // TODO(johngro): assert that we are on the main message loop thread.
  DCHECK(link);

  auto iter = outputs_.find(link);
  if (iter != outputs_.end()) {
    outputs_.erase(iter);
  } else {
    // TODO(johngro): that's odd.  I can't think of a reason why we we should
    // not be able to find this link in our set of outputs... should we log
    // something about this?
    DCHECK(false);
  }
}

void AudioTrackImpl::OnPacketReceived(AudioPipe::AudioPacketRefPtr packet) {
  DCHECK(packet);
  for (const auto& output : outputs_) {
    DCHECK(output);
    output->PushToPendingQueue(packet);
  }
}

bool AudioTrackImpl::OnFlushRequested(const MediaConsumer::FlushCallback& cbk) {
  for (const auto& output : outputs_) {
    DCHECK(output);
    output->FlushPendingQueue();
  }
  cbk.Run();
  return true;
}

}  // namespace audio
}  // namespace media
}  // namespace mojo
