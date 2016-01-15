// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_DISPLAY_MANAGER_APP_H_
#define SERVICES_GFX_DISPLAY_MANAGER_APP_H_

#include "base/macros.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/services/gfx/display_manager/interfaces/display_manager.mojom.h"

namespace display_manager {

class DisplayManagerAppDelegate
    : public mojo::ApplicationDelegate,
      public mojo::InterfaceFactory<mojo::gfx::DisplayManager> {
 public:
  DisplayManagerAppDelegate();
  ~DisplayManagerAppDelegate() override;

 private:
  // mojo::ApplicationDelegate implementation.
  void Initialize(mojo::ApplicationImpl* application) override;

  bool ConfigureIncomingConnection(
      mojo::ApplicationConnection* connection) override;

  // mojo::InterfaceFactory<mojo::gfx::DisplayManager> implementation.
  void Create(
      mojo::ApplicationConnection* connection,
      mojo::InterfaceRequest<mojo::gfx::DisplayManager> request) override;

  mojo::ApplicationImpl* application_;

  DISALLOW_COPY_AND_ASSIGN(DisplayManagerAppDelegate);
};
}

#endif  // SERVICES_GFX_DISPLAY_MANAGER_APP_H_