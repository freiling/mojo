// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/application_test_base.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/public/cpp/environment/logging.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/public/cpp/utility/run_loop.h"
#include "mojo/services/gfx/display_manager/interfaces/display_manager.mojom.h"
#include "mojo/services/gfx/images/interfaces/image_pipe.mojom.h"

namespace mojo {
namespace {

// Testing DisplayManager's core purpose (putting pixels on the screen) is
// instrinsically difficult to do without a human to verify that the pixels are
// actually on the screen, so these tests mainly validate that the interface
// works as expected, and provides a basic sanity test that code changes dont
// totally break DisplayManager

class DisplayManagerApplicationTest : public test::ApplicationTestBase {
 public:
  DisplayManagerApplicationTest() : ApplicationTestBase() {}
  ~DisplayManagerApplicationTest() override {}

 private:
  MOJO_DISALLOW_COPY_AND_ASSIGN(DisplayManagerApplicationTest);
};

// Basic test that you can get an image pipe from the display manager iff there
// is support for ImagePipe based graphics on this platform
TEST_F(DisplayManagerApplicationTest, ProvidesImagePipe) {
  mojo::gfx::DisplayManagerPtr display_manager;
  bool display_manager_encountered_error = false;

  mojo::ConnectToService(application_impl()->shell(),
                         "mojo:display_manager_service",
                         GetProxy(&display_manager));

  mojo::gfx::ImagePipePtr image_pipe_ptr;
  mojo::gfx::SupportedImagePropertiesPtr supported_properties;

  display_manager->GetImagePipe(
      GetProxy(&image_pipe_ptr),
      [&supported_properties](
          mojo::gfx::SupportedImagePropertiesPtr supported_properties_in) {
        supported_properties = supported_properties_in.Pass();
      });
  if (!display_manager.WaitForIncomingResponse()) {
    display_manager_encountered_error = true;
  }

#ifdef MOJO_USE_IMAGE_PIPE
  EXPECT_FALSE(display_manager_encountered_error);
  EXPECT_TRUE(image_pipe_ptr);
  ASSERT_TRUE(supported_properties);
  EXPECT_GT(supported_properties->size->width, 0);
  EXPECT_GT(supported_properties->size->height, 0);
#else   // MOJO_USE_IMAGE_PIPE
  EXPECT_TRUE(display_manager_encountered_error);
#endif  // MOJO_USE_IMAGE_PIPE
}

#ifdef MOJO_USE_IMAGE_PIPE
// Tests that requesting a second image pipe from the same display manager fails
// This test will likely be deprecated as Display manager becomes more
// more sophisticated, but for now asking for a second image pipe is not handled
// in the display manager implementation
TEST_F(DisplayManagerApplicationTest, ProvidesOnlyOneImagePipe) {
  mojo::gfx::DisplayManagerPtr display_manager;

  mojo::ConnectToService(application_impl()->shell(),
                         "mojo:display_manager_service",
                         GetProxy(&display_manager));

  mojo::gfx::ImagePipePtr image_pipe_ptr;
  mojo::gfx::SupportedImagePropertiesPtr supported_properties;

  display_manager->GetImagePipe(
      GetProxy(&image_pipe_ptr),
      [&supported_properties](
          mojo::gfx::SupportedImagePropertiesPtr supported_properties_in) {
        supported_properties = supported_properties_in.Pass();
      });
  ASSERT_TRUE(display_manager.WaitForIncomingResponse());

  display_manager->GetImagePipe(
      GetProxy(&image_pipe_ptr),
      [&supported_properties](
          mojo::gfx::SupportedImagePropertiesPtr supported_properties_in) {
        supported_properties = supported_properties_in.Pass();
      });
  EXPECT_FALSE(display_manager.WaitForIncomingResponse());
}

#endif  // MOJO_USE_IMAGE_PIPE

}  // namespace
}  // namespace mojo
