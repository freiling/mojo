// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <GLES2/gl2.h>
#include <stdint.h>

#ifndef EXAMPLES_IMAGE_PIPE_GLES2_IMAGE_COMPOSITOR_GLES2_COMPOSITOR_H_
#define EXAMPLES_IMAGE_PIPE_GLES2_IMAGE_COMPOSITOR_GLES2_COMPOSITOR_H_

class GLES2Compositor {
public:
	GLES2Compositor();
	~GLES2Compositor();
	bool Initialize(uint32_t width, uint32_t height);
	void Draw(GLuint gles2_producer_texture);
private:
	uint32_t width_;
	uint32_t height_;

	GLuint program_object_;

	GLint location_position_;
	GLint location_tex_coord_;
	GLint location_sampler_;

	GLuint vbo_position_;
	GLuint vbo_tex_coord_;
	uint32_t num_vertices_;
};

#endif //EXAMPLES_IMAGE_PIPE_GLES2_IMAGE_COMPOSITOR_GLES2_COMPOSITOR_H_