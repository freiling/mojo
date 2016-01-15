// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/display_manager/image_pipe_delegate_xcb.h"
#include <xcb/xcb.h>
#include <xcb/dri3.h>
#include <xcb/present.h>

namespace display_manager {

ImagePipeDelegateXCB::ImagePipeDelegateXCB(
    mojo::InterfaceRequest<mojo::gfx::ImagePipe> request,
    const mojo::gfx::DisplayManager::GetImagePipeCallback& callback) {
  width_ = 1920;
  height_ = 1080;
  mojo::gfx::SupportedImagePropertiesPtr supported_properties =
      mojo::gfx::SupportedImageProperties::New();
  supported_properties->size = mojo::Size::New();
  supported_properties->size->width = static_cast<int32_t>(width_);
  supported_properties->size->height = static_cast<int32_t>(height_);

  supported_properties->formats =
      mojo::Array<mojo::gfx::ColorFormatPtr>::New(0);
  mojo::gfx::ColorFormatPtr format = mojo::gfx::ColorFormat::New();
  format->layout = mojo::gfx::PixelLayout::BGRA_8888;
  format->color_space = mojo::gfx::ColorSpace::SRGB;
  supported_properties->formats.push_back(format.Pass());
  callback.Run(supported_properties.Clone());

  image_pipe_.reset(
      new image_pipe::ImagePipeConsumerEndpoint(request.Pass(), this));
}

bool ImagePipeDelegateXCB::Initialize() {
  if (!InitConnection()) {
    return false;
  }

  if (!CreateWindow()) {
    return false;
  }

  return true;
}

ImagePipeDelegateXCB::~ImagePipeDelegateXCB() {
  xcb_destroy_window(connection_, window_);
  xcb_disconnect(connection_);
  free(atom_wm_delete_window_);
}

void ImagePipeDelegateXCB::AddImage(mojo::gfx::ImagePtr image, uint32_t id) {
  XcbMojoImage mojo_image;

  if (image->size->width != static_cast<int32_t>(width_) ||
      image->size->height != static_cast<int32_t>(height_))
    return;

  MojoResult result = MojoExtractPlatformHandle(
      image->buffer->data.get().value(), &mojo_image.fd);
  DCHECK_EQ(result, MOJO_RESULT_OK);

  DCHECK_GE(mojo_image.fd, 0);

  uint32_t bpp = 32;
  uint32_t depth = 24;
  mojo_image.pixmap = xcb_generate_id(connection_);

  auto cookie = xcb_dri3_pixmap_from_buffer_checked(
      connection_, mojo_image.pixmap, window_, image->buffer->size, width_,
      height_, image->stride, depth, bpp, mojo_image.fd);

  mojo_image.busy = false;

  xcb_discard_reply(connection_, cookie.sequence);

  image_map_[id] = mojo_image;
}

void ImagePipeDelegateXCB::RemoveImage(uint32_t id) {
  auto it = image_map_.find(id);
  if (it != image_map_.end()) {
    image_map_.erase(it);
  }
}

void ImagePipeDelegateXCB::PresentImage(uint32_t id) {
  xcb_flush(connection_);

  uint32_t acquired_id;
  if (!image_pipe_->AcquireNextImage(&acquired_id))
    return;

  auto it = image_map_.find(acquired_id);
  if (it == image_map_.end()) {
    image_pipe_->ReleaseImage(
        acquired_id,
        mojo::gfx::PresentationStatus::NOT_PRESENTED_INVALID_PROPERTIES);
    return;
  }

  XcbMojoImage image = it->second;

  auto cookie = xcb_copy_area(connection_, image.pixmap, window_, gc_, 0, 0, 0,
                              0, width_, height_);

  xcb_discard_reply(connection_, cookie.sequence);

  auto geom_cookie = xcb_get_geometry(connection_, window_);
  image.busy = true;

  xcb_generic_error_t* err;
  std::unique_ptr<xcb_get_geometry_reply_t, base::FreeDeleter> geom(
      xcb_get_geometry_reply(connection_, geom_cookie, &err));
  std::unique_ptr<xcb_generic_error_t, base::FreeDeleter> scoped_error;

  if (!geom) {
    LOG(ERROR) << "XcbImagePipeDelegate geom nullptr for image " << acquired_id
               << "xcb error %d\n",
        scoped_error->error_code;
  }

  if (geom->width != width_ || geom->height != height_) {
    LOG(ERROR) << "XcbImagePipeDelegate geom different than stored "
               << acquired_id;
  }

  image.busy = false;

  xcb_flush(connection_);

  image_pipe_->ReleaseImage(acquired_id,
                            mojo::gfx::PresentationStatus::PRESENTED);
}

void ImagePipeDelegateXCB::HandleEndpointClosed() {}

bool ImagePipeDelegateXCB::InitConnection() {
  const xcb_setup_t* setup;
  xcb_screen_iterator_t iter;
  int scr;

  connection_ = xcb_connect(nullptr, &scr);
  if (connection_ == nullptr) {
    LOG(FATAL) << "Cannot connect to display server\n Exiting ...";
    return false;
  }

  setup = xcb_get_setup(connection_);
  iter = xcb_setup_roots_iterator(setup);
  while (scr-- > 0)
    xcb_screen_next(&iter);

  screen_ = iter.data;
  return true;
}

bool ImagePipeDelegateXCB::CreateWindow() {
  uint32_t value_mask;
  uint32_t value_list[32];

  window_ = xcb_generate_id(connection_);

  value_mask = XCB_CW_BACK_PIXEL | XCB_CW_EVENT_MASK;
  value_list[0] = screen_->black_pixel;
  value_list[1] = XCB_EVENT_MASK_KEY_RELEASE | XCB_EVENT_MASK_EXPOSURE |
                  XCB_EVENT_MASK_STRUCTURE_NOTIFY;

  xcb_create_window(connection_, XCB_COPY_FROM_PARENT, window_, screen_->root,
                    0, 0, width_, height_, 0, XCB_WINDOW_CLASS_INPUT_OUTPUT,
                    screen_->root_visual, value_mask, value_list);

  xcb_intern_atom_reply_t* reply = xcb_intern_atom_reply(
      connection_, xcb_intern_atom(connection_, 1, 12, "WM_PROTOCOLS"), 0);

  atom_wm_delete_window_ = xcb_intern_atom_reply(
      connection_, xcb_intern_atom(connection_, 0, 16, "WM_DELETE_WINDOW"), 0);

  xcb_change_property(connection_, XCB_PROP_MODE_REPLACE, window_, reply->atom,
                      4, 32, 1, &(*atom_wm_delete_window_).atom);
  free(reply);

  xcb_map_window(connection_, window_);

  gc_ = static_cast<xcb_gc_t>(xcb_generate_id(connection_));
  if (!gc_) {
    LOG(ERROR) << "XcbImagePipeDelegate unable to create graphics context";
    return false;
  }

  xcb_discard_reply(connection_,
                    xcb_create_gc(connection_, gc_, window_,
                                  XCB_GC_GRAPHICS_EXPOSURES, (uint32_t[]){0})
                        .sequence);
  return true;
}

}  // namespace display_manager