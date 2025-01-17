// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library test_unions_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:_mojo_for_test_only/mojo/test/test_included_unions.mojom.dart' as test_included_unions_mojom;

class AnEnum extends bindings.MojoEnum {
  static const AnEnum first = const AnEnum._(0);
  static const AnEnum second = const AnEnum._(1);

  const AnEnum._(int v) : super(v);

  static const Map<String, AnEnum> valuesMap = const {
    "first": first,
    "second": second,
  };
  static const List<AnEnum> values = const [
    first,
    second,
  ];

  static AnEnum valueOf(String name) => valuesMap[name];

  factory AnEnum(int v) {
    switch (v) {
      case 0:
        return AnEnum.first;
      case 1:
        return AnEnum.second;
      default:
        return null;
    }
  }

  static AnEnum decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    AnEnum result = new AnEnum(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum AnEnum.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case first:
        return 'AnEnum.first';
      case second:
        return 'AnEnum.second';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class StructOfUnions extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(56, 0)
  ];
  ObjectUnion u = null;
  List<ObjectUnion> aOu = null;
  List<HandleUnion> aHu = null;
  Map<int, ObjectUnion> mOu = null;
  Map<int, HandleUnion> mHu = null;

  StructOfUnions() : super(kVersions.last.size);

  static StructOfUnions deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructOfUnions decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructOfUnions result = new StructOfUnions();

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
      
        result.u = ObjectUnion.decode(decoder0, 8);
        if (result.u == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ObjectUnion.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      {
        var si1 = decoder1.decodeDataHeaderForUnionArray(bindings.kUnspecifiedArrayLength);
        result.aOu = new List<ObjectUnion>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
            result.aOu[i1] = ObjectUnion.decode(decoder1, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1);
            if (result.aOu[i1] == null) {
              throw new bindings.MojoCodecError(
                'Trying to decode null union for non-nullable ObjectUnion.');
            }
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      {
        var si1 = decoder1.decodeDataHeaderForUnionArray(bindings.kUnspecifiedArrayLength);
        result.aHu = new List<HandleUnion>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
            result.aHu[i1] = HandleUnion.decode(decoder1, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1);
            if (result.aHu[i1] == null) {
              throw new bindings.MojoCodecError(
                'Trying to decode null union for non-nullable HandleUnion.');
            }
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<ObjectUnion> values0;
        {
          
          keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForUnionArray(keys0.length);
            values0 = new List<ObjectUnion>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
                values0[i2] = ObjectUnion.decode(decoder2, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i2);
                if (values0[i2] == null) {
                  throw new bindings.MojoCodecError(
                    'Trying to decode null union for non-nullable ObjectUnion.');
                }
            }
          }
        }
        result.mOu = new Map<int, ObjectUnion>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(48, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<HandleUnion> values0;
        {
          
          keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForUnionArray(keys0.length);
            values0 = new List<HandleUnion>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
                values0[i2] = HandleUnion.decode(decoder2, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i2);
                if (values0[i2] == null) {
                  throw new bindings.MojoCodecError(
                    'Trying to decode null union for non-nullable HandleUnion.');
                }
            }
          }
        }
        result.mHu = new Map<int, HandleUnion>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUnion(u, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "u of struct StructOfUnions: $e";
      rethrow;
    }
    try {
      if (aOu == null) {
        encoder0.encodeNullPointer(24, false);
      } else {
        var encoder1 = encoder0.encodeUnionArray(aOu.length, 24, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < aOu.length; ++i0) {
          encoder1.encodeUnion(aOu[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "aOu of struct StructOfUnions: $e";
      rethrow;
    }
    try {
      if (aHu == null) {
        encoder0.encodeNullPointer(32, false);
      } else {
        var encoder1 = encoder0.encodeUnionArray(aHu.length, 32, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < aHu.length; ++i0) {
          encoder1.encodeUnion(aHu[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "aHu of struct StructOfUnions: $e";
      rethrow;
    }
    try {
      if (mOu == null) {
        encoder0.encodeNullPointer(40, false);
      } else {
        var encoder1 = encoder0.encoderForMap(40);
        var keys0 = mOu.keys.toList();
        var values0 = mOu.values.toList();
        encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        
        {
          var encoder2 = encoder1.encodeUnionArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeUnion(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1, false);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mOu of struct StructOfUnions: $e";
      rethrow;
    }
    try {
      if (mHu == null) {
        encoder0.encodeNullPointer(48, false);
      } else {
        var encoder1 = encoder0.encoderForMap(48);
        var keys0 = mHu.keys.toList();
        var values0 = mHu.values.toList();
        encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        
        {
          var encoder2 = encoder1.encodeUnionArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeUnion(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1, false);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mHu of struct StructOfUnions: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructOfUnions("
           "u: $u" ", "
           "aOu: $aOu" ", "
           "aHu: $aHu" ", "
           "mOu: $mOu" ", "
           "mHu: $mHu" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class WrapperStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(56, 0)
  ];
  ObjectUnion objectUnion = null;
  PodUnion podUnion = null;
  HandleUnion handleUnion = null;

  WrapperStruct() : super(kVersions.last.size);

  static WrapperStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static WrapperStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    WrapperStruct result = new WrapperStruct();

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
      
        result.objectUnion = ObjectUnion.decode(decoder0, 8);
    }
    if (mainDataHeader.version >= 0) {
      
        result.podUnion = PodUnion.decode(decoder0, 24);
    }
    if (mainDataHeader.version >= 0) {
      
        result.handleUnion = HandleUnion.decode(decoder0, 40);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUnion(objectUnion, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "objectUnion of struct WrapperStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeUnion(podUnion, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "podUnion of struct WrapperStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeUnion(handleUnion, 40, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "handleUnion of struct WrapperStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "WrapperStruct("
           "objectUnion: $objectUnion" ", "
           "podUnion: $podUnion" ", "
           "handleUnion: $handleUnion" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class DummyStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int fInt8 = 0;

  DummyStruct() : super(kVersions.last.size);

  static DummyStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DummyStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DummyStruct result = new DummyStruct();

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
      
      result.fInt8 = decoder0.decodeInt8(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt8(fInt8, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt8 of struct DummyStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "DummyStruct("
           "fInt8: $fInt8" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fInt8"] = fInt8;
    return map;
  }
}


class SmallStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(72, 0)
  ];
  DummyStruct dummyStruct = null;
  PodUnion podUnion = null;
  List<PodUnion> podUnionArray = null;
  List<PodUnion> nullablePodUnionArray = null;
  List<DummyStruct> sArray = null;
  Map<String, PodUnion> podUnionMap = null;
  Map<String, PodUnion> nullablePodUnionMap = null;

  SmallStruct() : super(kVersions.last.size);

  static SmallStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SmallStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SmallStruct result = new SmallStruct();

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
      result.dummyStruct = DummyStruct.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
        result.podUnion = PodUnion.decode(decoder0, 16);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, true);
      if (decoder1 == null) {
        result.podUnionArray = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForUnionArray(bindings.kUnspecifiedArrayLength);
        result.podUnionArray = new List<PodUnion>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
            result.podUnionArray[i1] = PodUnion.decode(decoder1, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1);
            if (result.podUnionArray[i1] == null) {
              throw new bindings.MojoCodecError(
                'Trying to decode null union for non-nullable PodUnion.');
            }
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, true);
      if (decoder1 == null) {
        result.nullablePodUnionArray = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForUnionArray(bindings.kUnspecifiedArrayLength);
        result.nullablePodUnionArray = new List<PodUnion>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
            result.nullablePodUnionArray[i1] = PodUnion.decode(decoder1, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(48, true);
      if (decoder1 == null) {
        result.sArray = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.sArray = new List<DummyStruct>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.sArray[i1] = DummyStruct.decode(decoder2);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(56, true);
      if (decoder1 == null) {
        result.podUnionMap = null;
      } else {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<PodUnion> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForUnionArray(keys0.length);
            values0 = new List<PodUnion>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
                values0[i2] = PodUnion.decode(decoder2, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i2);
                if (values0[i2] == null) {
                  throw new bindings.MojoCodecError(
                    'Trying to decode null union for non-nullable PodUnion.');
                }
            }
          }
        }
        result.podUnionMap = new Map<String, PodUnion>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(64, true);
      if (decoder1 == null) {
        result.nullablePodUnionMap = null;
      } else {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<PodUnion> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForUnionArray(keys0.length);
            values0 = new List<PodUnion>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
                values0[i2] = PodUnion.decode(decoder2, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i2);
            }
          }
        }
        result.nullablePodUnionMap = new Map<String, PodUnion>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(dummyStruct, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "dummyStruct of struct SmallStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeUnion(podUnion, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "podUnion of struct SmallStruct: $e";
      rethrow;
    }
    try {
      if (podUnionArray == null) {
        encoder0.encodeNullPointer(32, true);
      } else {
        var encoder1 = encoder0.encodeUnionArray(podUnionArray.length, 32, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < podUnionArray.length; ++i0) {
          encoder1.encodeUnion(podUnionArray[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "podUnionArray of struct SmallStruct: $e";
      rethrow;
    }
    try {
      if (nullablePodUnionArray == null) {
        encoder0.encodeNullPointer(40, true);
      } else {
        var encoder1 = encoder0.encodeUnionArray(nullablePodUnionArray.length, 40, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < nullablePodUnionArray.length; ++i0) {
          encoder1.encodeUnion(nullablePodUnionArray[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i0, true);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "nullablePodUnionArray of struct SmallStruct: $e";
      rethrow;
    }
    try {
      if (sArray == null) {
        encoder0.encodeNullPointer(48, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(sArray.length, 48, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < sArray.length; ++i0) {
          encoder1.encodeStruct(sArray[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sArray of struct SmallStruct: $e";
      rethrow;
    }
    try {
      if (podUnionMap == null) {
        encoder0.encodeNullPointer(56, true);
      } else {
        var encoder1 = encoder0.encoderForMap(56);
        var keys0 = podUnionMap.keys.toList();
        var values0 = podUnionMap.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodeUnionArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeUnion(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1, false);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "podUnionMap of struct SmallStruct: $e";
      rethrow;
    }
    try {
      if (nullablePodUnionMap == null) {
        encoder0.encodeNullPointer(64, true);
      } else {
        var encoder1 = encoder0.encoderForMap(64);
        var keys0 = nullablePodUnionMap.keys.toList();
        var values0 = nullablePodUnionMap.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodeUnionArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeUnion(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1, true);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "nullablePodUnionMap of struct SmallStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "SmallStruct("
           "dummyStruct: $dummyStruct" ", "
           "podUnion: $podUnion" ", "
           "podUnionArray: $podUnionArray" ", "
           "nullablePodUnionArray: $nullablePodUnionArray" ", "
           "sArray: $sArray" ", "
           "podUnionMap: $podUnionMap" ", "
           "nullablePodUnionMap: $nullablePodUnionMap" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["dummyStruct"] = dummyStruct;
    map["podUnion"] = podUnion;
    map["podUnionArray"] = podUnionArray;
    map["nullablePodUnionArray"] = nullablePodUnionArray;
    map["sArray"] = sArray;
    map["podUnionMap"] = podUnionMap;
    map["nullablePodUnionMap"] = nullablePodUnionMap;
    return map;
  }
}


class SmallStructNonNullableUnion extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  PodUnion podUnion = null;

  SmallStructNonNullableUnion() : super(kVersions.last.size);

  static SmallStructNonNullableUnion deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SmallStructNonNullableUnion decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SmallStructNonNullableUnion result = new SmallStructNonNullableUnion();

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
      
        result.podUnion = PodUnion.decode(decoder0, 8);
        if (result.podUnion == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable PodUnion.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUnion(podUnion, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "podUnion of struct SmallStructNonNullableUnion: $e";
      rethrow;
    }
  }

  String toString() {
    return "SmallStructNonNullableUnion("
           "podUnion: $podUnion" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["podUnion"] = podUnion;
    return map;
  }
}


class StructNullObjectUnion extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  ObjectOnlyUnion objUnion = null;

  StructNullObjectUnion() : super(kVersions.last.size);

  static StructNullObjectUnion deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructNullObjectUnion decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructNullObjectUnion result = new StructNullObjectUnion();

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
      
        result.objUnion = ObjectOnlyUnion.decode(decoder0, 8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUnion(objUnion, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "objUnion of struct StructNullObjectUnion: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructNullObjectUnion("
           "objUnion: $objUnion" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["objUnion"] = objUnion;
    return map;
  }
}


class SmallObjStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  ObjectUnion objUnion = null;
  int fInt8 = 0;

  SmallObjStruct() : super(kVersions.last.size);

  static SmallObjStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SmallObjStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SmallObjStruct result = new SmallObjStruct();

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
      
        result.objUnion = ObjectUnion.decode(decoder0, 8);
        if (result.objUnion == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ObjectUnion.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.fInt8 = decoder0.decodeInt8(24);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUnion(objUnion, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "objUnion of struct SmallObjStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8(fInt8, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt8 of struct SmallObjStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "SmallObjStruct("
           "objUnion: $objUnion" ", "
           "fInt8: $fInt8" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["objUnion"] = objUnion;
    map["fInt8"] = fInt8;
    return map;
  }
}


class TryNonNullStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  DummyStruct nullable = null;
  DummyStruct nonNullable = null;

  TryNonNullStruct() : super(kVersions.last.size);

  static TryNonNullStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TryNonNullStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TryNonNullStruct result = new TryNonNullStruct();

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
      result.nullable = DummyStruct.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.nonNullable = DummyStruct.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(nullable, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "nullable of struct TryNonNullStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(nonNullable, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "nonNullable of struct TryNonNullStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "TryNonNullStruct("
           "nullable: $nullable" ", "
           "nonNullable: $nonNullable" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["nullable"] = nullable;
    map["nonNullable"] = nonNullable;
    return map;
  }
}


class IncludingStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  test_included_unions_mojom.IncludedUnion a = null;

  IncludingStruct() : super(kVersions.last.size);

  static IncludingStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static IncludingStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    IncludingStruct result = new IncludingStruct();

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
      
        result.a = test_included_unions_mojom.IncludedUnion.decode(decoder0, 8);
        if (result.a == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable test_included_unions_mojom.IncludedUnion.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUnion(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct IncludingStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "IncludingStruct("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}


class _SmallCacheSetIntValueParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int intValue = 0;

  _SmallCacheSetIntValueParams() : super(kVersions.last.size);

  static _SmallCacheSetIntValueParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SmallCacheSetIntValueParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SmallCacheSetIntValueParams result = new _SmallCacheSetIntValueParams();

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
      
      result.intValue = decoder0.decodeInt64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(intValue, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "intValue of struct _SmallCacheSetIntValueParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SmallCacheSetIntValueParams("
           "intValue: $intValue" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["intValue"] = intValue;
    return map;
  }
}


class _SmallCacheGetIntValueParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _SmallCacheGetIntValueParams() : super(kVersions.last.size);

  static _SmallCacheGetIntValueParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SmallCacheGetIntValueParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SmallCacheGetIntValueParams result = new _SmallCacheGetIntValueParams();

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
    return "_SmallCacheGetIntValueParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class SmallCacheGetIntValueResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int intValue = 0;

  SmallCacheGetIntValueResponseParams() : super(kVersions.last.size);

  static SmallCacheGetIntValueResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SmallCacheGetIntValueResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SmallCacheGetIntValueResponseParams result = new SmallCacheGetIntValueResponseParams();

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
      
      result.intValue = decoder0.decodeInt64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(intValue, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "intValue of struct SmallCacheGetIntValueResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "SmallCacheGetIntValueResponseParams("
           "intValue: $intValue" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["intValue"] = intValue;
    return map;
  }
}


class _UnionInterfaceEchoParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  PodUnion inVal = null;

  _UnionInterfaceEchoParams() : super(kVersions.last.size);

  static _UnionInterfaceEchoParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UnionInterfaceEchoParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UnionInterfaceEchoParams result = new _UnionInterfaceEchoParams();

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
      
        result.inVal = PodUnion.decode(decoder0, 8);
        if (result.inVal == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable PodUnion.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUnion(inVal, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "inVal of struct _UnionInterfaceEchoParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UnionInterfaceEchoParams("
           "inVal: $inVal" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["inVal"] = inVal;
    return map;
  }
}


class UnionInterfaceEchoResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  PodUnion outVal = null;

  UnionInterfaceEchoResponseParams() : super(kVersions.last.size);

  static UnionInterfaceEchoResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UnionInterfaceEchoResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UnionInterfaceEchoResponseParams result = new UnionInterfaceEchoResponseParams();

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
      
        result.outVal = PodUnion.decode(decoder0, 8);
        if (result.outVal == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable PodUnion.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUnion(outVal, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "outVal of struct UnionInterfaceEchoResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UnionInterfaceEchoResponseParams("
           "outVal: $outVal" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["outVal"] = outVal;
    return map;
  }
}



enum PodUnionTag {
  fInt8,
  fInt8Other,
  fUint8,
  fInt16,
  fUint16,
  fInt32,
  fUint32,
  fInt64,
  fUint64,
  fFloat,
  fDouble,
  fBool,
  fEnum,
  unknown
}

class PodUnion extends bindings.Union {
  static final _tagToInt = const {
    PodUnionTag.fInt8: 0,
    PodUnionTag.fInt8Other: 1,
    PodUnionTag.fUint8: 2,
    PodUnionTag.fInt16: 3,
    PodUnionTag.fUint16: 4,
    PodUnionTag.fInt32: 5,
    PodUnionTag.fUint32: 6,
    PodUnionTag.fInt64: 7,
    PodUnionTag.fUint64: 8,
    PodUnionTag.fFloat: 9,
    PodUnionTag.fDouble: 10,
    PodUnionTag.fBool: 11,
    PodUnionTag.fEnum: 12,
  };

  static final _intToTag = const {
    0: PodUnionTag.fInt8,
    1: PodUnionTag.fInt8Other,
    2: PodUnionTag.fUint8,
    3: PodUnionTag.fInt16,
    4: PodUnionTag.fUint16,
    5: PodUnionTag.fInt32,
    6: PodUnionTag.fUint32,
    7: PodUnionTag.fInt64,
    8: PodUnionTag.fUint64,
    9: PodUnionTag.fFloat,
    10: PodUnionTag.fDouble,
    11: PodUnionTag.fBool,
    12: PodUnionTag.fEnum,
  };

  var _data;
  PodUnionTag _tag = PodUnionTag.unknown;

  PodUnionTag get tag => _tag;
  int get fInt8 {
    if (_tag != PodUnionTag.fInt8) {
      throw new bindings.UnsetUnionTagError(_tag, PodUnionTag.fInt8);
    }
    return _data;
  }

  set fInt8(int value) {
    _tag = PodUnionTag.fInt8;
    _data = value;
  }
  int get fInt8Other {
    if (_tag != PodUnionTag.fInt8Other) {
      throw new bindings.UnsetUnionTagError(_tag, PodUnionTag.fInt8Other);
    }
    return _data;
  }

  set fInt8Other(int value) {
    _tag = PodUnionTag.fInt8Other;
    _data = value;
  }
  int get fUint8 {
    if (_tag != PodUnionTag.fUint8) {
      throw new bindings.UnsetUnionTagError(_tag, PodUnionTag.fUint8);
    }
    return _data;
  }

  set fUint8(int value) {
    _tag = PodUnionTag.fUint8;
    _data = value;
  }
  int get fInt16 {
    if (_tag != PodUnionTag.fInt16) {
      throw new bindings.UnsetUnionTagError(_tag, PodUnionTag.fInt16);
    }
    return _data;
  }

  set fInt16(int value) {
    _tag = PodUnionTag.fInt16;
    _data = value;
  }
  int get fUint16 {
    if (_tag != PodUnionTag.fUint16) {
      throw new bindings.UnsetUnionTagError(_tag, PodUnionTag.fUint16);
    }
    return _data;
  }

  set fUint16(int value) {
    _tag = PodUnionTag.fUint16;
    _data = value;
  }
  int get fInt32 {
    if (_tag != PodUnionTag.fInt32) {
      throw new bindings.UnsetUnionTagError(_tag, PodUnionTag.fInt32);
    }
    return _data;
  }

  set fInt32(int value) {
    _tag = PodUnionTag.fInt32;
    _data = value;
  }
  int get fUint32 {
    if (_tag != PodUnionTag.fUint32) {
      throw new bindings.UnsetUnionTagError(_tag, PodUnionTag.fUint32);
    }
    return _data;
  }

  set fUint32(int value) {
    _tag = PodUnionTag.fUint32;
    _data = value;
  }
  int get fInt64 {
    if (_tag != PodUnionTag.fInt64) {
      throw new bindings.UnsetUnionTagError(_tag, PodUnionTag.fInt64);
    }
    return _data;
  }

  set fInt64(int value) {
    _tag = PodUnionTag.fInt64;
    _data = value;
  }
  int get fUint64 {
    if (_tag != PodUnionTag.fUint64) {
      throw new bindings.UnsetUnionTagError(_tag, PodUnionTag.fUint64);
    }
    return _data;
  }

  set fUint64(int value) {
    _tag = PodUnionTag.fUint64;
    _data = value;
  }
  double get fFloat {
    if (_tag != PodUnionTag.fFloat) {
      throw new bindings.UnsetUnionTagError(_tag, PodUnionTag.fFloat);
    }
    return _data;
  }

  set fFloat(double value) {
    _tag = PodUnionTag.fFloat;
    _data = value;
  }
  double get fDouble {
    if (_tag != PodUnionTag.fDouble) {
      throw new bindings.UnsetUnionTagError(_tag, PodUnionTag.fDouble);
    }
    return _data;
  }

  set fDouble(double value) {
    _tag = PodUnionTag.fDouble;
    _data = value;
  }
  bool get fBool {
    if (_tag != PodUnionTag.fBool) {
      throw new bindings.UnsetUnionTagError(_tag, PodUnionTag.fBool);
    }
    return _data;
  }

  set fBool(bool value) {
    _tag = PodUnionTag.fBool;
    _data = value;
  }
  AnEnum get fEnum {
    if (_tag != PodUnionTag.fEnum) {
      throw new bindings.UnsetUnionTagError(_tag, PodUnionTag.fEnum);
    }
    return _data;
  }

  set fEnum(AnEnum value) {
    _tag = PodUnionTag.fEnum;
    _data = value;
  }

  static PodUnion decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    PodUnion result = new PodUnion();

    
    PodUnionTag tag = _intToTag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case PodUnionTag.fInt8:
        
        result.fInt8 = decoder0.decodeInt8(offset + 8);
        break;
      case PodUnionTag.fInt8Other:
        
        result.fInt8Other = decoder0.decodeInt8(offset + 8);
        break;
      case PodUnionTag.fUint8:
        
        result.fUint8 = decoder0.decodeUint8(offset + 8);
        break;
      case PodUnionTag.fInt16:
        
        result.fInt16 = decoder0.decodeInt16(offset + 8);
        break;
      case PodUnionTag.fUint16:
        
        result.fUint16 = decoder0.decodeUint16(offset + 8);
        break;
      case PodUnionTag.fInt32:
        
        result.fInt32 = decoder0.decodeInt32(offset + 8);
        break;
      case PodUnionTag.fUint32:
        
        result.fUint32 = decoder0.decodeUint32(offset + 8);
        break;
      case PodUnionTag.fInt64:
        
        result.fInt64 = decoder0.decodeInt64(offset + 8);
        break;
      case PodUnionTag.fUint64:
        
        result.fUint64 = decoder0.decodeUint64(offset + 8);
        break;
      case PodUnionTag.fFloat:
        
        result.fFloat = decoder0.decodeFloat(offset + 8);
        break;
      case PodUnionTag.fDouble:
        
        result.fDouble = decoder0.decodeDouble(offset + 8);
        break;
      case PodUnionTag.fBool:
        
        result.fBool = decoder0.decodeBool(offset + 8, 0);
        break;
      case PodUnionTag.fEnum:
        
          result.fEnum = AnEnum.decode(decoder0, offset + 8);
          if (result.fEnum == null) {
            throw new bindings.MojoCodecError(
              'Trying to decode null union for non-nullable AnEnum.');
          }
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tagToInt[_tag], offset + 4);
    switch (_tag) {
      case PodUnionTag.fInt8:
        encoder0.encodeInt8(fInt8, offset + 8);
        break;
      case PodUnionTag.fInt8Other:
        encoder0.encodeInt8(fInt8Other, offset + 8);
        break;
      case PodUnionTag.fUint8:
        encoder0.encodeUint8(fUint8, offset + 8);
        break;
      case PodUnionTag.fInt16:
        encoder0.encodeInt16(fInt16, offset + 8);
        break;
      case PodUnionTag.fUint16:
        encoder0.encodeUint16(fUint16, offset + 8);
        break;
      case PodUnionTag.fInt32:
        encoder0.encodeInt32(fInt32, offset + 8);
        break;
      case PodUnionTag.fUint32:
        encoder0.encodeUint32(fUint32, offset + 8);
        break;
      case PodUnionTag.fInt64:
        encoder0.encodeInt64(fInt64, offset + 8);
        break;
      case PodUnionTag.fUint64:
        encoder0.encodeUint64(fUint64, offset + 8);
        break;
      case PodUnionTag.fFloat:
        encoder0.encodeFloat(fFloat, offset + 8);
        break;
      case PodUnionTag.fDouble:
        encoder0.encodeDouble(fDouble, offset + 8);
        break;
      case PodUnionTag.fBool:
        encoder0.encodeBool(fBool, offset + 8, 0);
        break;
      case PodUnionTag.fEnum:
        encoder0.encodeEnum(fEnum, offset + 8);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "PodUnion(";
    switch (_tag) {
      case PodUnionTag.fInt8:
        result += "fInt8";
        break;
      case PodUnionTag.fInt8Other:
        result += "fInt8Other";
        break;
      case PodUnionTag.fUint8:
        result += "fUint8";
        break;
      case PodUnionTag.fInt16:
        result += "fInt16";
        break;
      case PodUnionTag.fUint16:
        result += "fUint16";
        break;
      case PodUnionTag.fInt32:
        result += "fInt32";
        break;
      case PodUnionTag.fUint32:
        result += "fUint32";
        break;
      case PodUnionTag.fInt64:
        result += "fInt64";
        break;
      case PodUnionTag.fUint64:
        result += "fUint64";
        break;
      case PodUnionTag.fFloat:
        result += "fFloat";
        break;
      case PodUnionTag.fDouble:
        result += "fDouble";
        break;
      case PodUnionTag.fBool:
        result += "fBool";
        break;
      case PodUnionTag.fEnum:
        result += "fEnum";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}


enum UnionOfUnionsTag {
  u,
  aOu,
  aHu,
  mOu,
  mHu,
  unknown
}

class UnionOfUnions extends bindings.Union {
  static final _tagToInt = const {
    UnionOfUnionsTag.u: 0,
    UnionOfUnionsTag.aOu: 1,
    UnionOfUnionsTag.aHu: 2,
    UnionOfUnionsTag.mOu: 3,
    UnionOfUnionsTag.mHu: 4,
  };

  static final _intToTag = const {
    0: UnionOfUnionsTag.u,
    1: UnionOfUnionsTag.aOu,
    2: UnionOfUnionsTag.aHu,
    3: UnionOfUnionsTag.mOu,
    4: UnionOfUnionsTag.mHu,
  };

  var _data;
  UnionOfUnionsTag _tag = UnionOfUnionsTag.unknown;

  UnionOfUnionsTag get tag => _tag;
  ObjectUnion get u {
    if (_tag != UnionOfUnionsTag.u) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfUnionsTag.u);
    }
    return _data;
  }

  set u(ObjectUnion value) {
    _tag = UnionOfUnionsTag.u;
    _data = value;
  }
  List<ObjectUnion> get aOu {
    if (_tag != UnionOfUnionsTag.aOu) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfUnionsTag.aOu);
    }
    return _data;
  }

  set aOu(List<ObjectUnion> value) {
    _tag = UnionOfUnionsTag.aOu;
    _data = value;
  }
  List<HandleUnion> get aHu {
    if (_tag != UnionOfUnionsTag.aHu) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfUnionsTag.aHu);
    }
    return _data;
  }

  set aHu(List<HandleUnion> value) {
    _tag = UnionOfUnionsTag.aHu;
    _data = value;
  }
  Map<int, ObjectUnion> get mOu {
    if (_tag != UnionOfUnionsTag.mOu) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfUnionsTag.mOu);
    }
    return _data;
  }

  set mOu(Map<int, ObjectUnion> value) {
    _tag = UnionOfUnionsTag.mOu;
    _data = value;
  }
  Map<int, HandleUnion> get mHu {
    if (_tag != UnionOfUnionsTag.mHu) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfUnionsTag.mHu);
    }
    return _data;
  }

  set mHu(Map<int, HandleUnion> value) {
    _tag = UnionOfUnionsTag.mHu;
    _data = value;
  }

  static UnionOfUnions decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    UnionOfUnions result = new UnionOfUnions();

    
    UnionOfUnionsTag tag = _intToTag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case UnionOfUnionsTag.u:
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.u = ObjectUnion.decode(decoder1, 0);
        break;
      case UnionOfUnionsTag.aOu:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          var si1 = decoder1.decodeDataHeaderForUnionArray(bindings.kUnspecifiedArrayLength);
          result.aOu = new List<ObjectUnion>(si1.numElements);
          for (int i1 = 0; i1 < si1.numElements; ++i1) {
            
              result.aOu[i1] = ObjectUnion.decode(decoder1, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1);
              if (result.aOu[i1] == null) {
                throw new bindings.MojoCodecError(
                  'Trying to decode null union for non-nullable ObjectUnion.');
              }
          }
        }
        break;
      case UnionOfUnionsTag.aHu:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          var si1 = decoder1.decodeDataHeaderForUnionArray(bindings.kUnspecifiedArrayLength);
          result.aHu = new List<HandleUnion>(si1.numElements);
          for (int i1 = 0; i1 < si1.numElements; ++i1) {
            
              result.aHu[i1] = HandleUnion.decode(decoder1, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1);
              if (result.aHu[i1] == null) {
                throw new bindings.MojoCodecError(
                  'Trying to decode null union for non-nullable HandleUnion.');
              }
          }
        }
        break;
      case UnionOfUnionsTag.mOu:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          decoder1.decodeDataHeaderForMap();
          List<int> keys0;
          List<ObjectUnion> values0;
          {
            
            keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          }
          {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
            {
              var si2 = decoder2.decodeDataHeaderForUnionArray(keys0.length);
              values0 = new List<ObjectUnion>(si2.numElements);
              for (int i2 = 0; i2 < si2.numElements; ++i2) {
                
                  values0[i2] = ObjectUnion.decode(decoder2, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i2);
                  if (values0[i2] == null) {
                    throw new bindings.MojoCodecError(
                      'Trying to decode null union for non-nullable ObjectUnion.');
                  }
              }
            }
          }
          result.mOu = new Map<int, ObjectUnion>.fromIterables(
              keys0, values0);
        }
        break;
      case UnionOfUnionsTag.mHu:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          decoder1.decodeDataHeaderForMap();
          List<int> keys0;
          List<HandleUnion> values0;
          {
            
            keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          }
          {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
            {
              var si2 = decoder2.decodeDataHeaderForUnionArray(keys0.length);
              values0 = new List<HandleUnion>(si2.numElements);
              for (int i2 = 0; i2 < si2.numElements; ++i2) {
                
                  values0[i2] = HandleUnion.decode(decoder2, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i2);
                  if (values0[i2] == null) {
                    throw new bindings.MojoCodecError(
                      'Trying to decode null union for non-nullable HandleUnion.');
                  }
              }
            }
          }
          result.mHu = new Map<int, HandleUnion>.fromIterables(
              keys0, values0);
        }
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tagToInt[_tag], offset + 4);
    switch (_tag) {
      case UnionOfUnionsTag.u:
        encoder0.encodeNestedUnion(u, offset + 8, false);
        break;
      case UnionOfUnionsTag.aOu:
        if (aOu == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encodeUnionArray(aOu.length, offset + 8, bindings.kUnspecifiedArrayLength);
          for (int i0 = 0; i0 < aOu.length; ++i0) {
            encoder1.encodeUnion(aOu[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i0, false);
          }
        }
        break;
      case UnionOfUnionsTag.aHu:
        if (aHu == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encodeUnionArray(aHu.length, offset + 8, bindings.kUnspecifiedArrayLength);
          for (int i0 = 0; i0 < aHu.length; ++i0) {
            encoder1.encodeUnion(aHu[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i0, false);
          }
        }
        break;
      case UnionOfUnionsTag.mOu:
        if (mOu == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encoderForMap(offset + 8);
          var keys0 = mOu.keys.toList();
          var values0 = mOu.values.toList();
          encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          
          {
            var encoder2 = encoder1.encodeUnionArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
            for (int i1 = 0; i1 < values0.length; ++i1) {
              encoder2.encodeUnion(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1, false);
            }
          }
        }
        break;
      case UnionOfUnionsTag.mHu:
        if (mHu == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encoderForMap(offset + 8);
          var keys0 = mHu.keys.toList();
          var values0 = mHu.values.toList();
          encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          
          {
            var encoder2 = encoder1.encodeUnionArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
            for (int i1 = 0; i1 < values0.length; ++i1) {
              encoder2.encodeUnion(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1, false);
            }
          }
        }
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "UnionOfUnions(";
    switch (_tag) {
      case UnionOfUnionsTag.u:
        result += "u";
        break;
      case UnionOfUnionsTag.aOu:
        result += "aOu";
        break;
      case UnionOfUnionsTag.aHu:
        result += "aHu";
        break;
      case UnionOfUnionsTag.mOu:
        result += "mOu";
        break;
      case UnionOfUnionsTag.mHu:
        result += "mHu";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}


enum ObjectUnionTag {
  fInt8,
  fString,
  fDummy,
  fNullable,
  fArrayInt8,
  fMapInt8,
  fPodUnion,
  unknown
}

class ObjectUnion extends bindings.Union {
  static final _tagToInt = const {
    ObjectUnionTag.fInt8: 0,
    ObjectUnionTag.fString: 1,
    ObjectUnionTag.fDummy: 2,
    ObjectUnionTag.fNullable: 3,
    ObjectUnionTag.fArrayInt8: 4,
    ObjectUnionTag.fMapInt8: 5,
    ObjectUnionTag.fPodUnion: 6,
  };

  static final _intToTag = const {
    0: ObjectUnionTag.fInt8,
    1: ObjectUnionTag.fString,
    2: ObjectUnionTag.fDummy,
    3: ObjectUnionTag.fNullable,
    4: ObjectUnionTag.fArrayInt8,
    5: ObjectUnionTag.fMapInt8,
    6: ObjectUnionTag.fPodUnion,
  };

  var _data;
  ObjectUnionTag _tag = ObjectUnionTag.unknown;

  ObjectUnionTag get tag => _tag;
  int get fInt8 {
    if (_tag != ObjectUnionTag.fInt8) {
      throw new bindings.UnsetUnionTagError(_tag, ObjectUnionTag.fInt8);
    }
    return _data;
  }

  set fInt8(int value) {
    _tag = ObjectUnionTag.fInt8;
    _data = value;
  }
  String get fString {
    if (_tag != ObjectUnionTag.fString) {
      throw new bindings.UnsetUnionTagError(_tag, ObjectUnionTag.fString);
    }
    return _data;
  }

  set fString(String value) {
    _tag = ObjectUnionTag.fString;
    _data = value;
  }
  DummyStruct get fDummy {
    if (_tag != ObjectUnionTag.fDummy) {
      throw new bindings.UnsetUnionTagError(_tag, ObjectUnionTag.fDummy);
    }
    return _data;
  }

  set fDummy(DummyStruct value) {
    _tag = ObjectUnionTag.fDummy;
    _data = value;
  }
  DummyStruct get fNullable {
    if (_tag != ObjectUnionTag.fNullable) {
      throw new bindings.UnsetUnionTagError(_tag, ObjectUnionTag.fNullable);
    }
    return _data;
  }

  set fNullable(DummyStruct value) {
    _tag = ObjectUnionTag.fNullable;
    _data = value;
  }
  List<int> get fArrayInt8 {
    if (_tag != ObjectUnionTag.fArrayInt8) {
      throw new bindings.UnsetUnionTagError(_tag, ObjectUnionTag.fArrayInt8);
    }
    return _data;
  }

  set fArrayInt8(List<int> value) {
    _tag = ObjectUnionTag.fArrayInt8;
    _data = value;
  }
  Map<String, int> get fMapInt8 {
    if (_tag != ObjectUnionTag.fMapInt8) {
      throw new bindings.UnsetUnionTagError(_tag, ObjectUnionTag.fMapInt8);
    }
    return _data;
  }

  set fMapInt8(Map<String, int> value) {
    _tag = ObjectUnionTag.fMapInt8;
    _data = value;
  }
  PodUnion get fPodUnion {
    if (_tag != ObjectUnionTag.fPodUnion) {
      throw new bindings.UnsetUnionTagError(_tag, ObjectUnionTag.fPodUnion);
    }
    return _data;
  }

  set fPodUnion(PodUnion value) {
    _tag = ObjectUnionTag.fPodUnion;
    _data = value;
  }

  static ObjectUnion decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    ObjectUnion result = new ObjectUnion();

    
    ObjectUnionTag tag = _intToTag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case ObjectUnionTag.fInt8:
        
        result.fInt8 = decoder0.decodeInt8(offset + 8);
        break;
      case ObjectUnionTag.fString:
        
        result.fString = decoder0.decodeString(offset + 8, false);
        break;
      case ObjectUnionTag.fDummy:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.fDummy = DummyStruct.decode(decoder1);
        break;
      case ObjectUnionTag.fNullable:
        
        var decoder1 = decoder0.decodePointer(offset + 8, true);
        result.fNullable = DummyStruct.decode(decoder1);
        break;
      case ObjectUnionTag.fArrayInt8:
        
        result.fArrayInt8 = decoder0.decodeInt8Array(offset + 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        break;
      case ObjectUnionTag.fMapInt8:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          decoder1.decodeDataHeaderForMap();
          List<String> keys0;
          List<int> values0;
          {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
            {
              var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
              keys0 = new List<String>(si2.numElements);
              for (int i2 = 0; i2 < si2.numElements; ++i2) {
                
                keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              }
            }
          }
          {
            
            values0 = decoder1.decodeInt8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
          }
          result.fMapInt8 = new Map<String, int>.fromIterables(
              keys0, values0);
        }
        break;
      case ObjectUnionTag.fPodUnion:
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.fPodUnion = PodUnion.decode(decoder1, 0);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tagToInt[_tag], offset + 4);
    switch (_tag) {
      case ObjectUnionTag.fInt8:
        encoder0.encodeInt8(fInt8, offset + 8);
        break;
      case ObjectUnionTag.fString:
        encoder0.encodeString(fString, offset + 8, false);
        break;
      case ObjectUnionTag.fDummy:
        encoder0.encodeStruct(fDummy, offset + 8, false);
        break;
      case ObjectUnionTag.fNullable:
        encoder0.encodeStruct(fNullable, offset + 8, true);
        break;
      case ObjectUnionTag.fArrayInt8:
        encoder0.encodeInt8Array(fArrayInt8, offset + 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        break;
      case ObjectUnionTag.fMapInt8:
        if (fMapInt8 == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encoderForMap(offset + 8);
          var keys0 = fMapInt8.keys.toList();
          var values0 = fMapInt8.values.toList();
          
          {
            var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
            for (int i1 = 0; i1 < keys0.length; ++i1) {
              encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            }
          }
          encoder1.encodeInt8Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        break;
      case ObjectUnionTag.fPodUnion:
        encoder0.encodeNestedUnion(fPodUnion, offset + 8, false);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "ObjectUnion(";
    switch (_tag) {
      case ObjectUnionTag.fInt8:
        result += "fInt8";
        break;
      case ObjectUnionTag.fString:
        result += "fString";
        break;
      case ObjectUnionTag.fDummy:
        result += "fDummy";
        break;
      case ObjectUnionTag.fNullable:
        result += "fNullable";
        break;
      case ObjectUnionTag.fArrayInt8:
        result += "fArrayInt8";
        break;
      case ObjectUnionTag.fMapInt8:
        result += "fMapInt8";
        break;
      case ObjectUnionTag.fPodUnion:
        result += "fPodUnion";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}


enum HandleUnionTag {
  fHandle,
  fMessagePipe,
  fDataPipeConsumer,
  fDataPipeProducer,
  fSharedBuffer,
  fSmallCache,
  unknown
}

class HandleUnion extends bindings.Union {
  static final _tagToInt = const {
    HandleUnionTag.fHandle: 0,
    HandleUnionTag.fMessagePipe: 1,
    HandleUnionTag.fDataPipeConsumer: 2,
    HandleUnionTag.fDataPipeProducer: 3,
    HandleUnionTag.fSharedBuffer: 4,
    HandleUnionTag.fSmallCache: 5,
  };

  static final _intToTag = const {
    0: HandleUnionTag.fHandle,
    1: HandleUnionTag.fMessagePipe,
    2: HandleUnionTag.fDataPipeConsumer,
    3: HandleUnionTag.fDataPipeProducer,
    4: HandleUnionTag.fSharedBuffer,
    5: HandleUnionTag.fSmallCache,
  };

  var _data;
  HandleUnionTag _tag = HandleUnionTag.unknown;

  HandleUnionTag get tag => _tag;
  core.MojoHandle get fHandle {
    if (_tag != HandleUnionTag.fHandle) {
      throw new bindings.UnsetUnionTagError(_tag, HandleUnionTag.fHandle);
    }
    return _data;
  }

  set fHandle(core.MojoHandle value) {
    _tag = HandleUnionTag.fHandle;
    _data = value;
  }
  core.MojoMessagePipeEndpoint get fMessagePipe {
    if (_tag != HandleUnionTag.fMessagePipe) {
      throw new bindings.UnsetUnionTagError(_tag, HandleUnionTag.fMessagePipe);
    }
    return _data;
  }

  set fMessagePipe(core.MojoMessagePipeEndpoint value) {
    _tag = HandleUnionTag.fMessagePipe;
    _data = value;
  }
  core.MojoDataPipeConsumer get fDataPipeConsumer {
    if (_tag != HandleUnionTag.fDataPipeConsumer) {
      throw new bindings.UnsetUnionTagError(_tag, HandleUnionTag.fDataPipeConsumer);
    }
    return _data;
  }

  set fDataPipeConsumer(core.MojoDataPipeConsumer value) {
    _tag = HandleUnionTag.fDataPipeConsumer;
    _data = value;
  }
  core.MojoDataPipeProducer get fDataPipeProducer {
    if (_tag != HandleUnionTag.fDataPipeProducer) {
      throw new bindings.UnsetUnionTagError(_tag, HandleUnionTag.fDataPipeProducer);
    }
    return _data;
  }

  set fDataPipeProducer(core.MojoDataPipeProducer value) {
    _tag = HandleUnionTag.fDataPipeProducer;
    _data = value;
  }
  core.MojoSharedBuffer get fSharedBuffer {
    if (_tag != HandleUnionTag.fSharedBuffer) {
      throw new bindings.UnsetUnionTagError(_tag, HandleUnionTag.fSharedBuffer);
    }
    return _data;
  }

  set fSharedBuffer(core.MojoSharedBuffer value) {
    _tag = HandleUnionTag.fSharedBuffer;
    _data = value;
  }
  Object get fSmallCache {
    if (_tag != HandleUnionTag.fSmallCache) {
      throw new bindings.UnsetUnionTagError(_tag, HandleUnionTag.fSmallCache);
    }
    return _data;
  }

  set fSmallCache(Object value) {
    _tag = HandleUnionTag.fSmallCache;
    _data = value;
  }

  static HandleUnion decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    HandleUnion result = new HandleUnion();

    
    HandleUnionTag tag = _intToTag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case HandleUnionTag.fHandle:
        
        result.fHandle = decoder0.decodeHandle(offset + 8, false);
        break;
      case HandleUnionTag.fMessagePipe:
        
        result.fMessagePipe = decoder0.decodeMessagePipeHandle(offset + 8, false);
        break;
      case HandleUnionTag.fDataPipeConsumer:
        
        result.fDataPipeConsumer = decoder0.decodeConsumerHandle(offset + 8, false);
        break;
      case HandleUnionTag.fDataPipeProducer:
        
        result.fDataPipeProducer = decoder0.decodeProducerHandle(offset + 8, false);
        break;
      case HandleUnionTag.fSharedBuffer:
        
        result.fSharedBuffer = decoder0.decodeSharedBufferHandle(offset + 8, false);
        break;
      case HandleUnionTag.fSmallCache:
        
        result.fSmallCache = decoder0.decodeServiceInterface(offset + 8, false, SmallCacheProxy.newFromEndpoint);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tagToInt[_tag], offset + 4);
    switch (_tag) {
      case HandleUnionTag.fHandle:
        encoder0.encodeHandle(fHandle, offset + 8, false);
        break;
      case HandleUnionTag.fMessagePipe:
        encoder0.encodeMessagePipeHandle(fMessagePipe, offset + 8, false);
        break;
      case HandleUnionTag.fDataPipeConsumer:
        encoder0.encodeConsumerHandle(fDataPipeConsumer, offset + 8, false);
        break;
      case HandleUnionTag.fDataPipeProducer:
        encoder0.encodeProducerHandle(fDataPipeProducer, offset + 8, false);
        break;
      case HandleUnionTag.fSharedBuffer:
        encoder0.encodeSharedBufferHandle(fSharedBuffer, offset + 8, false);
        break;
      case HandleUnionTag.fSmallCache:
        encoder0.encodeInterface(fSmallCache, offset + 8, false);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "HandleUnion(";
    switch (_tag) {
      case HandleUnionTag.fHandle:
        result += "fHandle";
        break;
      case HandleUnionTag.fMessagePipe:
        result += "fMessagePipe";
        break;
      case HandleUnionTag.fDataPipeConsumer:
        result += "fDataPipeConsumer";
        break;
      case HandleUnionTag.fDataPipeProducer:
        result += "fDataPipeProducer";
        break;
      case HandleUnionTag.fSharedBuffer:
        result += "fSharedBuffer";
        break;
      case HandleUnionTag.fSmallCache:
        result += "fSmallCache";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}


enum ObjectOnlyUnionTag {
  dummy1,
  unknown
}

class ObjectOnlyUnion extends bindings.Union {
  static final _tagToInt = const {
    ObjectOnlyUnionTag.dummy1: 0,
  };

  static final _intToTag = const {
    0: ObjectOnlyUnionTag.dummy1,
  };

  var _data;
  ObjectOnlyUnionTag _tag = ObjectOnlyUnionTag.unknown;

  ObjectOnlyUnionTag get tag => _tag;
  DummyStruct get dummy1 {
    if (_tag != ObjectOnlyUnionTag.dummy1) {
      throw new bindings.UnsetUnionTagError(_tag, ObjectOnlyUnionTag.dummy1);
    }
    return _data;
  }

  set dummy1(DummyStruct value) {
    _tag = ObjectOnlyUnionTag.dummy1;
    _data = value;
  }

  static ObjectOnlyUnion decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    ObjectOnlyUnion result = new ObjectOnlyUnion();

    
    ObjectOnlyUnionTag tag = _intToTag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case ObjectOnlyUnionTag.dummy1:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.dummy1 = DummyStruct.decode(decoder1);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tagToInt[_tag], offset + 4);
    switch (_tag) {
      case ObjectOnlyUnionTag.dummy1:
        encoder0.encodeStruct(dummy1, offset + 8, false);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "ObjectOnlyUnion(";
    switch (_tag) {
      case ObjectOnlyUnionTag.dummy1:
        result += "dummy1";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}


enum OldUnionTag {
  fInt8,
  unknown
}

class OldUnion extends bindings.Union {
  static final _tagToInt = const {
    OldUnionTag.fInt8: 0,
  };

  static final _intToTag = const {
    0: OldUnionTag.fInt8,
  };

  var _data;
  OldUnionTag _tag = OldUnionTag.unknown;

  OldUnionTag get tag => _tag;
  int get fInt8 {
    if (_tag != OldUnionTag.fInt8) {
      throw new bindings.UnsetUnionTagError(_tag, OldUnionTag.fInt8);
    }
    return _data;
  }

  set fInt8(int value) {
    _tag = OldUnionTag.fInt8;
    _data = value;
  }

  static OldUnion decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    OldUnion result = new OldUnion();

    
    OldUnionTag tag = _intToTag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case OldUnionTag.fInt8:
        
        result.fInt8 = decoder0.decodeInt8(offset + 8);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tagToInt[_tag], offset + 4);
    switch (_tag) {
      case OldUnionTag.fInt8:
        encoder0.encodeInt8(fInt8, offset + 8);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "OldUnion(";
    switch (_tag) {
      case OldUnionTag.fInt8:
        result += "fInt8";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}


enum NewUnionTag {
  fInt8,
  fInt16,
  unknown
}

class NewUnion extends bindings.Union {
  static final _tagToInt = const {
    NewUnionTag.fInt8: 0,
    NewUnionTag.fInt16: 1,
  };

  static final _intToTag = const {
    0: NewUnionTag.fInt8,
    1: NewUnionTag.fInt16,
  };

  var _data;
  NewUnionTag _tag = NewUnionTag.unknown;

  NewUnionTag get tag => _tag;
  int get fInt8 {
    if (_tag != NewUnionTag.fInt8) {
      throw new bindings.UnsetUnionTagError(_tag, NewUnionTag.fInt8);
    }
    return _data;
  }

  set fInt8(int value) {
    _tag = NewUnionTag.fInt8;
    _data = value;
  }
  int get fInt16 {
    if (_tag != NewUnionTag.fInt16) {
      throw new bindings.UnsetUnionTagError(_tag, NewUnionTag.fInt16);
    }
    return _data;
  }

  set fInt16(int value) {
    _tag = NewUnionTag.fInt16;
    _data = value;
  }

  static NewUnion decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    NewUnion result = new NewUnion();

    
    NewUnionTag tag = _intToTag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case NewUnionTag.fInt8:
        
        result.fInt8 = decoder0.decodeInt8(offset + 8);
        break;
      case NewUnionTag.fInt16:
        
        result.fInt16 = decoder0.decodeInt16(offset + 8);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tagToInt[_tag], offset + 4);
    switch (_tag) {
      case NewUnionTag.fInt8:
        encoder0.encodeInt8(fInt8, offset + 8);
        break;
      case NewUnionTag.fInt16:
        encoder0.encodeInt16(fInt16, offset + 8);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "NewUnion(";
    switch (_tag) {
      case NewUnionTag.fInt8:
        result += "fInt8";
        break;
      case NewUnionTag.fInt16:
        result += "fInt16";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}
const int _smallCacheMethodSetIntValueName = 0;
const int _smallCacheMethodGetIntValueName = 1;

class _SmallCacheServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class SmallCache {
  static const String serviceName = null;
  void setIntValue(int intValue);
  dynamic getIntValue([Function responseFactory = null]);
}


class _SmallCacheProxyImpl extends bindings.Proxy {
  _SmallCacheProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SmallCacheProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _SmallCacheProxyImpl.unbound() : super.unbound();

  static _SmallCacheProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _SmallCacheProxyImpl"));
    return new _SmallCacheProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _SmallCacheServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _smallCacheMethodGetIntValueName:
        var r = SmallCacheGetIntValueResponseParams.deserialize(
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
    return "_SmallCacheProxyImpl($superString)";
  }
}


class _SmallCacheProxyCalls implements SmallCache {
  _SmallCacheProxyImpl _proxyImpl;

  _SmallCacheProxyCalls(this._proxyImpl);
    void setIntValue(int intValue) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SmallCacheSetIntValueParams();
      params.intValue = intValue;
      _proxyImpl.sendMessage(params, _smallCacheMethodSetIntValueName);
    }
    dynamic getIntValue([Function responseFactory = null]) {
      var params = new _SmallCacheGetIntValueParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _smallCacheMethodGetIntValueName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class SmallCacheProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SmallCache ptr;

  SmallCacheProxy(_SmallCacheProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SmallCacheProxyCalls(proxyImpl);

  SmallCacheProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _SmallCacheProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SmallCacheProxyCalls(impl);
  }

  SmallCacheProxy.fromHandle(core.MojoHandle handle) :
      impl = new _SmallCacheProxyImpl.fromHandle(handle) {
    ptr = new _SmallCacheProxyCalls(impl);
  }

  SmallCacheProxy.unbound() :
      impl = new _SmallCacheProxyImpl.unbound() {
    ptr = new _SmallCacheProxyCalls(impl);
  }

  factory SmallCacheProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SmallCacheProxy p = new SmallCacheProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static SmallCacheProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SmallCacheProxy"));
    return new SmallCacheProxy.fromEndpoint(endpoint);
  }

  String get serviceName => SmallCache.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "SmallCacheProxy($impl)";
  }
}


class SmallCacheStub extends bindings.Stub {
  SmallCache _impl = null;

  SmallCacheStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SmallCacheStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SmallCacheStub.unbound() : super.unbound();

  static SmallCacheStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SmallCacheStub"));
    return new SmallCacheStub.fromEndpoint(endpoint);
  }


  SmallCacheGetIntValueResponseParams _smallCacheGetIntValueResponseParamsFactory(int intValue) {
    var result = new SmallCacheGetIntValueResponseParams();
    result.intValue = intValue;
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
      case _smallCacheMethodSetIntValueName:
        var params = _SmallCacheSetIntValueParams.deserialize(
            message.payload);
        _impl.setIntValue(params.intValue);
        break;
      case _smallCacheMethodGetIntValueName:
        var response = _impl.getIntValue(_smallCacheGetIntValueResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _smallCacheMethodGetIntValueName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _smallCacheMethodGetIntValueName,
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

  SmallCache get impl => _impl;
  set impl(SmallCache d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SmallCacheStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SmallCacheServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _unionInterfaceMethodEchoName = 0;

class _UnionInterfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class UnionInterface {
  static const String serviceName = null;
  dynamic echo(PodUnion inVal,[Function responseFactory = null]);
}


class _UnionInterfaceProxyImpl extends bindings.Proxy {
  _UnionInterfaceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _UnionInterfaceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _UnionInterfaceProxyImpl.unbound() : super.unbound();

  static _UnionInterfaceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _UnionInterfaceProxyImpl"));
    return new _UnionInterfaceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _UnionInterfaceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _unionInterfaceMethodEchoName:
        var r = UnionInterfaceEchoResponseParams.deserialize(
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
    return "_UnionInterfaceProxyImpl($superString)";
  }
}


class _UnionInterfaceProxyCalls implements UnionInterface {
  _UnionInterfaceProxyImpl _proxyImpl;

  _UnionInterfaceProxyCalls(this._proxyImpl);
    dynamic echo(PodUnion inVal,[Function responseFactory = null]) {
      var params = new _UnionInterfaceEchoParams();
      params.inVal = inVal;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _unionInterfaceMethodEchoName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class UnionInterfaceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  UnionInterface ptr;

  UnionInterfaceProxy(_UnionInterfaceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _UnionInterfaceProxyCalls(proxyImpl);

  UnionInterfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _UnionInterfaceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _UnionInterfaceProxyCalls(impl);
  }

  UnionInterfaceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _UnionInterfaceProxyImpl.fromHandle(handle) {
    ptr = new _UnionInterfaceProxyCalls(impl);
  }

  UnionInterfaceProxy.unbound() :
      impl = new _UnionInterfaceProxyImpl.unbound() {
    ptr = new _UnionInterfaceProxyCalls(impl);
  }

  factory UnionInterfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    UnionInterfaceProxy p = new UnionInterfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static UnionInterfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UnionInterfaceProxy"));
    return new UnionInterfaceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => UnionInterface.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "UnionInterfaceProxy($impl)";
  }
}


class UnionInterfaceStub extends bindings.Stub {
  UnionInterface _impl = null;

  UnionInterfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  UnionInterfaceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  UnionInterfaceStub.unbound() : super.unbound();

  static UnionInterfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UnionInterfaceStub"));
    return new UnionInterfaceStub.fromEndpoint(endpoint);
  }


  UnionInterfaceEchoResponseParams _unionInterfaceEchoResponseParamsFactory(PodUnion outVal) {
    var result = new UnionInterfaceEchoResponseParams();
    result.outVal = outVal;
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
      case _unionInterfaceMethodEchoName:
        var params = _UnionInterfaceEchoParams.deserialize(
            message.payload);
        var response = _impl.echo(params.inVal,_unionInterfaceEchoResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _unionInterfaceMethodEchoName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _unionInterfaceMethodEchoName,
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

  UnionInterface get impl => _impl;
  set impl(UnionInterface d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "UnionInterfaceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _UnionInterfaceServiceDescription();
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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+xdTXDbxhVekKJMKW7MxD9h4rahnaZVklqSf6po3D91bDlSfyQ1Uhtn2hkKIsGQGhJgSCKp287URx9z9DHHHHPsMUcffdTRRx115K0FwLci9mEXWNJYgJKCGXgN6ZHY970fvPf2LVQkg6MA4yKM+Od0zKMR0x1mB+PXznnROZ/Cz/8L4wGMfRhL2mBcgbEO4xMYv4HxGYyHMBYyMF8Yd2F8AuO3MB7ASGBeJRivOeebzrnz6dZq+Q+rn95tWfvWfM/o9uZ/Z66adgs+9lPn/DGf7r7daj3a7nXsSi+Ubk03q03jL2bDMgl536G5zqdbNytNu9owP6Pf6R7vOOdVPv2G8SV8KQn93s29faPS2zSbj4bkYfMd0ANtyP03m9XhF4bQbVk+uned80d8uu2W3mze0yt1w/n9eyAjEZ0zST9MYfx49JR4yaGZj6TbsMwNu9nU947l5trFnOBzg4/Y3qQocmHz9+g3ax5dF+b/AWDIod/pPIL5+DgO+X7ve9fNntGp6RUDvt+deymEnk4nhO6Tjt5uG53BJJa1gX1Tu5/Thn7A/e9XU8Nr1wS/m2Z/v/Iq+/uDAnv9zUX2un+ZvZ57m73OXxteuyb+ZJ6939yH7PWzu+z1dw/Y6/Y6e136I3t9tMPer/8QzWeXpV+s8/3lCxhXCHtQP7wM4//gwHT0cOF0IabOqwj3wG4N33/GOXPO6U5/yzkX6lbLWOjYVavVMI3Ogvv5hW6nMvhP295rNioLDapc3YW9hum6rO6Ce4/Bv2Xb06R59xPe/TK++1E/v+jTS+/QSOghi8+a4PM/AD4frH+8vQO+4goHn3kgwDjNAh+qcJJ9HsnipsWEG9Wr7dV7mxv3CXHN7g0ebkCAcXtlQnAroXiFxh8kE47TCsJpS4DTReCVCQrgWXeZwYulwHi5buecQryoP8oj/pbRPLJE7hDhRny4Mfoq0K9a2WFiOYjH7xPGo4hsqCCIc49IvHrDBIlcvWEp8HzuAo6qcFqG719EcXsR7KcIClOkz/0c66dKvvm6JM9j1qMCyLBWrns4YXx+Cc86lXrkP0R8H0j6Zz/fGufn9LgCNlQrt4xuV//MKLcbbSOoH78Cv50E/1oI/y9YtyvFf8bnn/DxQ+e85PFf1Xu6x3y54szKbhkdnt3+GmwrCRwyEjhkR8AhOyIO7Y5VtSt8HH6TIA5ZCXuYGgGHqRB7cHX8godDt653jGp5z67VHAgw/78FTJLgf0rAf87Hf24E/nMh/F+GWNfh301nyxXIpzH/K0Cniv8Sxz/7+X8dYmom6R+hPoDjOepQ6yPGcw8j9AgXZWi8GVG2CeD9nwmI61y9OUworpuB+egCPB7D/9PSP2onA+kZxxWqkPoHQxoVNxZF9dGY8jIa79Ai4FtgU4LyYGAe/1QcL+K8/ygkLuLlG6rzin8ptkcRn1Njxn8iPi8AHx6fN5cCfP4b9ESlnP3365N4/S8uXgf9L7e8HcDhb4r1HfsD0fP+uSI9r7pVhZtBvv8ONGn5WVFdRHZdRXXezSx2cPNuloK3XqZSr1bAvulzoQiOIw9xzho4TlpvfwqBJK23T4q/vZmCv9V89haXvx3WGbq9jjMhzOetCagz+P3MqHl29HPG8zQB+d4+4X4mKj8bNU8X5Wc076mVTVhg5D+v7gDmqvHUEsQzoyDfd2se5z089U5HfwTeJ4jnLxLUT3fO2M/y8MgqyP+H+tXS28doBPFYAuxU4bHIsVeNM48suo7yaxSv6RHwmg7Bi+p5rdy2qgMOuHh9CHRJ+7cieu7QZgrZfgvV+SdtAgnmn0x7SGAeX0xAPJ5GHPSl4jhItbypcgXlzahdgO9XFcu7DfUcaLMgaxrbH1YAQR/B+BweQN+C4/0KHEr73GDcAsVZnIHPz8LnZydLny6kVMfIxryONXyOu3yWrV6dv25RSInfc8riadsTLObzNcV1m6j61Kjx7rj1qddT4jM/ZhwanRfaHqOYz4uK80IRn7kx40sped6+FZDnpZTkOTNmXCgnz9u3MJ+XU5LnNPJHMnyek5Xn0p2APK+kJM9ZZKcyfOal5bl0B/P5RkryzCD9leFzRkqetaal9wLyLKYkTw3JVYbPWSl5Vi1nkoF+nzdTkifx9T3K8vmKVPy3Z1nNYDz0VgrxkL++eH4EPs9L8Wkc9y/7+byqWJ5R+Tfur5btO8X4EbRORmJazxD1U9C+IEEbRQDnOnxPUvlpEdUH/evn/vXjuSwfzxcv2b8QVRfaNnrrZu+vetM2uHltg6jtb8Z9LpTfI02eT/cQ9Y1dBV59fN7oGJ/bzjy4/NIj7f7k6Zj7WER68Br4HYeF8hfHWsDXg0sk/T5lkX30tXjzdWofH0XYx35K9vGCxGsfH02IfeRRPZ2nD/64WbX/oM8XFp9u25mw8b3/kPcf+xDLpe0/sL7QOKWdjSdOof3qeBNnCe4p2uaJ8aokUEf3xx9tTaxPOV9fSlL6ZO3t+1argvpUnZD1eNxfI7vvWGS32ZB8cFSctZeouxskvX1JGR/OInt99kq8fVLMJmpunxRLgfH6k2K8cJ/UU7DXI0gq6lDoPYRC6C4U0Pr5ybBruv7hdde4vUUANMZx44T3hYyKc35Mu47yn+xqfxDnTZBH0ji/7Ho/D99MCL7FMfDNkOj9N8f4DvpyAvhugS4lgS/tx8lx4mKSEP59AV6lMfAP2wdG4yjaXVZGgsBy+LPivFVWDknZgWj/y9wYcpiSqMN3Bfr/McTCk6b/Kv18NsQPLY6Bv8w+uKH6t/Q2x89vQx1XdR+cFtIHlwvJk5P0U9kQP7U8hnymQ/wUff8Gx095gsJ47CjOj+OSU9x+LCwPcP3LmiAPoPsEHkfsh9xCeUBbIC8639CXJDnHDTLYwyn5WqUAnp+QydgnmXQ+HxWPPiQns/9Udp8k1t+8pP6uIf3dFeBM81Xuy7qcn/+MDN5tE/Far4BcymdUX6PqT7sJxve8+EW0f3DU9+SNq7/0Ofp1Pua6KXp5HKduylBgucwp1tdF0EcaFz8GAfXBjttQh+nnwvU56X3qtkCP3zuFddSwPCjuOqpbQ3FFrpctm4fv++CXk9yXM04elBT+49ZjovGvc/H/4ITgj9+PJfu+VVGecxhzPSYK/5ZA/3+eUF5DBOufk2AP2QTrMkN58O3hxgmVx7j2ERbf5HxywvENDbwORlwXfhji99y54JfdXgd5RLwONyDHzxNeH65rkxHP0DyN1lUwLp3v149eav2IrtOZlsns4MY4d8nJ3g8ftf5cFPSbEZT/ROE+av6DX24dzH9YCiwXty83jf7W84R9VW/U/lS6z3ktG69/oM+/1Urd4umtSZLt16N8LmdG60eLsk+XP3+j3iT2oSX5XKD9LA3TbUPjy71whuqLcesdXW8CvTtugDzrekfXQS3b63/k6t27p1jvVL2/iuob88cbCO/97CwFns/bRO2+fFwPpHHyM7C7OfTeqqTemxZV9yud8Lqf6P07cb8PK6q+d+2U1/eicM4kVMe7fsrreKL3J1GcswnV6945Y/W6KNynEqrL/eSM1eVE64kruXjjB+aPOnHjB5YCy+We4jpbCfSN3vcf8OB6npmM9XCab1qe0QyXxDFO9yek7hZn3T4M50LMdTfZPplVcnr6tsPwLY25Thilx4O/niLW4wcToscq1jv8fdX/DwAA//92NbWxGHMAAA==";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  test_included_unions_mojom.getAllMojomTypeDefinitions()
      .forEach((String s, mojom_types.UserDefinedType udt) {
          _runtimeTypeInfo.typeMap[s] = udt;
      });

  return _runtimeTypeInfo;
}
