// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "image_compositor_image_pipe_delegate.h"


#ifndef GL_GLEXT_PROTOTYPES
#define GL_GLEXT_PROTOTYPES
#endif  // GL_GLEXT_PROTOTYPES

#include <GLES2/gl2.h>
#include <GLES2/gl2extmojo.h>

namespace examples {
namespace image_pipe {  

GLES2ImageCompositorImagePipeDelegate::GLES2ImageCompositorImagePipeDelegate(
  mojo::InterfaceRequest<mojo::gfx::ImagePipe> request,
  mojo::gfx::SupportedImagePropertiesPtr supported_properties)
	:supported_properties_(supported_properties.Pass())
  mojo::gfx::SupportedImagePropertiesPtr supported_properties,
  std::function<void ()> present_callback,
  std::string delegate_name)
	:supported_properties_(supported_properties.Pass()), present_callback_(present_callback), delegate_name_(delegate_name)
{
	image_pipe_.reset(new ::image_pipe::ImagePipeConsumerEndpoint(
      request.Pass(), supported_properties_.Clone(), this));
}
GLES2ImageCompositorImagePipeDelegate::~GLES2ImageCompositorImagePipeDelegate() {}


// ImagePipeConsumerDelegate implementation
void GLES2ImageCompositorImagePipeDelegate::AddImage(mojo::gfx::ImagePtr image, uint32_t id){
	LOG(ERROR) << "Producer added image with ID " << id;
	glImportImagePipeImageCHROMIUM(image->buffer->data.release().value(), image->size->width, image->size->width);
	LOG(ERROR) << delegate_name_ << " added image with ID " << id;

	auto mgl_image = glMGLCreateImageCHROMIUM(image->buffer->data.release().value(), image->size->width, image->size->height, image->stride, GL_RGBA);
	LOG(ERROR) << "glMGLCreateImageCHROMIUM returned id " << mgl_image;

	GLuint texture;
	glGenTextures(1, &texture);
	glBindTexture(GL_TEXTURE_2D, texture);
	glMGLImageTargetTexture2DCHROMIUM(GL_TEXTURE_2D, mgl_image);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

	image_map_[id] = {id, texture, mgl_image};

}
void GLES2ImageCompositorImagePipeDelegate::RemoveImage(uint32_t id) {
	auto image_iter = image_map_.find(id);
	DCHECK(image_iter != image_map_.end());
	auto image = image_iter->second;

	glMGLDestroyImageCHROMIUM(image.mgl_image);
	glDeleteTextures(1, &(image.texture));
	image_map_.erase(image_iter);

}

void GLES2ImageCompositorImagePipeDelegate::PresentImage(uint32_t id) {
	if(frame_count_ % frames_per_interval_ == 0){
		timing_interval_end_ = mojo::GetTimeTicksNow();
		if(frame_count_ != 0){
			MojoTimeTicks ticks_per_second = 1000 * 1000;
			double fps = 1/((timing_interval_end_ - timing_interval_start_) / ((float) frames_per_interval_)) * ticks_per_second;
			printf("%s framerate: %f FPS\n", delegate_name_.c_str(), fps);
		}
		timing_interval_start_ = timing_interval_end_;
	}
	frame_count_++;

	present_callback_();
	
}

bool GLES2ImageCompositorImagePipeDelegate::AcquireImage(struct Image *out_image){
	uint32_t acquired_id;
	if (!image_pipe_->AcquireNextImage(&acquired_id)){
	    return false;
	}
	*out_image = image_map_[acquired_id];
	return true;

}

void GLES2ImageCompositorImagePipeDelegate::ReleaseImage(struct Image image, mojo::gfx::PresentationStatus status){
	image_pipe_->ReleaseImage(image.id, status);
}

} // namespace image_pipe
} // namespace examples