// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library view_associates_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/gfx/composition/hit_tests.mojom.dart' as hit_tests_mojom;
import 'package:mojo_services/mojo/gfx/composition/scene_token.mojom.dart' as scene_token_mojom;
import 'package:mojo_services/mojo/ui/view_token.mojom.dart' as view_token_mojom;
import 'package:mojo_services/mojo/ui/view_tree_token.mojom.dart' as view_tree_token_mojom;



class ViewAssociateInfo extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  List<String> viewServiceNames = null;
  List<String> viewTreeServiceNames = null;

  ViewAssociateInfo() : super(kVersions.last.size);

  static ViewAssociateInfo deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewAssociateInfo decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewAssociateInfo result = new ViewAssociateInfo();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, true);
      if (decoder1 == null) {
        result.viewServiceNames = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.viewServiceNames = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.viewServiceNames[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      if (decoder1 == null) {
        result.viewTreeServiceNames = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.viewTreeServiceNames = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.viewTreeServiceNames[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (viewServiceNames == null) {
        encoder0.encodeNullPointer(8, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(viewServiceNames.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < viewServiceNames.length; ++i0) {
          encoder1.encodeString(viewServiceNames[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewServiceNames of struct ViewAssociateInfo: $e";
      rethrow;
    }
    try {
      if (viewTreeServiceNames == null) {
        encoder0.encodeNullPointer(16, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(viewTreeServiceNames.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < viewTreeServiceNames.length; ++i0) {
          encoder1.encodeString(viewTreeServiceNames[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewTreeServiceNames of struct ViewAssociateInfo: $e";
      rethrow;
    }
  }

  String toString() {
    return "ViewAssociateInfo("
           "viewServiceNames: $viewServiceNames" ", "
           "viewTreeServiceNames: $viewTreeServiceNames" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewServiceNames"] = viewServiceNames;
    map["viewTreeServiceNames"] = viewTreeServiceNames;
    return map;
  }
}


class _ViewAssociateConnectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object inspector = null;

  _ViewAssociateConnectParams() : super(kVersions.last.size);

  static _ViewAssociateConnectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewAssociateConnectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewAssociateConnectParams result = new _ViewAssociateConnectParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.inspector = decoder0.decodeServiceInterface(8, false, ViewInspectorProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(inspector, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "inspector of struct _ViewAssociateConnectParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewAssociateConnectParams("
           "inspector: $inspector" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ViewAssociateConnectResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  ViewAssociateInfo info = null;

  ViewAssociateConnectResponseParams() : super(kVersions.last.size);

  static ViewAssociateConnectResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewAssociateConnectResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewAssociateConnectResponseParams result = new ViewAssociateConnectResponseParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.info = ViewAssociateInfo.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(info, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "info of struct ViewAssociateConnectResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ViewAssociateConnectResponseParams("
           "info: $info" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["info"] = info;
    return map;
  }
}


class _ViewAssociateConnectToViewServiceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  view_token_mojom.ViewToken viewToken = null;
  String serviceName_ = null;
  core.MojoMessagePipeEndpoint pipe = null;

  _ViewAssociateConnectToViewServiceParams() : super(kVersions.last.size);

  static _ViewAssociateConnectToViewServiceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewAssociateConnectToViewServiceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewAssociateConnectToViewServiceParams result = new _ViewAssociateConnectToViewServiceParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.viewToken = view_token_mojom.ViewToken.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.serviceName_ = decoder0.decodeString(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.pipe = decoder0.decodeMessagePipeHandle(24, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(viewToken, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewToken of struct _ViewAssociateConnectToViewServiceParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(serviceName_, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "serviceName_ of struct _ViewAssociateConnectToViewServiceParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(pipe, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pipe of struct _ViewAssociateConnectToViewServiceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewAssociateConnectToViewServiceParams("
           "viewToken: $viewToken" ", "
           "serviceName_: $serviceName_" ", "
           "pipe: $pipe" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewAssociateConnectToViewTreeServiceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  view_tree_token_mojom.ViewTreeToken viewTreeToken = null;
  String serviceName_ = null;
  core.MojoMessagePipeEndpoint pipe = null;

  _ViewAssociateConnectToViewTreeServiceParams() : super(kVersions.last.size);

  static _ViewAssociateConnectToViewTreeServiceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewAssociateConnectToViewTreeServiceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewAssociateConnectToViewTreeServiceParams result = new _ViewAssociateConnectToViewTreeServiceParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.viewTreeToken = view_tree_token_mojom.ViewTreeToken.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.serviceName_ = decoder0.decodeString(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.pipe = decoder0.decodeMessagePipeHandle(24, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(viewTreeToken, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewTreeToken of struct _ViewAssociateConnectToViewTreeServiceParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(serviceName_, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "serviceName_ of struct _ViewAssociateConnectToViewTreeServiceParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(pipe, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pipe of struct _ViewAssociateConnectToViewTreeServiceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewAssociateConnectToViewTreeServiceParams("
           "viewTreeToken: $viewTreeToken" ", "
           "serviceName_: $serviceName_" ", "
           "pipe: $pipe" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewInspectorGetHitTesterParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  view_tree_token_mojom.ViewTreeToken viewTreeToken = null;
  Object hitTester = null;

  _ViewInspectorGetHitTesterParams() : super(kVersions.last.size);

  static _ViewInspectorGetHitTesterParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewInspectorGetHitTesterParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewInspectorGetHitTesterParams result = new _ViewInspectorGetHitTesterParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.viewTreeToken = view_tree_token_mojom.ViewTreeToken.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.hitTester = decoder0.decodeInterfaceRequest(16, false, hit_tests_mojom.HitTesterStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(viewTreeToken, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewTreeToken of struct _ViewInspectorGetHitTesterParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(hitTester, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "hitTester of struct _ViewInspectorGetHitTesterParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewInspectorGetHitTesterParams("
           "viewTreeToken: $viewTreeToken" ", "
           "hitTester: $hitTester" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ViewInspectorGetHitTesterResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool rendererChanged = false;

  ViewInspectorGetHitTesterResponseParams() : super(kVersions.last.size);

  static ViewInspectorGetHitTesterResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewInspectorGetHitTesterResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewInspectorGetHitTesterResponseParams result = new ViewInspectorGetHitTesterResponseParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.rendererChanged = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(rendererChanged, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rendererChanged of struct ViewInspectorGetHitTesterResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ViewInspectorGetHitTesterResponseParams("
           "rendererChanged: $rendererChanged" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["rendererChanged"] = rendererChanged;
    return map;
  }
}


class _ViewInspectorResolveScenesParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<scene_token_mojom.SceneToken> sceneTokens = null;

  _ViewInspectorResolveScenesParams() : super(kVersions.last.size);

  static _ViewInspectorResolveScenesParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewInspectorResolveScenesParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewInspectorResolveScenesParams result = new _ViewInspectorResolveScenesParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.sceneTokens = new List<scene_token_mojom.SceneToken>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.sceneTokens[i1] = scene_token_mojom.SceneToken.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (sceneTokens == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(sceneTokens.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < sceneTokens.length; ++i0) {
          encoder1.encodeStruct(sceneTokens[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sceneTokens of struct _ViewInspectorResolveScenesParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewInspectorResolveScenesParams("
           "sceneTokens: $sceneTokens" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sceneTokens"] = sceneTokens;
    return map;
  }
}


class ViewInspectorResolveScenesResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<view_token_mojom.ViewToken> viewTokens = null;

  ViewInspectorResolveScenesResponseParams() : super(kVersions.last.size);

  static ViewInspectorResolveScenesResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewInspectorResolveScenesResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewInspectorResolveScenesResponseParams result = new ViewInspectorResolveScenesResponseParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.viewTokens = new List<view_token_mojom.ViewToken>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
          result.viewTokens[i1] = view_token_mojom.ViewToken.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (viewTokens == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(viewTokens.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < viewTokens.length; ++i0) {
          encoder1.encodeStruct(viewTokens[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, true);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewTokens of struct ViewInspectorResolveScenesResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ViewInspectorResolveScenesResponseParams("
           "viewTokens: $viewTokens" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewTokens"] = viewTokens;
    return map;
  }
}

const int _viewAssociateMethodConnectName = 0;
const int _viewAssociateMethodConnectToViewServiceName = 1;
const int _viewAssociateMethodConnectToViewTreeServiceName = 2;

class _ViewAssociateServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ViewAssociate {
  static const String serviceName = "mojo::ui::ViewAssociate";
  dynamic connect(Object inspector,[Function responseFactory = null]);
  void connectToViewService(view_token_mojom.ViewToken viewToken, String serviceName_, core.MojoMessagePipeEndpoint pipe);
  void connectToViewTreeService(view_tree_token_mojom.ViewTreeToken viewTreeToken, String serviceName_, core.MojoMessagePipeEndpoint pipe);
}


class _ViewAssociateProxyImpl extends bindings.Proxy {
  _ViewAssociateProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewAssociateProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ViewAssociateProxyImpl.unbound() : super.unbound();

  static _ViewAssociateProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ViewAssociateProxyImpl"));
    return new _ViewAssociateProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ViewAssociateServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _viewAssociateMethodConnectName:
        var r = ViewAssociateConnectResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_ViewAssociateProxyImpl($superString)";
  }
}


class _ViewAssociateProxyCalls implements ViewAssociate {
  _ViewAssociateProxyImpl _proxyImpl;

  _ViewAssociateProxyCalls(this._proxyImpl);
    dynamic connect(Object inspector,[Function responseFactory = null]) {
      var params = new _ViewAssociateConnectParams();
      params.inspector = inspector;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _viewAssociateMethodConnectName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void connectToViewService(view_token_mojom.ViewToken viewToken, String serviceName_, core.MojoMessagePipeEndpoint pipe) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewAssociateConnectToViewServiceParams();
      params.viewToken = viewToken;
      params.serviceName_ = serviceName_;
      params.pipe = pipe;
      _proxyImpl.sendMessage(params, _viewAssociateMethodConnectToViewServiceName);
    }
    void connectToViewTreeService(view_tree_token_mojom.ViewTreeToken viewTreeToken, String serviceName_, core.MojoMessagePipeEndpoint pipe) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewAssociateConnectToViewTreeServiceParams();
      params.viewTreeToken = viewTreeToken;
      params.serviceName_ = serviceName_;
      params.pipe = pipe;
      _proxyImpl.sendMessage(params, _viewAssociateMethodConnectToViewTreeServiceName);
    }
}


class ViewAssociateProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewAssociate ptr;

  ViewAssociateProxy(_ViewAssociateProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewAssociateProxyCalls(proxyImpl);

  ViewAssociateProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ViewAssociateProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewAssociateProxyCalls(impl);
  }

  ViewAssociateProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ViewAssociateProxyImpl.fromHandle(handle) {
    ptr = new _ViewAssociateProxyCalls(impl);
  }

  ViewAssociateProxy.unbound() :
      impl = new _ViewAssociateProxyImpl.unbound() {
    ptr = new _ViewAssociateProxyCalls(impl);
  }

  factory ViewAssociateProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewAssociateProxy p = new ViewAssociateProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ViewAssociateProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewAssociateProxy"));
    return new ViewAssociateProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ViewAssociate.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ViewAssociateProxy($impl)";
  }
}


class ViewAssociateStub extends bindings.Stub {
  ViewAssociate _impl = null;

  ViewAssociateStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewAssociateStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewAssociateStub.unbound() : super.unbound();

  static ViewAssociateStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewAssociateStub"));
    return new ViewAssociateStub.fromEndpoint(endpoint);
  }


  ViewAssociateConnectResponseParams _viewAssociateConnectResponseParamsFactory(ViewAssociateInfo info) {
    var result = new ViewAssociateConnectResponseParams();
    result.info = info;
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _viewAssociateMethodConnectName:
        var params = _ViewAssociateConnectParams.deserialize(
            message.payload);
        var response = _impl.connect(params.inspector,_viewAssociateConnectResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _viewAssociateMethodConnectName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _viewAssociateMethodConnectName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _viewAssociateMethodConnectToViewServiceName:
        var params = _ViewAssociateConnectToViewServiceParams.deserialize(
            message.payload);
        _impl.connectToViewService(params.viewToken, params.serviceName_, params.pipe);
        break;
      case _viewAssociateMethodConnectToViewTreeServiceName:
        var params = _ViewAssociateConnectToViewTreeServiceParams.deserialize(
            message.payload);
        _impl.connectToViewTreeService(params.viewTreeToken, params.serviceName_, params.pipe);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ViewAssociate get impl => _impl;
  set impl(ViewAssociate d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewAssociateStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewAssociateServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _viewInspectorMethodGetHitTesterName = 0;
const int _viewInspectorMethodResolveScenesName = 1;

class _ViewInspectorServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ViewInspector {
  static const String serviceName = null;
  dynamic getHitTester(view_tree_token_mojom.ViewTreeToken viewTreeToken,Object hitTester,[Function responseFactory = null]);
  dynamic resolveScenes(List<scene_token_mojom.SceneToken> sceneTokens,[Function responseFactory = null]);
}


class _ViewInspectorProxyImpl extends bindings.Proxy {
  _ViewInspectorProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewInspectorProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ViewInspectorProxyImpl.unbound() : super.unbound();

  static _ViewInspectorProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ViewInspectorProxyImpl"));
    return new _ViewInspectorProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ViewInspectorServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _viewInspectorMethodGetHitTesterName:
        var r = ViewInspectorGetHitTesterResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      case _viewInspectorMethodResolveScenesName:
        var r = ViewInspectorResolveScenesResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_ViewInspectorProxyImpl($superString)";
  }
}


class _ViewInspectorProxyCalls implements ViewInspector {
  _ViewInspectorProxyImpl _proxyImpl;

  _ViewInspectorProxyCalls(this._proxyImpl);
    dynamic getHitTester(view_tree_token_mojom.ViewTreeToken viewTreeToken,Object hitTester,[Function responseFactory = null]) {
      var params = new _ViewInspectorGetHitTesterParams();
      params.viewTreeToken = viewTreeToken;
      params.hitTester = hitTester;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _viewInspectorMethodGetHitTesterName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic resolveScenes(List<scene_token_mojom.SceneToken> sceneTokens,[Function responseFactory = null]) {
      var params = new _ViewInspectorResolveScenesParams();
      params.sceneTokens = sceneTokens;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _viewInspectorMethodResolveScenesName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ViewInspectorProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewInspector ptr;

  ViewInspectorProxy(_ViewInspectorProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewInspectorProxyCalls(proxyImpl);

  ViewInspectorProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ViewInspectorProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewInspectorProxyCalls(impl);
  }

  ViewInspectorProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ViewInspectorProxyImpl.fromHandle(handle) {
    ptr = new _ViewInspectorProxyCalls(impl);
  }

  ViewInspectorProxy.unbound() :
      impl = new _ViewInspectorProxyImpl.unbound() {
    ptr = new _ViewInspectorProxyCalls(impl);
  }

  factory ViewInspectorProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewInspectorProxy p = new ViewInspectorProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ViewInspectorProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewInspectorProxy"));
    return new ViewInspectorProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ViewInspector.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ViewInspectorProxy($impl)";
  }
}


class ViewInspectorStub extends bindings.Stub {
  ViewInspector _impl = null;

  ViewInspectorStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewInspectorStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewInspectorStub.unbound() : super.unbound();

  static ViewInspectorStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewInspectorStub"));
    return new ViewInspectorStub.fromEndpoint(endpoint);
  }


  ViewInspectorGetHitTesterResponseParams _viewInspectorGetHitTesterResponseParamsFactory(bool rendererChanged) {
    var result = new ViewInspectorGetHitTesterResponseParams();
    result.rendererChanged = rendererChanged;
    return result;
  }
  ViewInspectorResolveScenesResponseParams _viewInspectorResolveScenesResponseParamsFactory(List<view_token_mojom.ViewToken> viewTokens) {
    var result = new ViewInspectorResolveScenesResponseParams();
    result.viewTokens = viewTokens;
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _viewInspectorMethodGetHitTesterName:
        var params = _ViewInspectorGetHitTesterParams.deserialize(
            message.payload);
        var response = _impl.getHitTester(params.viewTreeToken,params.hitTester,_viewInspectorGetHitTesterResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _viewInspectorMethodGetHitTesterName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _viewInspectorMethodGetHitTesterName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _viewInspectorMethodResolveScenesName:
        var params = _ViewInspectorResolveScenesParams.deserialize(
            message.payload);
        var response = _impl.resolveScenes(params.sceneTokens,_viewInspectorResolveScenesResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _viewInspectorMethodResolveScenesName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _viewInspectorMethodResolveScenesName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ViewInspector get impl => _impl;
  set impl(ViewInspector d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewInspectorStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewInspectorServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



