// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <stdio.h>
#include <string>

#include "examples/spinning_cube/gles2_client_impl.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/system/core.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/public/cpp/utility/run_loop.h"
#include "mojo/services/gfx/images/interfaces/image_pipe.mojom.h"
#include "mojo/services/gpu/interfaces/gpu.mojom.h"
#include "base/logging.h"
#include "examples/image_pipe/interfaces/image_producer.mojom.h"
#include "mojo/public/cpp/bindings/strong_binding.h"

namespace examples {
namespace image_pipe {

class GLES2ImageProducer : public ImageProducer {

public:
  GLES2ImageProducer(mojo::ApplicationImpl* application,
                     mojo::InterfaceRequest<ImageProducer> request)
    :binding_(this, request.Pass()), application_(application)
  {}
  ~GLES2ImageProducer() override {}

  void Initialize(mojo::gfx::ImagePipePtr image_pipe, mojo::gfx::SupportedImagePropertiesPtr supported_properties) override {
    application_->ConnectToService("mojo:native_viewport_service", &gpu_ptr_);
    gpu_ptr_.set_connection_error_handler(
        []() { printf("GPU Service Connection Error\n"); });

    mojo::ContextProviderPtr onscreen_context_provider;
    gpu_ptr_->GetOnScreenGLES2ContextProvider(
        GetProxy(&onscreen_context_provider), image_pipe.Pass(),
        supported_properties->size.Clone());

    gles2_client_.reset(new GLES2ClientImpl(onscreen_context_provider.Pass()));
    gles2_client_->SetSize(*(supported_properties->size));
  }

private:
  mojo::GpuPtr gpu_ptr_;
  scoped_ptr<GLES2ClientImpl> gles2_client_;
  mojo::StrongBinding<ImageProducer> binding_;
  mojo::ApplicationImpl* application_;


  DISALLOW_COPY_AND_ASSIGN(GLES2ImageProducer);

};

class GLES2SpinningCubeApp : public mojo::ApplicationDelegate,
                             public mojo::InterfaceFactory<ImageProducer> {
 public:
  GLES2SpinningCubeApp() {}

  ~GLES2SpinningCubeApp() override {}

  bool ConfigureIncomingConnection(
    mojo::ApplicationConnection* connection) override {
    connection->AddService<ImageProducer>(this);
    return true;
  }

  void Create(
      mojo::ApplicationConnection* connection,
      mojo::InterfaceRequest<ImageProducer> request) override {
    new GLES2ImageProducer(application_, request.Pass());
  }

  void Initialize(mojo::ApplicationImpl* app) override {
    application_ = app;
  }


 private:
  mojo::ApplicationImpl* application_;

  // mojo::gfx::DisplayManagerPtr display_manager_;


  DISALLOW_COPY_AND_ASSIGN(GLES2SpinningCubeApp);
};

}  // namespace image_pipe
}  // namespace examples

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunner runner(
      std::unique_ptr<examples::image_pipe::GLES2SpinningCubeApp>(
          new examples::image_pipe::GLES2SpinningCubeApp));
  return runner.Run(application_request);
}