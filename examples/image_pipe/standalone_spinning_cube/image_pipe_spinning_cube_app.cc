// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/system/core.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/public/cpp/utility/run_loop.h"
#include "mojo/services/gfx/display_manager/interfaces/display_manager.mojom.h"
#include "mojo/services/gfx/images/interfaces/image_pipe.mojom.h"
#include "base/logging.h"
#include "examples/image_pipe/interfaces/image_producer.mojom.h"

namespace examples {
namespace image_pipe {
class ImagePipeSpinningCubeApp : public mojo::ApplicationDelegate {
 public:
  ImagePipeSpinningCubeApp() {}

  ~ImagePipeSpinningCubeApp() override {}

  void Initialize(mojo::ApplicationImpl* app) override {

    app->ConnectToService("mojo:display_manager_service", &display_manager_);
    display_manager_.set_connection_error_handler(
        []() { printf("Display Manager Connection Error\n"); });

    mojo::gfx::ImagePipePtr image_pipe_ptr;
    mojo::gfx::SupportedImagePropertiesPtr supported_properties;

    display_manager_->GetImagePipe(
        GetProxy(&image_pipe_ptr),
        [&supported_properties](
            mojo::gfx::SupportedImagePropertiesPtr supported_properties_in) {
          supported_properties = supported_properties_in.Pass();
        });
    if (!display_manager_.WaitForIncomingResponse()) {
      printf("Display Manager Connection Error\n");
      app->Terminate();
    }

   
    app->ConnectToService("mojo:gles2_spinning_cube", &image_producer_);


    image_producer_.set_connection_error_handler(
          []() { printf("Image Producer Connection Error\n"); });
    image_producer_->Initialize(image_pipe_ptr.Pass(), supported_properties.Pass());


    
  }


 private:

  mojo::gfx::DisplayManagerPtr display_manager_;
  examples::image_pipe::ImageProducerPtr image_producer_;


  DISALLOW_COPY_AND_ASSIGN(ImagePipeSpinningCubeApp);
};
}
}

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunner runner(
      std::unique_ptr<examples::image_pipe::ImagePipeSpinningCubeApp>(
          new examples::image_pipe::ImagePipeSpinningCubeApp));
  return runner.Run(application_request);
}