// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library sample_import2_mojom;
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;

import 'package:_mojo_for_test_only/imported/sample_import.mojom.dart' as sample_import_mojom;

class Color extends bindings.MojoEnum {
  static const Color red = const Color._(0);
  static const Color black = const Color._(1);

  const Color._(int v) : super(v);

  static const Map<String, Color> valuesMap = const {
    "red": red,
    "black": black,
  };
  static const List<Color> values = const [
    red,
    black,
  ];

  static Color valueOf(String name) => valuesMap[name];

  factory Color(int v) {
    switch (v) {
      case 0:
        return Color.red;
      case 1:
        return Color.black;
      default:
        return null;
    }
  }

  static Color decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    Color result = new Color(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum Color.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case red:
        return 'Color.red';
      case black:
        return 'Color.black';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class Size extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int width = 0;
  int height = 0;

  Size() : super(kVersions.last.size);

  static Size deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Size decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Size result = new Size();

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
      
      result.width = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.height = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(width, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "width of struct Size: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(height, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "height of struct Size: $e";
      rethrow;
    }
  }

  String toString() {
    return "Size("
           "width: $width" ", "
           "height: $height" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["width"] = width;
    map["height"] = height;
    return map;
  }
}


class Thing extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  sample_import_mojom.Shape shape = new sample_import_mojom.Shape(1);
  Color color = new Color(1);
  sample_import_mojom.Point location = null;
  Size size = null;

  Thing() : super(kVersions.last.size);

  static Thing deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Thing decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Thing result = new Thing();

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
      
        result.shape = sample_import_mojom.Shape.decode(decoder0, 8);
        if (result.shape == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable sample_import_mojom.Shape.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.color = Color.decode(decoder0, 12);
        if (result.color == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Color.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.location = sample_import_mojom.Point.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.size = Size.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(shape, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "shape of struct Thing: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(color, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "color of struct Thing: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(location, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "location of struct Thing: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(size, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "size of struct Thing: $e";
      rethrow;
    }
  }

  String toString() {
    return "Thing("
           "shape: $shape" ", "
           "color: $color" ", "
           "location: $location" ", "
           "size: $size" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["shape"] = shape;
    map["color"] = color;
    map["location"] = location;
    map["size"] = size;
    return map;
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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/8yXzW7TQBCA101Cg4ASaKGl/IUDUrnEFaeIU0uIqNQKRSSXikOVOqZeFHsj2xUST8AjcOSxeIQe+wYwzs5Wzthru1FiutJo6uzvfDM7s91isjVQ76KmvytdJ5qO+4m6CVKJ9at1D1C/BNkEGRz3uieH3eN33J0IP7RHrY4YC5+9gL7Hqf19/sPOmj9wuHfG2ri/OtdO7JwGyK/K7PefW+n2XKDeY7NN2dNG/RcbHafaPZAaiLRO2rYGQsxO7K/mfQHpg5iOcG3TPx8Jl3u2b7rimzAD35J/TM5Px9wyuRfa/tehZQfmKfdGwCMwQzsIAzMYupOxfSJ3fduKJrlXdq/E9t0zZu1U/OoGy2xFOR1o5t9Bv33ufph+b4M8THBqqe4ErzW0Y9m88uK3KDdjQdxUnLw/2u8cgn4GspHkproT3O7fEG5Nklcu1Tkri7mHd0GqkY3TLMLYI2RH0kuCTxSDq//hHjaMWbvb5Fw1VqzpuLEYt3i86uLrOx+FTgqfdawJy+ZzXQ7VOTgYGRyi/BKVCsfmZ06Y5LBREgdVt2gdZiR+dPept7rYuiarbkpdww7KabOk+7SDMaA4XOB9+o355LKqv1+1eP5R/cZy71fgDCdp+Sf6flACryY5F42jhH/78sD6vC4H6OKVrh/ZeHta/zuD/U8fj7r4+xuQV/r1W3R8UX/uGsvJE8qfFr73qL1PSsoTOn9uad6lefW5qB/X8S1Hnh3sNchz/fpXI/P8R1t9Dv+tZPivgWuOhTUMufConds3zH89AYtn+k+OuC7XxhxcKxlc1fsrwPcX5fq0pLqQx5W+E/P+H82qx/H68y8AAP//Xq2n0nAPAAA=";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  sample_import_mojom.getAllMojomTypeDefinitions()
      .forEach((String s, mojom_types.UserDefinedType udt) {
          _runtimeTypeInfo.typeMap[s] = udt;
      });

  return _runtimeTypeInfo;
}
