// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_IMAGE_PIPE_GLES2_IMAGE_COMPOSITOR_IMAGE_COMPOSITOR_IMAGE_PIPE_DELEGATE_H_
#define EXAMPLES_IMAGE_PIPE_GLES2_IMAGE_COMPOSITOR_IMAGE_COMPOSITOR_IMAGE_PIPE_DELEGATE_H_

#include "base/macros.h"
#include "base/memory/weak_ptr.h"
#include "mojo/services/gfx/images/cpp/image_pipe_consumer_delegate.h"
#include "mojo/services/gfx/images/cpp/image_pipe_consumer_endpoint.h"
#include "mojo/services/gfx/images/interfaces/image_pipe.mojom.h"

namespace examples {
namespace image_pipe {

class GLES2ImageCompositorImagePipeDelegate : public ::image_pipe::ImagePipeConsumerDelegate {
 public:
  struct Image {
    uint32_t id;
    GLuint texture;
    uint32_t mgl_image;
  };

  GLES2ImageCompositorImagePipeDelegate(
      mojo::InterfaceRequest<mojo::gfx::ImagePipe> request,
      mojo::gfx::SupportedImagePropertiesPtr supported_properties,
      std::function<void ()> present_callback,
      std::string delegate_name);
  ~GLES2ImageCompositorImagePipeDelegate() override;

  bool AcquireImage(struct Image *image_out);
  void ReleaseImage(struct Image image, mojo::gfx::PresentationStatus);

 private:
  // ImagePipeConsumerDelegate implementation
  void AddImage(mojo::gfx::ImagePtr image, uint32_t id) override;
  void RemoveImage(uint32_t id) override;
  void PresentImage(uint32_t id) override;
  void HandleEndpointClosed() override;

  std::unique_ptr<::image_pipe::ImagePipeConsumerEndpoint> image_pipe_;
  mojo::gfx::SupportedImagePropertiesPtr supported_properties_;
  std::function<void ()> present_callback_;
  std::string delegate_name_;

  MojoTimeTicks timing_interval_start_;
  MojoTimeTicks timing_interval_end_;
  static const uint32_t frames_per_interval_ = 128;
  uint32_t frame_count_;


  std::unordered_map<uint32_t, struct Image> image_map_;

};

} // namespace image_pipe
} // namespace examples


#endif  // EXAMPLES_IMAGE_PIPE_GLES2_IMAGE_COMPOSITOR_IMAGE_COMPOSITOR_IMAGE_PIPE_DELEGATE_H_