// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library regression_tests_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;

class EnumWithReference extends bindings.MojoEnum {
  static const EnumWithReference kStereoAndKeyboardMic = const EnumWithReference._(30);
  static const EnumWithReference kMax = const EnumWithReference._(30);

  const EnumWithReference._(int v) : super(v);

  static const Map<String, EnumWithReference> valuesMap = const {
    "kStereoAndKeyboardMic": kStereoAndKeyboardMic,
    "kMax": kMax,
  };
  static const List<EnumWithReference> values = const [
    kStereoAndKeyboardMic,
    kMax,
  ];

  static EnumWithReference valueOf(String name) => valuesMap[name];

  factory EnumWithReference(int v) {
    switch (v) {
      case 30:
        return EnumWithReference.kStereoAndKeyboardMic;
      case 30:
        return EnumWithReference.kMax;
      default:
        return null;
    }
  }

  static EnumWithReference decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    EnumWithReference result = new EnumWithReference(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum EnumWithReference.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case kStereoAndKeyboardMic:
        return 'EnumWithReference.kStereoAndKeyboardMic';
      case kMax:
        return 'EnumWithReference.kMax';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class EnumWithLowercase extends bindings.MojoEnum {
  static const EnumWithLowercase planarF16 = const EnumWithLowercase._(0);
  static const EnumWithLowercase planarF32 = const EnumWithLowercase._(1);

  const EnumWithLowercase._(int v) : super(v);

  static const Map<String, EnumWithLowercase> valuesMap = const {
    "planarF16": planarF16,
    "planarF32": planarF32,
  };
  static const List<EnumWithLowercase> values = const [
    planarF16,
    planarF32,
  ];

  static EnumWithLowercase valueOf(String name) => valuesMap[name];

  factory EnumWithLowercase(int v) {
    switch (v) {
      case 0:
        return EnumWithLowercase.planarF16;
      case 1:
        return EnumWithLowercase.planarF32;
      default:
        return null;
    }
  }

  static EnumWithLowercase decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    EnumWithLowercase result = new EnumWithLowercase(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum EnumWithLowercase.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case planarF16:
        return 'EnumWithLowercase.planarF16';
      case planarF32:
        return 'EnumWithLowercase.planarF32';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class EnumWithNumbers extends bindings.MojoEnum {
  static const EnumWithNumbers k21 = const EnumWithNumbers._(4);

  const EnumWithNumbers._(int v) : super(v);

  static const Map<String, EnumWithNumbers> valuesMap = const {
    "k21": k21,
  };
  static const List<EnumWithNumbers> values = const [
    k21,
  ];

  static EnumWithNumbers valueOf(String name) => valuesMap[name];

  factory EnumWithNumbers(int v) {
    switch (v) {
      case 4:
        return EnumWithNumbers.k21;
      default:
        return null;
    }
  }

  static EnumWithNumbers decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    EnumWithNumbers result = new EnumWithNumbers(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum EnumWithNumbers.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case k21:
        return 'EnumWithNumbers.k21';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class EnumWithK extends bindings.MojoEnum {
  static const EnumWithK k = const EnumWithK._(0);

  const EnumWithK._(int v) : super(v);

  static const Map<String, EnumWithK> valuesMap = const {
    "k": k,
  };
  static const List<EnumWithK> values = const [
    k,
  ];

  static EnumWithK valueOf(String name) => valuesMap[name];

  factory EnumWithK(int v) {
    switch (v) {
      case 0:
        return EnumWithK.k;
      default:
        return null;
    }
  }

  static EnumWithK decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    EnumWithK result = new EnumWithK(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum EnumWithK.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case k:
        return 'EnumWithK.k';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class EnumWithInternalAllCaps extends bindings.MojoEnum {
  static const EnumWithInternalAllCaps standard = const EnumWithInternalAllCaps._(0);
  static const EnumWithInternalAllCaps fullscreen = const EnumWithInternalAllCaps._(1);
  static const EnumWithInternalAllCaps immersive = const EnumWithInternalAllCaps._(2);

  const EnumWithInternalAllCaps._(int v) : super(v);

  static const Map<String, EnumWithInternalAllCaps> valuesMap = const {
    "standard": standard,
    "fullscreen": fullscreen,
    "immersive": immersive,
  };
  static const List<EnumWithInternalAllCaps> values = const [
    standard,
    fullscreen,
    immersive,
  ];

  static EnumWithInternalAllCaps valueOf(String name) => valuesMap[name];

  factory EnumWithInternalAllCaps(int v) {
    switch (v) {
      case 0:
        return EnumWithInternalAllCaps.standard;
      case 1:
        return EnumWithInternalAllCaps.fullscreen;
      case 2:
        return EnumWithInternalAllCaps.immersive;
      default:
        return null;
    }
  }

  static EnumWithInternalAllCaps decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    EnumWithInternalAllCaps result = new EnumWithInternalAllCaps(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum EnumWithInternalAllCaps.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case standard:
        return 'EnumWithInternalAllCaps.standard';
      case fullscreen:
        return 'EnumWithInternalAllCaps.fullscreen';
      case immersive:
        return 'EnumWithInternalAllCaps.immersive';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class NormalEnum extends bindings.MojoEnum {
  static const NormalEnum first = const NormalEnum._(0);
  static const NormalEnum second = const NormalEnum._(1);

  const NormalEnum._(int v) : super(v);

  static const Map<String, NormalEnum> valuesMap = const {
    "first": first,
    "second": second,
  };
  static const List<NormalEnum> values = const [
    first,
    second,
  ];

  static NormalEnum valueOf(String name) => valuesMap[name];

  factory NormalEnum(int v) {
    switch (v) {
      case 0:
        return NormalEnum.first;
      case 1:
        return NormalEnum.second;
      default:
        return null;
    }
  }

  static NormalEnum decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    NormalEnum result = new NormalEnum(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum NormalEnum.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case first:
        return 'NormalEnum.first';
      case second:
        return 'NormalEnum.second';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class CamelCaseTestEnum extends bindings.MojoEnum {
  static const CamelCaseTestEnum boolThing = const CamelCaseTestEnum._(0);
  static const CamelCaseTestEnum doubleThing = const CamelCaseTestEnum._(1);
  static const CamelCaseTestEnum floatThing = const CamelCaseTestEnum._(2);
  static const CamelCaseTestEnum int8Thing = const CamelCaseTestEnum._(3);
  static const CamelCaseTestEnum int16Thing = const CamelCaseTestEnum._(4);
  static const CamelCaseTestEnum int32Th1Ng = const CamelCaseTestEnum._(5);
  static const CamelCaseTestEnum int64Th1ng = const CamelCaseTestEnum._(6);
  static const CamelCaseTestEnum uint8TH1ng = const CamelCaseTestEnum._(7);
  static const CamelCaseTestEnum uint16tH1Ng = const CamelCaseTestEnum._(8);
  static const CamelCaseTestEnum uint32Th1ng = const CamelCaseTestEnum._(9);
  static const CamelCaseTestEnum uint64Th1Ng = const CamelCaseTestEnum._(10);

  const CamelCaseTestEnum._(int v) : super(v);

  static const Map<String, CamelCaseTestEnum> valuesMap = const {
    "boolThing": boolThing,
    "doubleThing": doubleThing,
    "floatThing": floatThing,
    "int8Thing": int8Thing,
    "int16Thing": int16Thing,
    "int32Th1Ng": int32Th1Ng,
    "int64Th1ng": int64Th1ng,
    "uint8TH1ng": uint8TH1ng,
    "uint16tH1Ng": uint16tH1Ng,
    "uint32Th1ng": uint32Th1ng,
    "uint64Th1Ng": uint64Th1Ng,
  };
  static const List<CamelCaseTestEnum> values = const [
    boolThing,
    doubleThing,
    floatThing,
    int8Thing,
    int16Thing,
    int32Th1Ng,
    int64Th1ng,
    uint8TH1ng,
    uint16tH1Ng,
    uint32Th1ng,
    uint64Th1Ng,
  ];

  static CamelCaseTestEnum valueOf(String name) => valuesMap[name];

  factory CamelCaseTestEnum(int v) {
    switch (v) {
      case 0:
        return CamelCaseTestEnum.boolThing;
      case 1:
        return CamelCaseTestEnum.doubleThing;
      case 2:
        return CamelCaseTestEnum.floatThing;
      case 3:
        return CamelCaseTestEnum.int8Thing;
      case 4:
        return CamelCaseTestEnum.int16Thing;
      case 5:
        return CamelCaseTestEnum.int32Th1Ng;
      case 6:
        return CamelCaseTestEnum.int64Th1ng;
      case 7:
        return CamelCaseTestEnum.uint8TH1ng;
      case 8:
        return CamelCaseTestEnum.uint16tH1Ng;
      case 9:
        return CamelCaseTestEnum.uint32Th1ng;
      case 10:
        return CamelCaseTestEnum.uint64Th1Ng;
      default:
        return null;
    }
  }

  static CamelCaseTestEnum decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    CamelCaseTestEnum result = new CamelCaseTestEnum(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum CamelCaseTestEnum.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case boolThing:
        return 'CamelCaseTestEnum.boolThing';
      case doubleThing:
        return 'CamelCaseTestEnum.doubleThing';
      case floatThing:
        return 'CamelCaseTestEnum.floatThing';
      case int8Thing:
        return 'CamelCaseTestEnum.int8Thing';
      case int16Thing:
        return 'CamelCaseTestEnum.int16Thing';
      case int32Th1Ng:
        return 'CamelCaseTestEnum.int32Th1Ng';
      case int64Th1ng:
        return 'CamelCaseTestEnum.int64Th1ng';
      case uint8TH1ng:
        return 'CamelCaseTestEnum.uint8TH1ng';
      case uint16tH1Ng:
        return 'CamelCaseTestEnum.uint16tH1Ng';
      case uint32Th1ng:
        return 'CamelCaseTestEnum.uint32Th1ng';
      case uint64Th1Ng:
        return 'CamelCaseTestEnum.uint64Th1Ng';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class Edge extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Vertex v = null;

  Edge() : super(kVersions.last.size);

  static Edge deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Edge decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Edge result = new Edge();

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
      result.v = Vertex.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(v, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "v of struct Edge: $e";
      rethrow;
    }
  }

  String toString() {
    return "Edge("
           "v: $v" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["v"] = v;
    return map;
  }
}


class Vertex extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  EmptyStruct e = null;

  Vertex() : super(kVersions.last.size);

  static Vertex deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Vertex decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Vertex result = new Vertex();

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
      result.e = EmptyStruct.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(e, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "e of struct Vertex: $e";
      rethrow;
    }
  }

  String toString() {
    return "Vertex("
           "e: $e" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["e"] = e;
    return map;
  }
}


class EmptyStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  EmptyStruct() : super(kVersions.last.size);

  static EmptyStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EmptyStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EmptyStruct result = new EmptyStruct();

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
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "EmptyStruct("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class A extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  B b = null;

  A() : super(kVersions.last.size);

  static A deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static A decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    A result = new A();

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
      result.b = B.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(b, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "b of struct A: $e";
      rethrow;
    }
  }

  String toString() {
    return "A("
           "b: $b" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["b"] = b;
    return map;
  }
}


class B extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  A a = null;

  B() : super(kVersions.last.size);

  static B deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static B decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    B result = new B();

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
      result.a = A.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(a, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct B: $e";
      rethrow;
    }
  }

  String toString() {
    return "B("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}


class StructWithHandleCalledHandles extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoHandle handles = null;

  StructWithHandleCalledHandles() : super(kVersions.last.size);

  static StructWithHandleCalledHandles deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructWithHandleCalledHandles decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructWithHandleCalledHandles result = new StructWithHandleCalledHandles();

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
      
      result.handles = decoder0.decodeHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeHandle(handles, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "handles of struct StructWithHandleCalledHandles: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructWithHandleCalledHandles("
           "handles: $handles" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class StructWithArrayOfHandlesCalledHandles extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<core.MojoHandle> handles = null;

  StructWithArrayOfHandlesCalledHandles() : super(kVersions.last.size);

  static StructWithArrayOfHandlesCalledHandles deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructWithArrayOfHandlesCalledHandles decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructWithArrayOfHandlesCalledHandles result = new StructWithArrayOfHandlesCalledHandles();

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
      
      result.handles = decoder0.decodeHandleArray(8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeHandleArray(handles, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "handles of struct StructWithArrayOfHandlesCalledHandles: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructWithArrayOfHandlesCalledHandles("
           "handles: $handles" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class StructWithInterfaceCalledHandles extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object handles = null;

  StructWithInterfaceCalledHandles() : super(kVersions.last.size);

  static StructWithInterfaceCalledHandles deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructWithInterfaceCalledHandles decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructWithInterfaceCalledHandles result = new StructWithInterfaceCalledHandles();

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
      
      result.handles = decoder0.decodeServiceInterface(8, false, TestInterfaceProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(handles, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "handles of struct StructWithInterfaceCalledHandles: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructWithInterfaceCalledHandles("
           "handles: $handles" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ContainsArrayOfEnum extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<NormalEnum> arrayOfEnums = null;

  ContainsArrayOfEnum() : super(kVersions.last.size);

  static ContainsArrayOfEnum deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContainsArrayOfEnum decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContainsArrayOfEnum result = new ContainsArrayOfEnum();

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
        var si1 = decoder1.decodeDataHeaderForEnumArray(bindings.kUnspecifiedArrayLength);
        result.arrayOfEnums = new List<NormalEnum>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
            result.arrayOfEnums[i1] = NormalEnum.decode(decoder1, bindings.ArrayDataHeader.kHeaderSize + bindings.kEnumSize * i1);
            if (result.arrayOfEnums[i1] == null) {
              throw new bindings.MojoCodecError(
                'Trying to decode null union for non-nullable NormalEnum.');
            }
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnumArray(arrayOfEnums, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "arrayOfEnums of struct ContainsArrayOfEnum: $e";
      rethrow;
    }
  }

  String toString() {
    return "ContainsArrayOfEnum("
           "arrayOfEnums: $arrayOfEnums" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["arrayOfEnums"] = arrayOfEnums;
    return map;
  }
}


class _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams() : super(kVersions.last.size);

  static _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams result = new _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams();

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
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "_CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams() : super(kVersions.last.size);

  static CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams result = new CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams();

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
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool b = false;

  _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams() : super(kVersions.last.size);

  static _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams result = new _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams();

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
      
      result.b = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(b, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "b of struct _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams("
           "b: $b" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["b"] = b;
    return map;
  }
}


class CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams() : super(kVersions.last.size);

  static CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams result = new CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams();

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
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _CheckNameCollisionWithNameCollisionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool message = false;
  bool response = false;

  _CheckNameCollisionWithNameCollisionParams() : super(kVersions.last.size);

  static _CheckNameCollisionWithNameCollisionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CheckNameCollisionWithNameCollisionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CheckNameCollisionWithNameCollisionParams result = new _CheckNameCollisionWithNameCollisionParams();

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
      
      result.message = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.response = decoder0.decodeBool(8, 1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(message, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "message of struct _CheckNameCollisionWithNameCollisionParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(response, 8, 1);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct _CheckNameCollisionWithNameCollisionParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_CheckNameCollisionWithNameCollisionParams("
           "message: $message" ", "
           "response: $response" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["message"] = message;
    map["response"] = response;
    return map;
  }
}


class CheckNameCollisionWithNameCollisionResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool message = false;
  bool response = false;

  CheckNameCollisionWithNameCollisionResponseParams() : super(kVersions.last.size);

  static CheckNameCollisionWithNameCollisionResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CheckNameCollisionWithNameCollisionResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CheckNameCollisionWithNameCollisionResponseParams result = new CheckNameCollisionWithNameCollisionResponseParams();

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
      
      result.message = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.response = decoder0.decodeBool(8, 1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(message, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "message of struct CheckNameCollisionWithNameCollisionResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(response, 8, 1);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct CheckNameCollisionWithNameCollisionResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "CheckNameCollisionWithNameCollisionResponseParams("
           "message: $message" ", "
           "response: $response" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["message"] = message;
    map["response"] = response;
    return map;
  }
}


class _CheckEnumCapsSetEnumWithInternalAllCapsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  EnumWithInternalAllCaps e = null;

  _CheckEnumCapsSetEnumWithInternalAllCapsParams() : super(kVersions.last.size);

  static _CheckEnumCapsSetEnumWithInternalAllCapsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CheckEnumCapsSetEnumWithInternalAllCapsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CheckEnumCapsSetEnumWithInternalAllCapsParams result = new _CheckEnumCapsSetEnumWithInternalAllCapsParams();

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
      
        result.e = EnumWithInternalAllCaps.decode(decoder0, 8);
        if (result.e == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable EnumWithInternalAllCaps.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(e, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "e of struct _CheckEnumCapsSetEnumWithInternalAllCapsParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_CheckEnumCapsSetEnumWithInternalAllCapsParams("
           "e: $e" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["e"] = e;
    return map;
  }
}


class _TestInterfaceSomeMessageParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _TestInterfaceSomeMessageParams() : super(kVersions.last.size);

  static _TestInterfaceSomeMessageParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TestInterfaceSomeMessageParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TestInterfaceSomeMessageParams result = new _TestInterfaceSomeMessageParams();

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
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "_TestInterfaceSomeMessageParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _Regression551GetParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<String> keyPrefixes = null;

  _Regression551GetParams() : super(kVersions.last.size);

  static _Regression551GetParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _Regression551GetParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _Regression551GetParams result = new _Regression551GetParams();

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
        result.keyPrefixes = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.keyPrefixes[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (keyPrefixes == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(keyPrefixes.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < keyPrefixes.length; ++i0) {
          encoder1.encodeString(keyPrefixes[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "keyPrefixes of struct _Regression551GetParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_Regression551GetParams("
           "keyPrefixes: $keyPrefixes" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["keyPrefixes"] = keyPrefixes;
    return map;
  }
}


class Regression551GetResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int result = 0;

  Regression551GetResponseParams() : super(kVersions.last.size);

  static Regression551GetResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Regression551GetResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Regression551GetResponseParams result = new Regression551GetResponseParams();

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
      
      result.result = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(result, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct Regression551GetResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "Regression551GetResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class _ServiceNameServiceNameParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ServiceNameServiceNameParams() : super(kVersions.last.size);

  static _ServiceNameServiceNameParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ServiceNameServiceNameParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ServiceNameServiceNameParams result = new _ServiceNameServiceNameParams();

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
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "_ServiceNameServiceNameParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ServiceNameServiceNameResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String serviceName_ = null;

  ServiceNameServiceNameResponseParams() : super(kVersions.last.size);

  static ServiceNameServiceNameResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ServiceNameServiceNameResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ServiceNameServiceNameResponseParams result = new ServiceNameServiceNameResponseParams();

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
      
      result.serviceName_ = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(serviceName_, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "serviceName_ of struct ServiceNameServiceNameResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ServiceNameServiceNameResponseParams("
           "serviceName_: $serviceName_" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["serviceName_"] = serviceName_;
    return map;
  }
}

const int _checkMethodWithEmptyResponseMethodWithoutParameterAndEmptyResponseName = 0;
const int _checkMethodWithEmptyResponseMethodWithParameterAndEmptyResponseName = 1;

class _CheckMethodWithEmptyResponseServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class CheckMethodWithEmptyResponse {
  static const String serviceName = null;
  dynamic withoutParameterAndEmptyResponse([Function responseFactory = null]);
  dynamic withParameterAndEmptyResponse(bool b,[Function responseFactory = null]);
}


class _CheckMethodWithEmptyResponseProxyImpl extends bindings.Proxy {
  _CheckMethodWithEmptyResponseProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CheckMethodWithEmptyResponseProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CheckMethodWithEmptyResponseProxyImpl.unbound() : super.unbound();

  static _CheckMethodWithEmptyResponseProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CheckMethodWithEmptyResponseProxyImpl"));
    return new _CheckMethodWithEmptyResponseProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _CheckMethodWithEmptyResponseServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _checkMethodWithEmptyResponseMethodWithoutParameterAndEmptyResponseName:
        var r = CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams.deserialize(
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
      case _checkMethodWithEmptyResponseMethodWithParameterAndEmptyResponseName:
        var r = CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams.deserialize(
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
    return "_CheckMethodWithEmptyResponseProxyImpl($superString)";
  }
}


class _CheckMethodWithEmptyResponseProxyCalls implements CheckMethodWithEmptyResponse {
  _CheckMethodWithEmptyResponseProxyImpl _proxyImpl;

  _CheckMethodWithEmptyResponseProxyCalls(this._proxyImpl);
    dynamic withoutParameterAndEmptyResponse([Function responseFactory = null]) {
      var params = new _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _checkMethodWithEmptyResponseMethodWithoutParameterAndEmptyResponseName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic withParameterAndEmptyResponse(bool b,[Function responseFactory = null]) {
      var params = new _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams();
      params.b = b;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _checkMethodWithEmptyResponseMethodWithParameterAndEmptyResponseName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class CheckMethodWithEmptyResponseProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CheckMethodWithEmptyResponse ptr;

  CheckMethodWithEmptyResponseProxy(_CheckMethodWithEmptyResponseProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CheckMethodWithEmptyResponseProxyCalls(proxyImpl);

  CheckMethodWithEmptyResponseProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CheckMethodWithEmptyResponseProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CheckMethodWithEmptyResponseProxyCalls(impl);
  }

  CheckMethodWithEmptyResponseProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CheckMethodWithEmptyResponseProxyImpl.fromHandle(handle) {
    ptr = new _CheckMethodWithEmptyResponseProxyCalls(impl);
  }

  CheckMethodWithEmptyResponseProxy.unbound() :
      impl = new _CheckMethodWithEmptyResponseProxyImpl.unbound() {
    ptr = new _CheckMethodWithEmptyResponseProxyCalls(impl);
  }

  factory CheckMethodWithEmptyResponseProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CheckMethodWithEmptyResponseProxy p = new CheckMethodWithEmptyResponseProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CheckMethodWithEmptyResponseProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CheckMethodWithEmptyResponseProxy"));
    return new CheckMethodWithEmptyResponseProxy.fromEndpoint(endpoint);
  }

  String get serviceName => CheckMethodWithEmptyResponse.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CheckMethodWithEmptyResponseProxy($impl)";
  }
}


class CheckMethodWithEmptyResponseStub extends bindings.Stub {
  CheckMethodWithEmptyResponse _impl = null;

  CheckMethodWithEmptyResponseStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CheckMethodWithEmptyResponseStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CheckMethodWithEmptyResponseStub.unbound() : super.unbound();

  static CheckMethodWithEmptyResponseStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CheckMethodWithEmptyResponseStub"));
    return new CheckMethodWithEmptyResponseStub.fromEndpoint(endpoint);
  }


  CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams _checkMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParamsFactory() {
    var result = new CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams();
    return result;
  }
  CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams _checkMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParamsFactory() {
    var result = new CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams();
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
      case _checkMethodWithEmptyResponseMethodWithoutParameterAndEmptyResponseName:
        var response = _impl.withoutParameterAndEmptyResponse(_checkMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _checkMethodWithEmptyResponseMethodWithoutParameterAndEmptyResponseName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _checkMethodWithEmptyResponseMethodWithoutParameterAndEmptyResponseName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _checkMethodWithEmptyResponseMethodWithParameterAndEmptyResponseName:
        var params = _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams.deserialize(
            message.payload);
        var response = _impl.withParameterAndEmptyResponse(params.b,_checkMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _checkMethodWithEmptyResponseMethodWithParameterAndEmptyResponseName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _checkMethodWithEmptyResponseMethodWithParameterAndEmptyResponseName,
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

  CheckMethodWithEmptyResponse get impl => _impl;
  set impl(CheckMethodWithEmptyResponse d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CheckMethodWithEmptyResponseStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _CheckMethodWithEmptyResponseServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _checkNameCollisionMethodWithNameCollisionName = 0;

class _CheckNameCollisionServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class CheckNameCollision {
  static const String serviceName = null;
  dynamic withNameCollision(bool message,bool response,[Function responseFactory = null]);
}


class _CheckNameCollisionProxyImpl extends bindings.Proxy {
  _CheckNameCollisionProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CheckNameCollisionProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CheckNameCollisionProxyImpl.unbound() : super.unbound();

  static _CheckNameCollisionProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CheckNameCollisionProxyImpl"));
    return new _CheckNameCollisionProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _CheckNameCollisionServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _checkNameCollisionMethodWithNameCollisionName:
        var r = CheckNameCollisionWithNameCollisionResponseParams.deserialize(
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
    return "_CheckNameCollisionProxyImpl($superString)";
  }
}


class _CheckNameCollisionProxyCalls implements CheckNameCollision {
  _CheckNameCollisionProxyImpl _proxyImpl;

  _CheckNameCollisionProxyCalls(this._proxyImpl);
    dynamic withNameCollision(bool message,bool response,[Function responseFactory = null]) {
      var params = new _CheckNameCollisionWithNameCollisionParams();
      params.message = message;
      params.response = response;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _checkNameCollisionMethodWithNameCollisionName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class CheckNameCollisionProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CheckNameCollision ptr;

  CheckNameCollisionProxy(_CheckNameCollisionProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CheckNameCollisionProxyCalls(proxyImpl);

  CheckNameCollisionProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CheckNameCollisionProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CheckNameCollisionProxyCalls(impl);
  }

  CheckNameCollisionProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CheckNameCollisionProxyImpl.fromHandle(handle) {
    ptr = new _CheckNameCollisionProxyCalls(impl);
  }

  CheckNameCollisionProxy.unbound() :
      impl = new _CheckNameCollisionProxyImpl.unbound() {
    ptr = new _CheckNameCollisionProxyCalls(impl);
  }

  factory CheckNameCollisionProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CheckNameCollisionProxy p = new CheckNameCollisionProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CheckNameCollisionProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CheckNameCollisionProxy"));
    return new CheckNameCollisionProxy.fromEndpoint(endpoint);
  }

  String get serviceName => CheckNameCollision.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CheckNameCollisionProxy($impl)";
  }
}


class CheckNameCollisionStub extends bindings.Stub {
  CheckNameCollision _impl = null;

  CheckNameCollisionStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CheckNameCollisionStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CheckNameCollisionStub.unbound() : super.unbound();

  static CheckNameCollisionStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CheckNameCollisionStub"));
    return new CheckNameCollisionStub.fromEndpoint(endpoint);
  }


  CheckNameCollisionWithNameCollisionResponseParams _checkNameCollisionWithNameCollisionResponseParamsFactory(bool message, bool response) {
    var result = new CheckNameCollisionWithNameCollisionResponseParams();
    result.message = message;
    result.response = response;
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
      case _checkNameCollisionMethodWithNameCollisionName:
        var params = _CheckNameCollisionWithNameCollisionParams.deserialize(
            message.payload);
        var response = _impl.withNameCollision(params.message,params.response,_checkNameCollisionWithNameCollisionResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _checkNameCollisionMethodWithNameCollisionName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _checkNameCollisionMethodWithNameCollisionName,
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

  CheckNameCollision get impl => _impl;
  set impl(CheckNameCollision d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CheckNameCollisionStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _CheckNameCollisionServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _checkEnumCapsMethodSetEnumWithInternalAllCapsName = 0;

class _CheckEnumCapsServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class CheckEnumCaps {
  static const String serviceName = null;
  void setEnumWithInternalAllCaps(EnumWithInternalAllCaps e);
}


class _CheckEnumCapsProxyImpl extends bindings.Proxy {
  _CheckEnumCapsProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CheckEnumCapsProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CheckEnumCapsProxyImpl.unbound() : super.unbound();

  static _CheckEnumCapsProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CheckEnumCapsProxyImpl"));
    return new _CheckEnumCapsProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _CheckEnumCapsServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_CheckEnumCapsProxyImpl($superString)";
  }
}


class _CheckEnumCapsProxyCalls implements CheckEnumCaps {
  _CheckEnumCapsProxyImpl _proxyImpl;

  _CheckEnumCapsProxyCalls(this._proxyImpl);
    void setEnumWithInternalAllCaps(EnumWithInternalAllCaps e) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CheckEnumCapsSetEnumWithInternalAllCapsParams();
      params.e = e;
      _proxyImpl.sendMessage(params, _checkEnumCapsMethodSetEnumWithInternalAllCapsName);
    }
}


class CheckEnumCapsProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CheckEnumCaps ptr;

  CheckEnumCapsProxy(_CheckEnumCapsProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CheckEnumCapsProxyCalls(proxyImpl);

  CheckEnumCapsProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CheckEnumCapsProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CheckEnumCapsProxyCalls(impl);
  }

  CheckEnumCapsProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CheckEnumCapsProxyImpl.fromHandle(handle) {
    ptr = new _CheckEnumCapsProxyCalls(impl);
  }

  CheckEnumCapsProxy.unbound() :
      impl = new _CheckEnumCapsProxyImpl.unbound() {
    ptr = new _CheckEnumCapsProxyCalls(impl);
  }

  factory CheckEnumCapsProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CheckEnumCapsProxy p = new CheckEnumCapsProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CheckEnumCapsProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CheckEnumCapsProxy"));
    return new CheckEnumCapsProxy.fromEndpoint(endpoint);
  }

  String get serviceName => CheckEnumCaps.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CheckEnumCapsProxy($impl)";
  }
}


class CheckEnumCapsStub extends bindings.Stub {
  CheckEnumCaps _impl = null;

  CheckEnumCapsStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CheckEnumCapsStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CheckEnumCapsStub.unbound() : super.unbound();

  static CheckEnumCapsStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CheckEnumCapsStub"));
    return new CheckEnumCapsStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _checkEnumCapsMethodSetEnumWithInternalAllCapsName:
        var params = _CheckEnumCapsSetEnumWithInternalAllCapsParams.deserialize(
            message.payload);
        _impl.setEnumWithInternalAllCaps(params.e);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  CheckEnumCaps get impl => _impl;
  set impl(CheckEnumCaps d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CheckEnumCapsStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _CheckEnumCapsServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _testInterfaceMethodSomeMessageName = 0;

class _TestInterfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class TestInterface {
  static const String serviceName = null;
  void someMessage();
}


class _TestInterfaceProxyImpl extends bindings.Proxy {
  _TestInterfaceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TestInterfaceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _TestInterfaceProxyImpl.unbound() : super.unbound();

  static _TestInterfaceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _TestInterfaceProxyImpl"));
    return new _TestInterfaceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _TestInterfaceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_TestInterfaceProxyImpl($superString)";
  }
}


class _TestInterfaceProxyCalls implements TestInterface {
  _TestInterfaceProxyImpl _proxyImpl;

  _TestInterfaceProxyCalls(this._proxyImpl);
    void someMessage() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _TestInterfaceSomeMessageParams();
      _proxyImpl.sendMessage(params, _testInterfaceMethodSomeMessageName);
    }
}


class TestInterfaceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  TestInterface ptr;

  TestInterfaceProxy(_TestInterfaceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TestInterfaceProxyCalls(proxyImpl);

  TestInterfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _TestInterfaceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TestInterfaceProxyCalls(impl);
  }

  TestInterfaceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _TestInterfaceProxyImpl.fromHandle(handle) {
    ptr = new _TestInterfaceProxyCalls(impl);
  }

  TestInterfaceProxy.unbound() :
      impl = new _TestInterfaceProxyImpl.unbound() {
    ptr = new _TestInterfaceProxyCalls(impl);
  }

  factory TestInterfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TestInterfaceProxy p = new TestInterfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static TestInterfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TestInterfaceProxy"));
    return new TestInterfaceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => TestInterface.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "TestInterfaceProxy($impl)";
  }
}


class TestInterfaceStub extends bindings.Stub {
  TestInterface _impl = null;

  TestInterfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  TestInterfaceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  TestInterfaceStub.unbound() : super.unbound();

  static TestInterfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TestInterfaceStub"));
    return new TestInterfaceStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _testInterfaceMethodSomeMessageName:
        _impl.someMessage();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  TestInterface get impl => _impl;
  set impl(TestInterface d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "TestInterfaceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _TestInterfaceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _regression551MethodGetName = 0;

class _Regression551ServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Regression551 {
  static const String serviceName = null;
  dynamic get(List<String> keyPrefixes,[Function responseFactory = null]);
}


class _Regression551ProxyImpl extends bindings.Proxy {
  _Regression551ProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _Regression551ProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _Regression551ProxyImpl.unbound() : super.unbound();

  static _Regression551ProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _Regression551ProxyImpl"));
    return new _Regression551ProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _Regression551ServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _regression551MethodGetName:
        var r = Regression551GetResponseParams.deserialize(
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
    return "_Regression551ProxyImpl($superString)";
  }
}


class _Regression551ProxyCalls implements Regression551 {
  _Regression551ProxyImpl _proxyImpl;

  _Regression551ProxyCalls(this._proxyImpl);
    dynamic get(List<String> keyPrefixes,[Function responseFactory = null]) {
      var params = new _Regression551GetParams();
      params.keyPrefixes = keyPrefixes;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _regression551MethodGetName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class Regression551Proxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Regression551 ptr;

  Regression551Proxy(_Regression551ProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _Regression551ProxyCalls(proxyImpl);

  Regression551Proxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _Regression551ProxyImpl.fromEndpoint(endpoint) {
    ptr = new _Regression551ProxyCalls(impl);
  }

  Regression551Proxy.fromHandle(core.MojoHandle handle) :
      impl = new _Regression551ProxyImpl.fromHandle(handle) {
    ptr = new _Regression551ProxyCalls(impl);
  }

  Regression551Proxy.unbound() :
      impl = new _Regression551ProxyImpl.unbound() {
    ptr = new _Regression551ProxyCalls(impl);
  }

  factory Regression551Proxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    Regression551Proxy p = new Regression551Proxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static Regression551Proxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For Regression551Proxy"));
    return new Regression551Proxy.fromEndpoint(endpoint);
  }

  String get serviceName => Regression551.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "Regression551Proxy($impl)";
  }
}


class Regression551Stub extends bindings.Stub {
  Regression551 _impl = null;

  Regression551Stub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  Regression551Stub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  Regression551Stub.unbound() : super.unbound();

  static Regression551Stub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For Regression551Stub"));
    return new Regression551Stub.fromEndpoint(endpoint);
  }


  Regression551GetResponseParams _regression551GetResponseParamsFactory(int result) {
    var result = new Regression551GetResponseParams();
    result.result = result;
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
      case _regression551MethodGetName:
        var params = _Regression551GetParams.deserialize(
            message.payload);
        var response = _impl.get(params.keyPrefixes,_regression551GetResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _regression551MethodGetName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _regression551MethodGetName,
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

  Regression551 get impl => _impl;
  set impl(Regression551 d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "Regression551Stub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _Regression551ServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _serviceNameMethodServiceNameName = 0;

class _ServiceNameServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ServiceName {
  static const String serviceName = null;
  dynamic serviceName_([Function responseFactory = null]);
}


class _ServiceNameProxyImpl extends bindings.Proxy {
  _ServiceNameProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ServiceNameProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ServiceNameProxyImpl.unbound() : super.unbound();

  static _ServiceNameProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ServiceNameProxyImpl"));
    return new _ServiceNameProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ServiceNameServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _serviceNameMethodServiceNameName:
        var r = ServiceNameServiceNameResponseParams.deserialize(
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
    return "_ServiceNameProxyImpl($superString)";
  }
}


class _ServiceNameProxyCalls implements ServiceName {
  _ServiceNameProxyImpl _proxyImpl;

  _ServiceNameProxyCalls(this._proxyImpl);
    dynamic serviceName_([Function responseFactory = null]) {
      var params = new _ServiceNameServiceNameParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _serviceNameMethodServiceNameName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ServiceNameProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ServiceName ptr;

  ServiceNameProxy(_ServiceNameProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ServiceNameProxyCalls(proxyImpl);

  ServiceNameProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ServiceNameProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ServiceNameProxyCalls(impl);
  }

  ServiceNameProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ServiceNameProxyImpl.fromHandle(handle) {
    ptr = new _ServiceNameProxyCalls(impl);
  }

  ServiceNameProxy.unbound() :
      impl = new _ServiceNameProxyImpl.unbound() {
    ptr = new _ServiceNameProxyCalls(impl);
  }

  factory ServiceNameProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ServiceNameProxy p = new ServiceNameProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ServiceNameProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ServiceNameProxy"));
    return new ServiceNameProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ServiceName.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ServiceNameProxy($impl)";
  }
}


class ServiceNameStub extends bindings.Stub {
  ServiceName _impl = null;

  ServiceNameStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ServiceNameStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ServiceNameStub.unbound() : super.unbound();

  static ServiceNameStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ServiceNameStub"));
    return new ServiceNameStub.fromEndpoint(endpoint);
  }


  ServiceNameServiceNameResponseParams _serviceNameServiceNameResponseParamsFactory(String serviceName_) {
    var result = new ServiceNameServiceNameResponseParams();
    result.serviceName_ = serviceName_;
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
      case _serviceNameMethodServiceNameName:
        var response = _impl.serviceName_(_serviceNameServiceNameResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _serviceNameMethodServiceNameName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _serviceNameMethodServiceNameName,
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

  ServiceName get impl => _impl;
  set impl(ServiceName d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ServiceNameStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ServiceNameServiceDescription();
    }
    return _cachedServiceDescription;
  }
}


mojom_types.RuntimeTypeInfo getRuntimeTypeInfo() => _runtimeTypeInfo ??
    _initRuntimeTypeInfo();

Map<String, mojom_types.UserDefinedType> getAllMojomTypeDefinitions() {
  return getRuntimeTypeInfo().typeMap;
}

var _runtimeTypeInfo;
mojom_types.RuntimeTypeInfo  _initRuntimeTypeInfo() {
  // serializedRuntimeTypeInfo contains the bytes of the Mojo serialization of
  // a mojom_types.RuntimeTypeInfo struct describing the Mojom types in this
  // file. The string contains the base64 encoding of the gzip-compressed bytes.
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+xdT3fbxhEHKDlWbCWR2ziRY9dxnNZR45j6Y8th7D5HFEWZqiRSj6QS+TUtRZOQyIj/ClKpfMtRRx/zEXLMUccee/RH8NFHH3Vrd4lZETvEAgsKBCGqeG/fEuQOsPvb2ZmdndnlpGJcE5DPQI6/Z/kYynG5jQtGfkTSRyT9Bt+/gvwt5LdUI09A/jPkv0H+GnIlZGRTkG9Dfgj5EeRvIJ8cMfIFyEuQv4T8FeRjo/B+yBuQf07SdZKyzzbiudX4s0e6tqtrzWa5Xsu1tGarGY5Klltsl7tP0l3bcrF8VavE8k0tS27jtf1qm26apC/s6UpaYY+Wj+UbTeUJKfvQufy61irVi9+XW6V4tdF6kdaajXqtqSnKA0L7lTN9klQ2Vq9UyvQHWs95ku7Z09VrrXy51ozqev5FagdaeIekm7Z08eKuZjz7T/blaEMyLX2/0CLlviFp1r48qQAFYCWZjaeT0bVopdJG0LjuQt86069K9i8rv1b/l6YX8hRsqOOfpeiS+9Xnms7qJ/++tLaj6VqtYLyP9u0fbemSdb2arzAGdOa/9MkX8/OzEv2U0fSfygWNchAp95Skb+3Lt7uUtgQ4J5GvFStaM5avVLQi3LSf8bXkcwwanp6O0keS9Cu1lqbv5AvoEZLjlQ7vkycoU1QG2pb/TtNb2kFJNeQola9UJG6pHXlLP74Z4eXvwTude/rT0cf8/asb/H3iDv+8hWn+fmqOvz96wL/v7Tx//8tjpC+eID2yyN+/XOLvEyt8/SbW+fvXGb4+vzxD9f8B1fcfPP3LPP/7cRH0EdJnxwqvbxYU/mJ6MgL5f+FKKNbXu/C+KNx/QtLvSBKoF8VKL18k6e8kbVJ+K9Wr2rS+X6xXyzVNn67Wf6xPN/WC8aGx/7xSLkyXGbs1p5+Xa8Vybbc53X7LdNdrKVnVhAvT7wuonfT3CyY97nSJcFNMuLX1uwNuzwXzjVmoT79xYfyhovdPonoCe0vPDzDek6a2q6b3+MWfi078uWjdDw/OOX/mBfw5HzD+jCru5rmy/NllL6j2+CYQX5YE+F4j6QpJ1rNkRfmSpNtWfCogwPUs+NQ/2yRdpvob3vtvwGeK2SdgfxyD/bR90cj/A8DPXAL9ehke8B7YN+/zuDI+nVJ74/sFyX6hsoFWaTGVWstlEyvJpx1+vyfVH2GOFPdLEUy/fvdLr/aZLN6qR3h/SNI4SUupzcW1eAfxr2HuKYE3R4rx1oYE75BHeP8exuvyWiqaNTE4tbHDcnhzpBjvnSHBe8RjeUKs8kiP8oQjxXjvDgneo97jPfuwZ7w7pBjv0pDgfcFjeUJAuz9HuHTWvTzhSDHe5SHB+x3v8X74IJctzdZ2e8C7Q4rx/nFI8L7oMd6bVApnc73gzZFivPeGBO8xj+eDm20p3CKouZ4PcqQY78qQ4P1uH/A2pLDB4C7xPiHFeFeHBO9LfcCbSuFEb/x9QorxrgUc7ym07nciP9Te7PgtAc5XYSmB9yZ2/HMObscuXJ8AD/Qb10nBOte4yea2Wr/CuB6fcl1wQUB/G9ZQM1rL1uGI2/GtT3wpWk8+DMm33249ma3Lidt/T9f+uU/qZI0Du87rerKmiPlj3kf+UND7Wb0/JYm6FkXMfVo/vOy6s0hOTknKyQ3EzweCfqG+8xtMTgqjKOzsZ3tC3M+XBixHJ0xraSp8HzKVOxyxl6csXscrecr85RS7+n5rI68TtUlaG60VOShxey4PWJ4eK97I0xnAwKn9TKoOSp6OSYxfsx2EcTtR3qo73DYEuLE4GwncOoN4gPrILX6i8RcZkfM/mHFUbcYfje35A+AoBNECt/EBj78xj+YzLL7Jtv2mKU2Q5zNurn7Hb4wDrn7j4jbOwis5HgbbyomP2IA6q3KIXZOS8zDZeAAWl2IdjdqJ35QMX+3C94MzZr8yuyQy2tu4jTjEXbQjULthtowPH4ScZ+2fGHE3PkV67jNoe1e7eXN1YOMSz8NxnM2g5PwH4EuoklrndzVL/rjmAz694KC6xEG1wWECxqousEcmIE54kPouZKPvvB5PbB3MajyZJ9z/H0/uxtMVKHPex9MVsEuCOp7Y/Oco5M385zr4Wq131XT2eUhuw+niq+8DFMcbslmf73W8zQjo6R4LGkqZp/Dk6js5jQBk4d/YAt+Un+uvtO5sHXpMMM/G/Mfie/hdPe73AQUlPn0cYp+MXWHGmL9qxedQAPfbHeV8x6f/JJi3fuGTvXML6QZs97wPsT/GridFen9Ur/zJ/Khjqjd+VBb/wu9G7PgNHLYtdvVL2Cd+dWvn9yvO38mfxNa/Zd1IuJ4Rxb99GCMmnA5VPlDWqzj9iCSubP6UyUaTS9H0EvPLyeIYZoSC/v/GJ7v/tP5EjPuMR/H6DYf42uXNtbVMLB2PJ43vH0NMiDT+6AEY/0dDhn/II/yvgO5bWV+PpzMr38VNeM25wR89AOP/+Izg32Vfe6T3GM78rviO3e+wfb6rXrd9ktNY32H+nFD5es2ovcnlDYd52SqKLxDjFV61wutzn/jP7bkIEx2V19d5A1untj5lwWZ/oIAA1/OaT/yI16EOVG/nC7Jxl2w8b1Tytby+PPsQvmfngzjjGOZIMZ6fBCbu0poB/N7Xh/C+P9cz3gYpxvt6wPHul176GNZH8SkqzK50Om4F1+tmQPTSJNJLC3A/6lIviXB7D9q5l5vLzZr81U54hYEA4/apT/zX63k6TE+N+qyn+NN5JPQUIsD1/HBAeupXgZ5KID5tqJ1x5CYe89DBT7uXy5DpbjyVI1Yq7ffFFLFVc+srMShH7da/SOEatn0Uxvtq4OQqzyCMr29KyBHVJEduei5H1qNbpvhFqX4gJBjvjwKOt+gcPVk+pcccxd2915Zh+6VXRX4Fdp6Igzuhq17pAcmtbdV+XJx2Pc5pXCyvpDNZ0Fmf2eMWZmWt8Mv4NC7c+o1kcVU9wpX5DzLxWCq5ZKNPTbiysla4ZgOKq9/7wvhT/mz2haGCGM+/nbG4utcMrxFv/XGXQS8/1VqWfPfDgOLoWHunXMZLzzj4w0g7uci5IMdF+xlvwPa37mkvcg1d2ykfGCdJWvHDoOINVOQfVGzGj6zflfHZW9UbPmM4GnzWiSgLevz9BZ/8/0wvktruV1rW/PWVEpz4e7/0G5NP/Km0NuvwqCDGMXfG9NsbhmvIW7nGcG0iXHG9twek596gXFb+RBzi8UztDYS+O+0+PIbPRMgbnG6ArOZxOhvyWvVxXuBm/Fz3CR8v9H4EhNOBAz9tSa7/sf14cqeEKyfn4/d4zHgX/ssBi5P1K56QxaWXABiMy1P4PIj56mgf5qvM/5cIuVu3Fp0jwPbR2p9Kb3NulgMh7o/FAPHpaID4NAZ+17MiP1n8ya8u+fBnAT7MD+r07wbCeEG5v0Xowj15TuOwnfgxNQC5qVjwG1v34/+twv3/WwTN3hO1S7ieiQri/vrrGbX3+jVfzZDmr8NeNatxvzpk9p6pvUNh7zH7puHRfh28n4PF9wu2cXTh9qVyvvfriM6huav4s+/zFvLPYT0h2u/i9v+6ZPXE/wIAAP//7P26u6huAAA=";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
