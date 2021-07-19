import 'dart:async';
import 'dart:convert';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/services.dart';
import 'package:texture_image/src/proto/pb_header.dart';

class TextureImagePlugin {
  static const MethodChannel _channel = const MethodChannel('texture_image');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<int> createImageTexture(
    String url, {
    required double width,
    required double height,
  }) async {
    final geometry = Geometry()
      ..width = width.toInt()
      ..height = height.toInt()
      ..fit = BoxFit.contain
      ..borderRadius = BorderRadius(
        topLeft: 10,
        topRight: 10,
        bottomLeft: 10,
        bottomRight: 10,
      );

    final imageInfo = ImageFetchInfo()
      ..url = url
      ..geometry = geometry;

    final base64Data = await _channel.invokeMethod(
      'createImageTexture',
      imageInfo.writeToBuffer(),
    );

    final result = ImageFetchResultInfo.fromBuffer(base64Data);
    return result.textureId.toInt();
  }

  static Future<void> destroyImageTexture(int? textureId, String url) {
    final cancelInfo = ImageFetchCancelInfo()
      ..textureId = Int64(textureId ?? -1)
      ..url = url;

    return _channel.invokeMethod(
      'destroyImageTexture',
      cancelInfo.writeToBuffer(),
    );
  }
}
