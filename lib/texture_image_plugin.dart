import 'dart:async';

import 'package:flutter/services.dart';

class TextureImagePlugin {
  static const MethodChannel _channel = const MethodChannel('texture_image');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<int> createImageTexture(
    String url, {
    double? width,
    double? height,
  }) async {
    final params = <String, dynamic>{'url': url};
    if (width != null) {
      params['width'] = width;
    }

    if (height != null) {
      params['height'] = height;
    }

    final result = await _channel.invokeMethod('createImageTexture', params);
    return int.parse(result);
  }

  static Future<void> destroyImageTexture(int textureId) {
    return _channel.invokeMethod('destroyImageTexture', textureId);
  }
}
