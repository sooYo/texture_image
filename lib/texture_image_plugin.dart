import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/services.dart';
import 'package:texture_image/src/constants/methods.dart';
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
    String? placeholderPath,
    String? errorPlaceholderPath,
    BoxFit fit = BoxFit.contain,
  }) async {
    final geometry = Geometry()
      ..width = width.toInt()
      ..height = height.toInt()
      ..fit = fit
      ..borderRadius = BorderRadius();

    final imageInfo = ImageFetchInfo()
      ..url = url
      ..geometry = geometry;

    if (placeholderPath?.isNotEmpty ?? false) {
      imageInfo.placeholder = placeholderPath!;
    }

    if (errorPlaceholderPath?.isNotEmpty ?? false) {
      imageInfo.errorPlaceholder = errorPlaceholderPath!;
    }

    final base64Data = await _channel.invokeMethod(
      Methods.createImageTexture,
      imageInfo.writeToBuffer(),
    );

    final result = ImageFetchResultInfo.fromBuffer(base64Data);
    return result.textureId.toInt();
  }

  static Future<void> destroyImageTexture(int? textureId, String url) {
    final cancelInfo = ImageDisposeInfo()
      ..textureId = Int64(textureId ?? -1)
      ..url = url;

    return _channel.invokeMethod(
      Methods.destroyImageTexture,
      cancelInfo.writeToBuffer(),
    );
  }
}
