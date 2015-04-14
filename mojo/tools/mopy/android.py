# Copyright 2014 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

import atexit
import itertools
import json
import logging
import os
import os.path
import random
import subprocess
import sys
import threading
import time
import urlparse

import SimpleHTTPServer
import SocketServer

from mopy.config import Config
from mopy.paths import Paths


# Tags used by the mojo shell application logs.
LOGCAT_TAGS = [
    'AndroidHandler',
    'MojoFileHelper',
    'MojoMain',
    'MojoShellActivity',
    'MojoShellApplication',
    'chromium',
]

ADB_PATH = os.path.join(Paths().src_root, 'third_party', 'android_tools', 'sdk',
                        'platform-tools', 'adb')

MOJO_SHELL_PACKAGE_NAME = 'org.chromium.mojo.shell'

MAPPING_PREFIX = '--map-origin='

DEFAULT_BASE_PORT = 31337


_logger = logging.getLogger()


class _SilentTCPServer(SocketServer.TCPServer):
  """
  A TCPServer that won't display any error, unless debugging is enabled. This is
  useful because the client might stop while it is fetching an URL, which causes
  spurious error messages.
  """
  def handle_error(self, request, client_address):
    """
    Override the base class method to have conditional logging.
    """
    if logging.getLogger().isEnabledFor(logging.DEBUG):
      SocketServer.TCPServer.handle_error(self, request, client_address)


def _GetHandlerClassForPath(base_path):
  class RequestHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):
    """
    Handler for SocketServer.TCPServer that will serve the files from
    |base_path| directory over http.
    """

    def translate_path(self, path):
      path_from_current = (
          SimpleHTTPServer.SimpleHTTPRequestHandler.translate_path(self, path))
      return os.path.join(base_path, os.path.relpath(path_from_current))

    def log_message(self, *_):
      """
      Override the base class method to disable logging.
      """
      pass

  return RequestHandler


def _ExitIfNeeded(process):
  """
  Exits |process| if it is still alive.
  """
  if process.poll() is None:
    process.kill()


def _ReadFifo(fifo_path, pipe, on_fifo_closed, max_attempts=5):
  """
  Reads |fifo_path| on the device and write the contents to |pipe|. Calls
  |on_fifo_closed| when the fifo is closed. This method will try to find the
  path up to |max_attempts|, waiting 1 second between each attempt. If it cannot
  find |fifo_path|, a exception will be raised.
  """
  def Run():
    def _WaitForFifo():
      command = [ADB_PATH, 'shell', 'test -e "%s"; echo $?' % fifo_path]
      for _ in xrange(max_attempts):
        if subprocess.check_output(command)[0] == '0':
          return
        time.sleep(1)
      if on_fifo_closed:
        on_fifo_closed()
      raise Exception("Unable to find fifo.")
    _WaitForFifo()
    stdout_cat = subprocess.Popen([ADB_PATH,
                                   'shell',
                                   'cat',
                                   fifo_path],
                                  stdout=pipe)
    atexit.register(_ExitIfNeeded, stdout_cat)
    stdout_cat.wait()
    if on_fifo_closed:
      on_fifo_closed()

  thread = threading.Thread(target=Run, name="StdoutRedirector")
  thread.start()


def _MapPort(device_port, host_port):
  """
  Maps the device port to the host port. If |device_port| is 0, a random
  available port is chosen. Returns the device port.
  """
  def _FindAvailablePortOnDevice():
    opened = subprocess.check_output([ADB_PATH, 'shell', 'netstat'])
    opened = [int(x.strip().split()[3].split(':')[1])
              for x in opened if x.startswith(' tcp')]
    while True:
      port = random.randint(4096, 16384)
      if port not in opened:
        return port
  if device_port == 0:
    device_port = _FindAvailablePortOnDevice()
  subprocess.Popen([ADB_PATH,
                    "reverse",
                    "tcp:%d" % device_port,
                    "tcp:%d" % host_port]).wait()
  def _UnmapPort():
    subprocess.Popen([ADB_PATH, "reverse", "--remove",  "tcp:%d" % device_port])
  atexit.register(_UnmapPort)
  return device_port


def Split(l, pred):
  positive = []
  negative = []
  for v in l:
    if pred(v):
      positive.append(v)
    else:
      negative.append(v)
  return (positive, negative)


def StartHttpServerForDirectory(path, port=0):
  """Starts an http server serving files from |path|. Returns the local url."""
  print 'starting http for', path
  httpd = _SilentTCPServer(('127.0.0.1', 0), _GetHandlerClassForPath(path))
  atexit.register(httpd.shutdown)

  http_thread = threading.Thread(target=httpd.serve_forever)
  http_thread.daemon = True
  http_thread.start()

  print 'local port=', httpd.server_address[1]
  return 'http://127.0.0.1:%d/' % _MapPort(port, httpd.server_address[1])


def PrepareShellRun(config, origin=None, fixed_port=True):
  """ Prepares for StartShell: runs adb as root and installs the apk.  If no
  --origin is specified, local http server will be set up to serve files from
  the build directory along with port forwarding.

  Returns arguments that should be appended to shell argument list."""
  build_dir = Paths(config).build_dir

  if 'cannot run as root' in subprocess.check_output([ADB_PATH, 'root']):
    raise Exception("Unable to run adb as root.")
  apk_path = os.path.join(build_dir, 'apks', 'MojoShell.apk')
  subprocess.check_call(
      [ADB_PATH, 'install', '-r', apk_path, '-i', MOJO_SHELL_PACKAGE_NAME])
  atexit.register(StopShell)

  extra_shell_args = []
  origin_url = origin if origin else StartHttpServerForDirectory(
      build_dir, DEFAULT_BASE_PORT if fixed_port else 0)
  extra_shell_args.append("--origin=" + origin_url)

  return extra_shell_args


def _StartHttpServerForOriginMapping(mapping, port):
  """If |mapping| points at a local file starts an http server to serve files
  from the directory and returns the new mapping.

  This is intended to be called for every --map-origin value."""
  parts = mapping.split('=')
  if len(parts) != 2:
    return mapping
  dest = parts[1]
  # If the destination is a url, don't map it.
  if urlparse.urlparse(dest)[0]:
    return mapping
  # Assume the destination is a local file. Start a local server that redirects
  # to it.
  localUrl = StartHttpServerForDirectory(dest, port)
  print 'started server at %s for %s' % (dest, localUrl)
  return parts[0] + '=' + localUrl


def _StartHttpServerForOriginMappings(map_parameters, fixed_port):
  """Calls _StartHttpServerForOriginMapping for every --map-origin argument."""
  if not map_parameters:
    return []

  original_values = list(itertools.chain(
      *map(lambda x: x[len(MAPPING_PREFIX):].split(','), map_parameters)))
  sorted(original_values)
  result = []
  for i, value in enumerate(original_values):
    result.append(_StartHttpServerForOriginMapping(
        value, DEFAULT_BASE_PORT + 1 + i if fixed_port else 0))
  return [MAPPING_PREFIX + ','.join(result)]


def _IsMapOrigin(arg):
  """Returns whether arg is a --map-origin argument."""
  return arg.startswith(MAPPING_PREFIX)


def StartShell(arguments,
               stdout=None,
               on_application_stop=None,
               fixed_port=True):
  """
  Starts the mojo shell, passing it the given arguments.

  The |arguments| list must contain the "--origin=" arg from PrepareShellRun.
  If |stdout| is not None, it should be a valid argument for subprocess.Popen.
  """
  STDOUT_PIPE = "/data/data/%s/stdout.fifo" % MOJO_SHELL_PACKAGE_NAME

  cmd = [ADB_PATH,
         'shell',
         'am',
         'start',
         '-S',
         '-a', 'android.intent.action.VIEW',
         '-n', '%s/.MojoShellActivity' % MOJO_SHELL_PACKAGE_NAME]

  parameters = []
  if stdout or on_application_stop:
    subprocess.check_call([ADB_PATH, 'shell', 'rm', STDOUT_PIPE])
    parameters.append('--fifo-path=%s' % STDOUT_PIPE)
    _ReadFifo(STDOUT_PIPE, stdout, on_application_stop)
  # The origin has to be specified whether it's local or external.
  assert any("--origin=" in arg for arg in arguments)

  # Extract map-origin arguments.
  map_parameters, other_parameters = Split(arguments, _IsMapOrigin)
  parameters += other_parameters
  parameters += _StartHttpServerForOriginMappings(map_parameters, fixed_port)

  if parameters:
    encodedParameters = json.dumps(parameters)
    cmd += [ '--es', 'encodedParameters', encodedParameters]

  with open(os.devnull, 'w') as devnull:
    subprocess.Popen(cmd, stdout=devnull).wait()


def StopShell():
  """
  Stops the mojo shell.
  """
  subprocess.check_call(
      [ADB_PATH, 'shell', 'am', 'force-stop', MOJO_SHELL_PACKAGE_NAME])


def CleanLogs():
  """
  Cleans the logs on the device.
  """
  subprocess.check_call([ADB_PATH, 'logcat', '-c'])


def ShowLogs():
  """
  Displays the log for the mojo shell.

  Returns the process responsible for reading the logs.
  """
  logcat = subprocess.Popen([ADB_PATH,
                             'logcat',
                             '-s',
                             ' '.join(LOGCAT_TAGS)],
                            stdout=sys.stdout)
  atexit.register(_ExitIfNeeded, logcat)
  return logcat
