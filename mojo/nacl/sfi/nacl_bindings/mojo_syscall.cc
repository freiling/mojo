// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// WARNING this file was generated by generate_nacl_bindings.py
// Do not edit by hand.

#include "mojo/nacl/sfi/nacl_bindings/mojo_syscall.h"

#include <stdio.h>

#include "mojo/nacl/sfi/nacl_bindings/mojo_syscall_internal.h"
#include "mojo/public/c/system/core.h"
#include "mojo/public/platform/native/system_impl_private.h"
#include "native_client/src/public/chrome_main.h"
#include "native_client/src/public/nacl_app.h"
#include "native_client/src/trusted/desc/nacl_desc_custom.h"

MojoHandle g_mojo_handle = MOJO_HANDLE_INVALID;
MojoSystemImpl g_mojo_system = nullptr;

namespace {

MojoResult _MojoGetInitialHandle(MojoHandle* handle) {
  *handle = g_mojo_handle;
  return MOJO_RESULT_OK;
}

void MojoDescDestroy(void* handle) {
}

ssize_t MojoDescSendMsg(void* handle,
                        const struct NaClImcTypedMsgHdr* msg,
                        int flags) {
  struct NaClApp* nap = static_cast<struct NaClApp*>(handle);

  if (msg->iov_length != 1 || msg->ndesc_length != 0) {
    return -1;
  }

  uint32_t volatile* params = static_cast<uint32_t volatile*>(msg->iov[0].base);
  size_t num_params = msg->iov[0].length / sizeof(*params);

  if (num_params < 1) {
    return -1;
  }

  uint32_t msg_type = params[0];
  switch (msg_type) {
    case 0: {
      if (num_params != 3) {
        return -1;
      }
      MojoHandle volatile* handle_ptr;
      MojoHandle handle_value;
      MojoResult volatile* result_ptr;
      MojoResult result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertScalarInOut(nap, params[1], false, &handle_value,
                                &handle_ptr)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[2], false, &result_ptr)) {
          return -1;
        }
      }

      result_value = _MojoGetInitialHandle(&handle_value);

      {
        ScopedCopyLock copy_lock(nap);
        *handle_ptr = handle_value;
        *result_ptr = result_value;
      }

      return 0;
    }
    case 1: {
      if (num_params != 2) {
        return -1;
      }
      MojoTimeTicks volatile* result_ptr;
      MojoTimeTicks result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertScalarOutput(nap, params[1], false, &result_ptr)) {
          return -1;
        }
      }

      result_value = MojoSystemImplGetTimeTicksNow(g_mojo_system);

      {
        ScopedCopyLock copy_lock(nap);
        *result_ptr = result_value;
      }

      return 0;
    }
    case 2: {
      if (num_params != 3) {
        return -1;
      }
      MojoHandle handle_value;
      MojoResult volatile* result_ptr;
      MojoResult result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertScalarInput(nap, params[1], &handle_value)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[2], false, &result_ptr)) {
          return -1;
        }
      }

      result_value = MojoSystemImplClose(g_mojo_system, handle_value);

      {
        ScopedCopyLock copy_lock(nap);
        *result_ptr = result_value;
      }

      return 0;
    }
    case 3: {
      if (num_params != 6) {
        return -1;
      }
      MojoHandle handle_value;
      MojoHandleSignals signals_value;
      MojoDeadline deadline_value;
      MojoHandleSignalsState volatile* signals_state_ptr;
      MojoHandleSignalsState signals_state_value;
      MojoResult volatile* result_ptr;
      MojoResult result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertScalarInput(nap, params[1], &handle_value)) {
          return -1;
        }
        if (!ConvertScalarInput(nap, params[2], &signals_value)) {
          return -1;
        }
        if (!ConvertScalarInput(nap, params[3], &deadline_value)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[4], true, &signals_state_ptr)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[5], false, &result_ptr)) {
          return -1;
        }
      }

      result_value = MojoSystemImplWait(
          g_mojo_system, handle_value, signals_value, deadline_value,
          signals_state_ptr ? &signals_state_value : nullptr);

      {
        ScopedCopyLock copy_lock(nap);
        if (signals_state_ptr) {
          memcpy_volatile_out(signals_state_ptr, &signals_state_value,
                              sizeof(MojoHandleSignalsState));
        }
        *result_ptr = result_value;
      }

      return 0;
    }
    case 4: {
      if (num_params != 8) {
        return -1;
      }
      const MojoHandle* handles;
      const MojoHandleSignals* signals;
      uint32_t num_handles_value;
      MojoDeadline deadline_value;
      uint32_t volatile* result_index_ptr;
      uint32_t result_index_value;
      struct MojoHandleSignalsState* signals_states;
      MojoResult volatile* result_ptr;
      MojoResult result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertScalarInput(nap, params[3], &num_handles_value)) {
          return -1;
        }
        if (!ConvertScalarInput(nap, params[4], &deadline_value)) {
          return -1;
        }
        if (!ConvertScalarInOut(nap, params[5], true, &result_index_value,
                                &result_index_ptr)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[7], false, &result_ptr)) {
          return -1;
        }
        if (!ConvertArray(nap, params[1], num_handles_value, sizeof(*handles),
                          false, &handles)) {
          return -1;
        }
        if (!ConvertArray(nap, params[2], num_handles_value, sizeof(*signals),
                          false, &signals)) {
          return -1;
        }
        if (!ConvertArray(nap, params[6], num_handles_value,
                          sizeof(*signals_states), true, &signals_states)) {
          return -1;
        }
      }

      result_value = MojoSystemImplWaitMany(
          g_mojo_system, handles, signals, num_handles_value, deadline_value,
          result_index_ptr ? &result_index_value : nullptr, signals_states);

      {
        ScopedCopyLock copy_lock(nap);
        if (result_index_ptr) {
          *result_index_ptr = result_index_value;
        }
        *result_ptr = result_value;
      }

      return 0;
    }
    case 5: {
      if (num_params != 5) {
        return -1;
      }
      const struct MojoCreateMessagePipeOptions* options;
      MojoHandle volatile* message_pipe_handle0_ptr;
      MojoHandle message_pipe_handle0_value;
      MojoHandle volatile* message_pipe_handle1_ptr;
      MojoHandle message_pipe_handle1_value;
      MojoResult volatile* result_ptr;
      MojoResult result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertExtensibleStructInput(nap, params[1], true, &options)) {
          return -1;
        }
        if (!ConvertScalarInOut(nap, params[2], false,
                                &message_pipe_handle0_value,
                                &message_pipe_handle0_ptr)) {
          return -1;
        }
        if (!ConvertScalarInOut(nap, params[3], false,
                                &message_pipe_handle1_value,
                                &message_pipe_handle1_ptr)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[4], false, &result_ptr)) {
          return -1;
        }
      }

      result_value = MojoSystemImplCreateMessagePipe(
          g_mojo_system, options, &message_pipe_handle0_value,
          &message_pipe_handle1_value);

      {
        ScopedCopyLock copy_lock(nap);
        *message_pipe_handle0_ptr = message_pipe_handle0_value;
        *message_pipe_handle1_ptr = message_pipe_handle1_value;
        *result_ptr = result_value;
      }

      return 0;
    }
    case 6: {
      if (num_params != 8) {
        return -1;
      }
      MojoHandle message_pipe_handle_value;
      const void* bytes;
      uint32_t num_bytes_value;
      const MojoHandle* handles;
      uint32_t num_handles_value;
      MojoWriteMessageFlags flags_value;
      MojoResult volatile* result_ptr;
      MojoResult result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertScalarInput(nap, params[1], &message_pipe_handle_value)) {
          return -1;
        }
        if (!ConvertScalarInput(nap, params[3], &num_bytes_value)) {
          return -1;
        }
        if (!ConvertScalarInput(nap, params[5], &num_handles_value)) {
          return -1;
        }
        if (!ConvertScalarInput(nap, params[6], &flags_value)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[7], false, &result_ptr)) {
          return -1;
        }
        if (!ConvertArray(nap, params[2], num_bytes_value, 1, true, &bytes)) {
          return -1;
        }
        if (!ConvertArray(nap, params[4], num_handles_value, sizeof(*handles),
                          true, &handles)) {
          return -1;
        }
      }

      result_value = MojoSystemImplWriteMessage(
          g_mojo_system, message_pipe_handle_value, bytes, num_bytes_value,
          handles, num_handles_value, flags_value);

      {
        ScopedCopyLock copy_lock(nap);
        *result_ptr = result_value;
      }

      return 0;
    }
    case 7: {
      if (num_params != 8) {
        return -1;
      }
      MojoHandle message_pipe_handle_value;
      void* bytes;
      uint32_t volatile* num_bytes_ptr;
      uint32_t num_bytes_value;
      MojoHandle* handles;
      uint32_t volatile* num_handles_ptr;
      uint32_t num_handles_value;
      MojoReadMessageFlags flags_value;
      MojoResult volatile* result_ptr;
      MojoResult result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertScalarInput(nap, params[1], &message_pipe_handle_value)) {
          return -1;
        }
        if (!ConvertScalarInOut(nap, params[3], true, &num_bytes_value,
                                &num_bytes_ptr)) {
          return -1;
        }
        if (!ConvertScalarInOut(nap, params[5], true, &num_handles_value,
                                &num_handles_ptr)) {
          return -1;
        }
        if (!ConvertScalarInput(nap, params[6], &flags_value)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[7], false, &result_ptr)) {
          return -1;
        }
        if (!ConvertArray(nap, params[2], num_bytes_value, 1, true, &bytes)) {
          return -1;
        }
        if (!ConvertArray(nap, params[4], num_handles_value, sizeof(*handles),
                          true, &handles)) {
          return -1;
        }
      }

      result_value = MojoSystemImplReadMessage(
          g_mojo_system, message_pipe_handle_value, bytes,
          num_bytes_ptr ? &num_bytes_value : nullptr, handles,
          num_handles_ptr ? &num_handles_value : nullptr, flags_value);

      {
        ScopedCopyLock copy_lock(nap);
        if (num_bytes_ptr) {
          *num_bytes_ptr = num_bytes_value;
        }
        if (num_handles_ptr) {
          *num_handles_ptr = num_handles_value;
        }
        *result_ptr = result_value;
      }

      return 0;
    }
    case 8: {
      if (num_params != 5) {
        return -1;
      }
      const struct MojoCreateDataPipeOptions* options;
      MojoHandle volatile* data_pipe_producer_handle_ptr;
      MojoHandle data_pipe_producer_handle_value;
      MojoHandle volatile* data_pipe_consumer_handle_ptr;
      MojoHandle data_pipe_consumer_handle_value;
      MojoResult volatile* result_ptr;
      MojoResult result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertExtensibleStructInput(nap, params[1], true, &options)) {
          return -1;
        }
        if (!ConvertScalarInOut(nap, params[2], false,
                                &data_pipe_producer_handle_value,
                                &data_pipe_producer_handle_ptr)) {
          return -1;
        }
        if (!ConvertScalarInOut(nap, params[3], false,
                                &data_pipe_consumer_handle_value,
                                &data_pipe_consumer_handle_ptr)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[4], false, &result_ptr)) {
          return -1;
        }
      }

      result_value = MojoSystemImplCreateDataPipe(
          g_mojo_system, options, &data_pipe_producer_handle_value,
          &data_pipe_consumer_handle_value);

      {
        ScopedCopyLock copy_lock(nap);
        *data_pipe_producer_handle_ptr = data_pipe_producer_handle_value;
        *data_pipe_consumer_handle_ptr = data_pipe_consumer_handle_value;
        *result_ptr = result_value;
      }

      return 0;
    }
    case 9: {
      if (num_params != 6) {
        return -1;
      }
      MojoHandle data_pipe_producer_handle_value;
      const void* elements;
      uint32_t volatile* num_bytes_ptr;
      uint32_t num_bytes_value;
      MojoWriteDataFlags flags_value;
      MojoResult volatile* result_ptr;
      MojoResult result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertScalarInput(nap, params[1],
                                &data_pipe_producer_handle_value)) {
          return -1;
        }
        if (!ConvertScalarInOut(nap, params[3], false, &num_bytes_value,
                                &num_bytes_ptr)) {
          return -1;
        }
        if (!ConvertScalarInput(nap, params[4], &flags_value)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[5], false, &result_ptr)) {
          return -1;
        }
        if (!ConvertArray(nap, params[2], num_bytes_value, 1, false,
                          &elements)) {
          return -1;
        }
      }

      result_value = MojoSystemImplWriteData(
          g_mojo_system, data_pipe_producer_handle_value, elements,
          &num_bytes_value, flags_value);

      {
        ScopedCopyLock copy_lock(nap);
        *num_bytes_ptr = num_bytes_value;
        *result_ptr = result_value;
      }

      return 0;
    }
    case 10:
      fprintf(stderr, "MojoBeginWriteData not implemented\n");
      return -1;
    case 11: {
      if (num_params != 4) {
        return -1;
      }
      MojoHandle data_pipe_producer_handle_value;
      uint32_t num_bytes_written_value;
      MojoResult volatile* result_ptr;
      MojoResult result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertScalarInput(nap, params[1],
                                &data_pipe_producer_handle_value)) {
          return -1;
        }
        if (!ConvertScalarInput(nap, params[2], &num_bytes_written_value)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[3], false, &result_ptr)) {
          return -1;
        }
      }

      result_value = MojoSystemImplEndWriteData(g_mojo_system,
                                                data_pipe_producer_handle_value,
                                                num_bytes_written_value);

      {
        ScopedCopyLock copy_lock(nap);
        *result_ptr = result_value;
      }

      return 0;
    }
    case 12: {
      if (num_params != 6) {
        return -1;
      }
      MojoHandle data_pipe_consumer_handle_value;
      void* elements;
      uint32_t volatile* num_bytes_ptr;
      uint32_t num_bytes_value;
      MojoReadDataFlags flags_value;
      MojoResult volatile* result_ptr;
      MojoResult result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertScalarInput(nap, params[1],
                                &data_pipe_consumer_handle_value)) {
          return -1;
        }
        if (!ConvertScalarInOut(nap, params[3], false, &num_bytes_value,
                                &num_bytes_ptr)) {
          return -1;
        }
        if (!ConvertScalarInput(nap, params[4], &flags_value)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[5], false, &result_ptr)) {
          return -1;
        }
        if (!ConvertArray(nap, params[2], num_bytes_value, 1, false,
                          &elements)) {
          return -1;
        }
      }

      result_value =
          MojoSystemImplReadData(g_mojo_system, data_pipe_consumer_handle_value,
                                 elements, &num_bytes_value, flags_value);

      {
        ScopedCopyLock copy_lock(nap);
        *num_bytes_ptr = num_bytes_value;
        *result_ptr = result_value;
      }

      return 0;
    }
    case 13:
      fprintf(stderr, "MojoBeginReadData not implemented\n");
      return -1;
    case 14: {
      if (num_params != 4) {
        return -1;
      }
      MojoHandle data_pipe_consumer_handle_value;
      uint32_t num_bytes_read_value;
      MojoResult volatile* result_ptr;
      MojoResult result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertScalarInput(nap, params[1],
                                &data_pipe_consumer_handle_value)) {
          return -1;
        }
        if (!ConvertScalarInput(nap, params[2], &num_bytes_read_value)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[3], false, &result_ptr)) {
          return -1;
        }
      }

      result_value = MojoSystemImplEndReadData(
          g_mojo_system, data_pipe_consumer_handle_value, num_bytes_read_value);

      {
        ScopedCopyLock copy_lock(nap);
        *result_ptr = result_value;
      }

      return 0;
    }
    case 15: {
      if (num_params != 5) {
        return -1;
      }
      const struct MojoCreateSharedBufferOptions* options;
      uint64_t num_bytes_value;
      MojoHandle volatile* shared_buffer_handle_ptr;
      MojoHandle shared_buffer_handle_value;
      MojoResult volatile* result_ptr;
      MojoResult result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertExtensibleStructInput(nap, params[1], true, &options)) {
          return -1;
        }
        if (!ConvertScalarInput(nap, params[2], &num_bytes_value)) {
          return -1;
        }
        if (!ConvertScalarInOut(nap, params[3], false,
                                &shared_buffer_handle_value,
                                &shared_buffer_handle_ptr)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[4], false, &result_ptr)) {
          return -1;
        }
      }

      result_value = MojoSystemImplCreateSharedBuffer(
          g_mojo_system, options, num_bytes_value, &shared_buffer_handle_value);

      {
        ScopedCopyLock copy_lock(nap);
        *shared_buffer_handle_ptr = shared_buffer_handle_value;
        *result_ptr = result_value;
      }

      return 0;
    }
    case 16: {
      if (num_params != 5) {
        return -1;
      }
      MojoHandle buffer_handle_value;
      const struct MojoDuplicateBufferHandleOptions* options;
      MojoHandle volatile* new_buffer_handle_ptr;
      MojoHandle new_buffer_handle_value;
      MojoResult volatile* result_ptr;
      MojoResult result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertScalarInput(nap, params[1], &buffer_handle_value)) {
          return -1;
        }
        if (!ConvertExtensibleStructInput(nap, params[2], true, &options)) {
          return -1;
        }
        if (!ConvertScalarInOut(nap, params[3], false, &new_buffer_handle_value,
                                &new_buffer_handle_ptr)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[4], false, &result_ptr)) {
          return -1;
        }
      }

      result_value = MojoSystemImplDuplicateBufferHandle(
          g_mojo_system, buffer_handle_value, options,
          &new_buffer_handle_value);

      {
        ScopedCopyLock copy_lock(nap);
        *new_buffer_handle_ptr = new_buffer_handle_value;
        *result_ptr = result_value;
      }

      return 0;
    }
    case 17: {
      if (num_params != 5) {
        return -1;
      }
      MojoHandle buffer_handle_value;
      struct MojoBufferInformation* info;
      uint32_t info_num_bytes_value;
      MojoResult volatile* result_ptr;
      MojoResult result_value;
      {
        ScopedCopyLock copy_lock(nap);
        if (!ConvertScalarInput(nap, params[1], &buffer_handle_value)) {
          return -1;
        }
        if (!ConvertScalarInput(nap, params[3], &info_num_bytes_value)) {
          return -1;
        }
        if (!ConvertScalarOutput(nap, params[4], false, &result_ptr)) {
          return -1;
        }
        if (!ConvertArray(nap, params[2], info_num_bytes_value, 1, false,
                          &info)) {
          return -1;
        }
      }

      result_value = MojoSystemImplGetBufferInformation(
          g_mojo_system, buffer_handle_value, info, info_num_bytes_value);

      {
        ScopedCopyLock copy_lock(nap);
        *result_ptr = result_value;
      }

      return 0;
    }
    case 18:
      fprintf(stderr, "MojoMapBuffer not implemented\n");
      return -1;
    case 19:
      fprintf(stderr, "MojoUnmapBuffer not implemented\n");
      return -1;
  }

  return -1;
}

ssize_t MojoDescRecvMsg(void* handle,
                        struct NaClImcTypedMsgHdr* msg,
                        int flags) {
  return -1;
}

struct NaClDesc* MakeMojoDesc(struct NaClApp* nap) {
  struct NaClDescCustomFuncs funcs = NACL_DESC_CUSTOM_FUNCS_INITIALIZER;
  funcs.Destroy = MojoDescDestroy;
  funcs.SendMsg = MojoDescSendMsg;
  funcs.RecvMsg = MojoDescRecvMsg;
  return NaClDescMakeCustomDesc(nap, &funcs);
}

void MojoDisabledDescDestroy(void* handle) {
}

ssize_t MojoDisabledDescSendMsg(void* handle,
                                const struct NaClImcTypedMsgHdr* msg,
                                int flags) {
  fprintf(stderr, "Mojo is not currently supported.");
  abort();
}

ssize_t MojoDisabledDescRecvMsg(void* handle,
                                struct NaClImcTypedMsgHdr* msg,
                                int flags) {
  fprintf(stderr, "Mojo is not currently supported.");
  abort();
}

struct NaClDesc* MakeDisabledMojoDesc(struct NaClApp* nap) {
  struct NaClDescCustomFuncs funcs = NACL_DESC_CUSTOM_FUNCS_INITIALIZER;
  funcs.Destroy = MojoDisabledDescDestroy;
  funcs.SendMsg = MojoDisabledDescSendMsg;
  funcs.RecvMsg = MojoDisabledDescRecvMsg;
  return NaClDescMakeCustomDesc(nap, &funcs);
}

}  // namespace

// The value for this FD must not conflict with uses inside Chromium. However,
// mojo/nacl doesn't depend on any Chromium headers, so we can't use a #define
// from there.
#define NACL_MOJO_DESC (NACL_CHROME_DESC_BASE + 3)

MojoResult InjectMojo(struct NaClApp* nap, MojoHandle handle) {
  NaClAppSetDesc(nap, NACL_MOJO_DESC, MakeMojoDesc(nap));
  g_mojo_system = MojoSystemImplCreateImpl();
  return MojoSystemImplTransferHandle(MojoSystemImplGetDefaultImpl(), handle,
                                      g_mojo_system, &g_mojo_handle);
}

void InjectDisabledMojo(struct NaClApp* nap) {
  NaClAppSetDesc(nap, NACL_MOJO_DESC, MakeDisabledMojoDesc(nap));
}
