// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_DISPLAY_MANAGER_IMAGE_PIPE_DELEGATE_XCB_H_
#define SERVICES_GFX_DISPLAY_MANAGER_IMAGE_PIPE_DELEGATE_XCB_H_

#include <xcb/xcb.h>

#include "base/macros.h"
#include "base/memory/weak_ptr.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "mojo/public/platform/native/platform_handle_private.h"
#include "mojo/services/gfx/display_manager/interfaces/display_manager.mojom.h"
#include "mojo/services/gfx/images/cpp/image_pipe_consumer_delegate.h"
#include "mojo/services/gfx/images/cpp/image_pipe_consumer_endpoint.h"
#include "mojo/services/gfx/images/interfaces/image_pipe.mojom.h"

namespace display_manager {

class ImagePipeDelegateXCB : public image_pipe::ImagePipeConsumerDelegate {
 public:
  ImagePipeDelegateXCB(
      mojo::InterfaceRequest<mojo::gfx::ImagePipe> request,
      const mojo::gfx::DisplayManager::GetImagePipeCallback& callback);
  ~ImagePipeDelegateXCB() override;

  bool Initialize();

 private:
  // Implementation of ImagePipeConsumerDelegate
  void AddImage(mojo::gfx::ImagePtr image, uint32_t id) override;
  void RemoveImage(uint32_t id) override;
  void PresentImage(uint32_t id) override;
  void HandleEndpointClosed() override;

  bool CreateWindow();
  bool InitConnection();
  std::unique_ptr<image_pipe::ImagePipeConsumerEndpoint> image_pipe_;

  xcb_connection_t* connection_;
  xcb_screen_t* screen_;
  xcb_window_t window_;
  xcb_intern_atom_reply_t* atom_wm_delete_window_;

  uint32_t width_;
  uint32_t height_;

  struct XcbMojoImage {
    MojoPlatformHandle fd;
    xcb_pixmap_t pixmap;
    bool busy;
  };

  std::map<uint32_t, XcbMojoImage> image_map_;

  xcb_gc_t gc_;

  DISALLOW_COPY_AND_ASSIGN(ImagePipeDelegateXCB);
};

}  // namespace display_manager

#endif  // SERVICES_GFX_DISPLAY_MANAGER_IMAGE_PIPE_DELEGATE_XCB_H_
