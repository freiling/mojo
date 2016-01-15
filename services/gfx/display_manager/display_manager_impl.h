// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_GFX_DISPLAY_MANAGER_INTERFACES_DISPLAY_MANAGER_IMPL_H_
#define MOJO_SERVICES_GFX_DISPLAY_MANAGER_INTERFACES_DISPLAY_MANAGER_IMPL_H_

#include "base/macros.h"
#include "base/memory/weak_ptr.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "mojo/services/gfx/display_manager/interfaces/display_manager.mojom.h"
#include "mojo/services/gfx/images/cpp/image_pipe_consumer_delegate.h"
#include "mojo/services/gfx/images/cpp/image_pipe_consumer_endpoint.h"

namespace display_manager {

class DisplayManagerImpl : public mojo::gfx::DisplayManager {
 public:
  DisplayManagerImpl(mojo::InterfaceRequest<mojo::gfx::DisplayManager> request);
  ~DisplayManagerImpl() override;

  void GetImagePipe(mojo::InterfaceRequest<mojo::gfx::ImagePipe> request,
                    const GetImagePipeCallback& callback) override;

 private:
  std::unique_ptr<image_pipe::ImagePipeConsumerDelegate> image_pipe_delegate_;
  mojo::StrongBinding<mojo::gfx::DisplayManager> binding_;
  base::WeakPtrFactory<DisplayManagerImpl> weak_factory_;

  DISALLOW_COPY_AND_ASSIGN(DisplayManagerImpl);
};

}  // namespace display_manager

#endif  // MOJO_SERVICES_GFX_DISPLAY_MANAGER_INTERFACES_DISPLAY_MANAGER_IMPL_H_
