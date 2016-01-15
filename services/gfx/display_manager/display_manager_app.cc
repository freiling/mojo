// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/utility/run_loop.h"

#include "services/gfx/display_manager/display_manager_app.h"
#include "services/gfx/display_manager/display_manager_impl.h"

namespace display_manager {

DisplayManagerAppDelegate::DisplayManagerAppDelegate() {}
DisplayManagerAppDelegate::~DisplayManagerAppDelegate() {}

void DisplayManagerAppDelegate::Initialize(mojo::ApplicationImpl* application) {
  application_ = application;
}

bool DisplayManagerAppDelegate::ConfigureIncomingConnection(
    mojo::ApplicationConnection* connection) {
  connection->AddService<mojo::gfx::DisplayManager>(this);
  return true;
}

void DisplayManagerAppDelegate::Create(
    mojo::ApplicationConnection* connection,
    mojo::InterfaceRequest<mojo::gfx::DisplayManager> request) {
  new DisplayManagerImpl(request.Pass());
}
}

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunner runner(
      std::unique_ptr<display_manager::DisplayManagerAppDelegate>(
          new display_manager::DisplayManagerAppDelegate));
  return runner.Run(application_request);
}