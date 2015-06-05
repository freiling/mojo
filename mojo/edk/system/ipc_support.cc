// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/edk/system/ipc_support.h"

#include "base/logging.h"
#include "mojo/edk/embedder/master_process_delegate.h"
#include "mojo/edk/embedder/slave_process_delegate.h"
#include "mojo/edk/system/channel_manager.h"
#include "mojo/edk/system/master_connection_manager.h"
#include "mojo/edk/system/slave_connection_manager.h"

namespace mojo {
namespace system {

IPCSupport::IPCSupport(
    embedder::PlatformSupport* platform_support,
    embedder::ProcessType process_type,
    scoped_refptr<base::TaskRunner> delegate_thread_task_runner,
    embedder::ProcessDelegate* process_delegate,
    scoped_refptr<base::TaskRunner> io_thread_task_runner,
    embedder::ScopedPlatformHandle platform_handle)
    : process_type_(process_type),
      delegate_thread_task_runner_(delegate_thread_task_runner.Pass()),
      process_delegate_(process_delegate),
      io_thread_task_runner_(io_thread_task_runner.Pass()) {
  DCHECK(delegate_thread_task_runner_);
  DCHECK(io_thread_task_runner_);

  switch (process_type_) {
    case embedder::ProcessType::UNINITIALIZED:
      CHECK(false);
      break;
    case embedder::ProcessType::NONE:
      DCHECK(!platform_handle.is_valid());  // We wouldn't do anything with it.
      // Nothing to do.
      break;
    case embedder::ProcessType::MASTER:
      DCHECK(!platform_handle.is_valid());  // We wouldn't do anything with it.
      connection_manager_.reset(
          new system::MasterConnectionManager(platform_support));
      static_cast<system::MasterConnectionManager*>(connection_manager_.get())
          ->Init(
              delegate_thread_task_runner_,
              static_cast<embedder::MasterProcessDelegate*>(process_delegate_));
      break;
    case embedder::ProcessType::SLAVE:
      connection_manager_.reset(
          new system::SlaveConnectionManager(platform_support));
      static_cast<system::SlaveConnectionManager*>(connection_manager_.get())
          ->Init(
              delegate_thread_task_runner_,
              static_cast<embedder::SlaveProcessDelegate*>(process_delegate_),
              platform_handle.Pass());
      break;
  }

  channel_manager_.reset(new ChannelManager(
      platform_support, io_thread_task_runner_, connection_manager_.get()));
}

IPCSupport::~IPCSupport() {
  DCHECK_EQ(process_type_, embedder::ProcessType::UNINITIALIZED);
}

void IPCSupport::ShutdownOnIOThread() {
  DCHECK_NE(process_type_, embedder::ProcessType::UNINITIALIZED);

  channel_manager_->ShutdownOnIOThread();
  channel_manager_.reset();

  if (connection_manager_) {
    connection_manager_->Shutdown();
    connection_manager_.reset();
  }

  io_thread_task_runner_ = nullptr;
  process_delegate_ = nullptr;
  delegate_thread_task_runner_ = nullptr;
  process_type_ = embedder::ProcessType::UNINITIALIZED;
}

}  // namespace system
}  // namespace mojo