// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_SURFACES_APP_EMBEDDER_H_
#define EXAMPLES_SURFACES_APP_EMBEDDER_H_

#include "base/memory/scoped_ptr.h"
#include "cc/surfaces/surface_id.h"
#include "mojo/services/surfaces/public/interfaces/surfaces.mojom.h"
#include "ui/gfx/size.h"

namespace cc {
class CompositorFrame;
}

namespace mojo {

class ApplicationConnection;

namespace examples {

// Simple example of a surface embedder that embeds two other surfaces.
class Embedder {
 public:
  Embedder(uint32_t local_id, Surface* surface);
  ~Embedder();

  void ProduceFrame(cc::SurfaceId child_one,
                    cc::SurfaceId child_two,
                    const gfx::Size& child_size,
                    const gfx::Size& size,
                    int offset);

 private:
  uint32_t local_id_;
  Surface* surface_;

  DISALLOW_COPY_AND_ASSIGN(Embedder);
};

}  // namespace examples
}  // namespace mojo

#endif  // EXAMPLES_SURFACES_APP_EMBEDDER_H_
