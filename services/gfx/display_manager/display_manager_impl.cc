// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/display_manager/display_manager_impl.h"

#if defined(MOJO_USE_DRI3) && defined(USE_X11)
#include "services/gfx/display_manager/image_pipe_delegate_xcb.h"
#endif  // defined(MOJO_USE_DRI3) && defined(USE_X11)

namespace display_manager {

DisplayManagerImpl::DisplayManagerImpl(
    mojo::InterfaceRequest<mojo::gfx::DisplayManager> request)
    : binding_(this, request.Pass()), weak_factory_(this) {}

DisplayManagerImpl::~DisplayManagerImpl() {}

void DisplayManagerImpl::GetImagePipe(
    mojo::InterfaceRequest<mojo::gfx::ImagePipe> request,
    const GetImagePipeCallback& callback) {
  if (image_pipe_delegate_) {
    LOG(ERROR) << "Can only request one ImagePipe from the DisplayManager";
    binding_.Close();
    return;
  }

#if defined(MOJO_USE_DRI3) && defined(USE_X11)
  image_pipe_delegate_.reset(
      new ImagePipeDelegateXCB(request.Pass(), callback));
  if (!static_cast<ImagePipeDelegateXCB*>(image_pipe_delegate_.get())
           ->Initialize()) {
    LOG(ERROR) << "Failed to initialize Image Pipe Delegate";
    binding_.Close();
    return;
  }
#else
  LOG(ERROR) << "No image pipe support on this platform";
  binding_.Close();
  return;
#endif  // defined(MOJO_USE_DRI3) && defined(USE_X11)
}
}
