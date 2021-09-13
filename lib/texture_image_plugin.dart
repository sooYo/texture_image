import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/services.dart';
import 'package:texture_image/src/constants/methods.dart';
import 'package:texture_image/src/proto/pb_header.dart';

import 'utils/double_extension.dart';

class TextureImagePlugin {
  static const MethodChannel _channel = const MethodChannel('texture_image');

  static Future<int> createImageTexture(String url, {
    required double width,
    required double height,
    String? placeholderPath,
    String? errorPlaceholderPath,
    BoxFit fit = BoxFit.contain,
    bool disableAlphaChannel = true,
  }) async {
    final geometry = Geometry()
      ..fit = fit
      ..width = width.evenSize
      ..height = height.evenSize
      ..supportAlpha = !disableAlphaChannel
      ..borderRadius = BorderRadius();

    final quality = Quality()
      ..autoDownscale = true
      ..minimumAutoDownscaleTriggerSize = 80
      ..quality = 100;

    final imageInfo = ImageFetchInfo()
      ..url = url
      ..quality = quality
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
      ..url = url
      ..canBeReused = true;

    return _channel.invokeMethod(
      Methods.disposeImageTexture,
      cancelInfo.writeToBuffer(),
    );
  }

  static Future<void> updateConfig() async {
    final config = ImageConfigInfo()
      ..placeholder = 'lib/assets/ic_placeholder.png'
      ..errorPlaceholder = 'lib/assets/ic_error.png'
      ..androidAvailableMemoryPercentage = 0.3
      ..useOpenGLRendering = true
      ..backgroundColor = '0xFF880000';

    return _channel.invokeMethod(
      Methods.textureImageConfig,
      config.writeToBuffer(),
    );
  }
}
