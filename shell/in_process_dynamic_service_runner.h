// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SHELL_IN_PROCESS_DYNAMIC_SERVICE_RUNNER_H_
#define SHELL_IN_PROCESS_DYNAMIC_SERVICE_RUNNER_H_

#include "base/callback.h"
#include "base/files/file_path.h"
#include "base/macros.h"
#include "base/scoped_native_library.h"
#include "base/threading/simple_thread.h"
#include "shell/dynamic_service_runner.h"

namespace mojo {
namespace shell {

// An implementation of |DynamicServiceRunner| that loads/runs the given app
// (from the file system) on a separate thread (in the current process).
class InProcessDynamicServiceRunner
    : public DynamicServiceRunner,
      public base::DelegateSimpleThread::Delegate {
 public:
  explicit InProcessDynamicServiceRunner(Context* context);
  ~InProcessDynamicServiceRunner() override;

  // |DynamicServiceRunner| method:
  void Start(const base::FilePath& app_path,
             DynamicServiceRunner::CleanupBehavior cleanup_behavior,
             InterfaceRequest<Application> application_request,
             const base::Closure& app_completed_callback) override;

 private:
  // |base::DelegateSimpleThread::Delegate| method:
  void Run() override;

  base::FilePath app_path_;
  DynamicServiceRunner::CleanupBehavior cleanup_behavior_;
  InterfaceRequest<Application> application_request_;
  base::Callback<bool(void)> app_completed_callback_runner_;

  base::ScopedNativeLibrary app_library_;
  scoped_ptr<base::DelegateSimpleThread> thread_;

  DISALLOW_COPY_AND_ASSIGN(InProcessDynamicServiceRunner);
};

typedef DynamicServiceRunnerFactoryImpl<InProcessDynamicServiceRunner>
    InProcessDynamicServiceRunnerFactory;

}  // namespace shell
}  // namespace mojo

#endif  // SHELL_IN_PROCESS_DYNAMIC_SERVICE_RUNNER_H_
