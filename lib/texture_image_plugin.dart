import 'dart:async';

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

    final result = await _channel.invokeMethod(
      'createImageTexture',
      imageInfo.writeToBuffer(),
    );

    return result;
  }

  static Future<void> destroyImageTexture(int textureId) {
    return _channel.invokeMethod('destroyImageTexture', textureId);
  }
}
