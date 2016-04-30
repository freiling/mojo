// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
#include "examples/image_pipe/gles2_image_compositor/gles2_compositor.h"

#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>
#include <string>
#include "mojo/public/c/gpu/MGL/mgl.h"
#include "mojo/public/cpp/environment/logging.h"

GLES2Compositor::GLES2Compositor(){}

GLES2Compositor::~GLES2Compositor(){}

GLuint LoadShader(GLenum type,
                  const char* shader_source) {
  GLuint shader = glCreateShader(type);
  glShaderSource(shader, 1, &shader_source, NULL);
  glCompileShader(shader);

  GLint compiled = 0;
  glGetShaderiv(shader, GL_COMPILE_STATUS, &compiled);

  if (!compiled) {
    GLsizei expected_length = 0;
    glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &expected_length);
    std::string log;
    log.resize(expected_length);  // Includes null terminator.
    GLsizei actual_length = 0;
    glGetShaderInfoLog(shader, expected_length, &actual_length, &log[0]);
    log.resize(actual_length);  // Excludes null terminator.
    MOJO_LOG(ERROR) << "Compilation of shader failed: " << log;
    glDeleteShader(shader);
    return 0;
  }

  return shader;
}

GLuint LoadProgram(const char* vertex_shader_source,
                   const char* fragment_shader_source) {
  GLuint vertex_shader = LoadShader(GL_VERTEX_SHADER,
                                    vertex_shader_source);
  if (!vertex_shader)
    return 0;

  GLuint fragment_shader = LoadShader(GL_FRAGMENT_SHADER,
                                      fragment_shader_source);
  if (!fragment_shader) {
    glDeleteShader(vertex_shader);
    return 0;
  }

  GLuint program_object = glCreateProgram();
  glAttachShader(program_object, vertex_shader);
  glAttachShader(program_object, fragment_shader);
  glLinkProgram(program_object);
  glDeleteShader(vertex_shader);
  glDeleteShader(fragment_shader);

  GLint linked = 0;
  glGetProgramiv(program_object, GL_LINK_STATUS, &linked);
  if (!linked) {
    GLsizei expected_length = 0;
    glGetProgramiv(program_object, GL_INFO_LOG_LENGTH, &expected_length);
    std::string log;
    log.resize(expected_length);  // Includes null terminator.
    GLsizei actual_length = 0;
    glGetProgramInfoLog(program_object, expected_length, &actual_length,
                        &log[0]);
    log.resize(actual_length);  // Excludes null terminator.
    MOJO_LOG(ERROR) << "Linking program failed: " << log;
    glDeleteProgram(program_object);
    return 0;
  }

  return program_object;
}

bool GLES2Compositor::Initialize(uint32_t width, uint32_t height){
	width_ = width;
	height_ = height;

  static const char *vertex_shader_source = 
    "attribute highp vec2 a_position;\n"
    "attribute highp vec2 a_texcoord;\n"
    "varying vec2 v_texcoord;\n"
    "void main()\n"
    "{\n"
    "  v_texcoord = a_texcoord;\n"
    "  gl_Position = vec4(a_position, 0, 1);\n"
    "}\n";

  static const char *fragment_shader_source =
    "uniform sampler2D u_sampler;\n"
    "varying highp vec2 v_texcoord;\n"
    "void main()\n"
    "{\n"
        "gl_FragColor = texture2D(u_sampler, v_texcoord);\n"
    "}\n";

  program_object_ = LoadProgram(vertex_shader_source, fragment_shader_source);
  if(!program_object_){
  	return false;
  }

  location_position_ = glGetAttribLocation(
      program_object_, "a_position");
  location_tex_coord_ = glGetAttribLocation(
      program_object_, "a_texcoord");
  location_sampler_ = glGetUniformLocation(
  		program_object_, "u_sampler");
  if(location_position_ < 0 || location_tex_coord_ < 0 || location_sampler_ < 0){
  	MOJO_LOG(ERROR) << "failed to get vertex attribute positions:\n" 
  						<< "location_position_: " << location_position_ << "\n"
  						<< "location_tex_coord_: " << location_tex_coord_ << "\n"
  						<< "location_sampler_: " << location_sampler_ << "\n";
  	return false;
  }

  static const GLfloat positions[] = {
      -1.0f, -1.0f,
      1.0f, -1.0f,
      -1.0f,  1.0f,
      1.0f,  1.0f,
  };

  static const GLfloat tex_coords[] = {
      0.0f,  0.0f,
      1.0f, 0.0f,
      0.0f,  1.0f,
      1.0f, 1.0f,
  };

 	glGenBuffers(1, &vbo_position_);
  glBindBuffer(GL_ARRAY_BUFFER, vbo_position_);
  glBufferData(GL_ARRAY_BUFFER,
               sizeof(positions),
               positions,
               GL_STATIC_DRAW);

 	glGenBuffers(1, &vbo_tex_coord_);
  glBindBuffer(GL_ARRAY_BUFFER, vbo_tex_coord_);
  glBufferData(GL_ARRAY_BUFFER,
               sizeof(tex_coords),
               tex_coords,
               GL_STATIC_DRAW);

  glBindBuffer(GL_ARRAY_BUFFER, 0);

  num_vertices_ = sizeof(positions) / sizeof(GLfloat) / 2;
  return true;
}

void GLES2Compositor::Draw(GLuint gles2_producer_texture){
	
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  glUseProgram(program_object_);

  glBindBuffer(GL_ARRAY_BUFFER, vbo_position_);
  glVertexAttribPointer(location_position_, 2, GL_FLOAT, GL_FALSE,
                        0, 0);
  glEnableVertexAttribArray(location_position_);

  glBindBuffer(GL_ARRAY_BUFFER, vbo_tex_coord_);
  glVertexAttribPointer(location_tex_coord_, 2, GL_FLOAT, GL_FALSE,
                        0, 0);
	glEnableVertexAttribArray(location_tex_coord_);

	glUniform1i(location_sampler_, 0);
	glActiveTexture(GL_TEXTURE0);

	glBindTexture(GL_TEXTURE_2D, gles2_producer_texture);
  glViewport(0, 0, width_/2, height_);
  glDrawArrays(GL_TRIANGLE_STRIP, 0, num_vertices_);

  glDisableVertexAttribArray(location_position_);
  glDisableVertexAttribArray(location_tex_coord_);

}
