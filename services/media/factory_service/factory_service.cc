// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/factory_service/factory_service.h"
#include "services/media/factory_service/media_decoder_impl.h"
#include "services/media/factory_service/media_demux_impl.h"
#include "services/media/factory_service/media_player_impl.h"
#include "services/media/factory_service/media_sink_impl.h"
#include "services/media/factory_service/media_source_impl.h"
#include "services/media/factory_service/network_reader_impl.h"

namespace mojo {
namespace media {

MediaFactoryService::Product::Product(MediaFactoryService* owner)
    : owner_(owner) {
  DCHECK(owner_);
}

MediaFactoryService::Product::~Product() {}

MediaFactoryService::MediaFactoryService() {}

MediaFactoryService::~MediaFactoryService() {}

void MediaFactoryService::Initialize(ApplicationImpl* app) {
  app_ = app;
}

bool MediaFactoryService::ConfigureIncomingConnection(
    ApplicationConnection* connection) {
  connection->AddService<MediaFactory>(this);
  return true;
}

void MediaFactoryService::Create(ApplicationConnection* connection,
                                 InterfaceRequest<MediaFactory> request) {
  bindings_.AddBinding(this, request.Pass());
}

void MediaFactoryService::CreatePlayer(InterfaceHandle<SeekingReader> reader,
                                       InterfaceRequest<MediaPlayer> player) {
  products_.insert(std::static_pointer_cast<Product>(
      MediaPlayerImpl::Create(reader.Pass(), player.Pass(), this)));
}

void MediaFactoryService::CreateSource(InterfaceHandle<SeekingReader> reader,
                                       Array<MediaTypeSetPtr> media_types,
                                       InterfaceRequest<MediaSource> source) {
  products_.insert(std::static_pointer_cast<Product>(MediaSourceImpl::Create(
      reader.Pass(), media_types, source.Pass(), this)));
}

void MediaFactoryService::CreateSink(const String& destination_url,
                                     MediaTypePtr media_type,
                                     InterfaceRequest<MediaSink> sink) {
  products_.insert(std::static_pointer_cast<Product>(MediaSinkImpl::Create(
      destination_url, media_type.Pass(), sink.Pass(), this)));
}

void MediaFactoryService::CreateDemux(InterfaceHandle<SeekingReader> reader,
                                      InterfaceRequest<MediaDemux> demux) {
  products_.insert(std::static_pointer_cast<Product>(
      MediaDemuxImpl::Create(reader.Pass(), demux.Pass(), this)));
}

void MediaFactoryService::CreateDecoder(
    MediaTypePtr input_media_type,
    InterfaceRequest<MediaTypeConverter> decoder) {
  products_.insert(std::static_pointer_cast<Product>(
      MediaDecoderImpl::Create(input_media_type.Pass(), decoder.Pass(), this)));
}

void MediaFactoryService::CreateNetworkReader(
    const String& url,
    InterfaceRequest<SeekingReader> reader) {
  products_.insert(std::static_pointer_cast<Product>(
      NetworkReaderImpl::Create(url, reader.Pass(), this)));
}

}  // namespace media
}  // namespace mojo
