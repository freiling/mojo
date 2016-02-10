// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_tree_state.h"

#include "base/bind.h"
#include "base/logging.h"
#include "base/strings/stringprintf.h"
#include "services/ui/view_manager/view_registry.h"
#include "services/ui/view_manager/view_state.h"
#include "services/ui/view_manager/view_stub.h"
#include "services/ui/view_manager/view_tree_host_impl.h"

namespace view_manager {

ViewTreeState::ViewTreeState(
    ViewRegistry* registry,
    mojo::ui::ViewTreePtr view_tree,
    mojo::ui::ViewTreeTokenPtr view_tree_token,
    mojo::InterfaceRequest<mojo::ui::ViewTreeHost> view_tree_host_request,
    const std::string& label)
    : view_tree_(view_tree.Pass()),
      view_tree_token_(view_tree_token.Pass()),
      label_(label),
      impl_(new ViewTreeHostImpl(registry, this)),
      host_binding_(impl_.get(), view_tree_host_request.Pass()),
      weak_factory_(this) {
  DCHECK(view_tree_);
  DCHECK(view_tree_token_);

  view_tree_.set_connection_error_handler(
      base::Bind(&ViewRegistry::OnViewTreeDied, base::Unretained(registry),
                 base::Unretained(this), "ViewTree connection closed"));
  host_binding_.set_connection_error_handler(
      base::Bind(&ViewRegistry::OnViewTreeDied, base::Unretained(registry),
                 base::Unretained(this), "ViewTreeHost connection closed"));
}

ViewTreeState::~ViewTreeState() {}

void ViewTreeState::LinkRoot(uint32_t key, std::unique_ptr<ViewStub> root) {
  DCHECK(!root_);
  DCHECK(root);
  DCHECK(!root->is_linked());
  root->SetTree(this, key);
  root_ = std::move(root);
}

std::unique_ptr<ViewStub> ViewTreeState::UnlinkRoot() {
  DCHECK(root_);
  root_->Unlink();
  return std::move(root_);
}

const std::string& ViewTreeState::FormattedLabel() const {
  if (formatted_label_cache_.empty()) {
    formatted_label_cache_ =
        label_.empty() ? base::StringPrintf("<%d>", view_tree_token_->value)
                       : base::StringPrintf("<%d:%s>", view_tree_token_->value,
                                            label_.c_str());
  }
  return formatted_label_cache_;
}

std::ostream& operator<<(std::ostream& os, ViewTreeState* view_tree_state) {
  if (!view_tree_state)
    return os << "null";
  return os << view_tree_state->FormattedLabel();
}

}  // namespace view_manager
