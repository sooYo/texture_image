import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/methods.dart';
import 'param_transform/param_transformer.dart';
import 'proto/pb_header.dart' as $pb;
import 'utils/double_extension.dart';

class TextureImagePlugin {
  static const _channel = const MethodChannel('texture_image');
  static final _transforms = <ParamTransformerImpl>[];
  static final _defConfig = $pb.ImageConfigInfo()
    ..useOpenGLRendering = false
    ..reduceQualityInLowMemory = true
    ..backgroundColor = '0xFF000000'
    ..androidAvailableMemoryPercentage = 0.1
    ..placeholder = 'lib/assets/ic_placeholder.png'
    ..errorPlaceholder = 'lib/assets/ic_error.png';

  // region Param Transforms
  static void addParameterTransformers(
    List<ParamTransformerImpl> transformers,
  ) {
    _transforms.clear();
    _transforms.addAll(transformers);

    // Preset transformers
    _transforms.add(QiniuParamTransformer(3.0));
    _transforms.add(ParamTransformerChainGuard());

    assert(
      _transforms.last is ParamTransformerChainGuard,
      'Use ParamTransformerChainGuard to ensure stopable looping',
    );
  }

  // endregion Param Transforms

  // region Channel Methods
  static Future<int> createImageTexture(
    String url, {
    required double width,
    required double height,
    String? placeholderPath,
    String? errorPlaceholderPath,
    int blur = 0,
    int quality = 100,
    int downscaleSize = 80,
    bool grayScale = false,
    bool ignorAlpha = true,
    bool autoDownscale = true,
    double blurSampling = 1.0,
    BoxFit fit = BoxFit.contain,
    BorderRadius borderRadius = BorderRadius.zero,
  }) async {
    final imageInfo = _buildFetchInfo(
      url,
      width: width,
      height: height,
      placeholder: placeholderPath,
      errorPlaceholder: errorPlaceholderPath,
      fit: fit,
      blur: blur,
      quality: quality,
      grayScale: grayScale,
      ignorAlpha: ignorAlpha,
      blurSampling: blurSampling,
      borderRadius: borderRadius,
      autoDownscale: autoDownscale,
      downscaleSize: downscaleSize,
    );

    final base64Data = await _channel.invokeMethod(
      Methods.createImageTexture,
      imageInfo.writeToBuffer(),
    );

    final result = $pb.ImageFetchResultInfo.fromBuffer(base64Data);
    return result.textureId.toInt();
  }

  static Future<void> destroyImageTexture(
    int? textureId,
    String url, {
    bool canBeResused = true,
  }) {
    final cancelInfo = $pb.ImageDisposeInfo()
      ..url = url
      ..canBeReused = canBeResused
      ..textureId = Int64(textureId ?? -1);

    return _channel.invokeMethod(
      Methods.disposeImageTexture,
      cancelInfo.writeToBuffer(),
    );
  }

  static Future<void> updateConfig({
    bool? useOpenGLRendering,
    bool? compressInLowMemory,
    String? placeholder,
    String? errorPlaceholer,
    String? backgroundColor,
    double? cachedMemoryPercetage,
  }) async {
    final config = $pb.ImageConfigInfo()
      ..placeholder = placeholder ?? _defConfig.placeholder
      ..errorPlaceholder = errorPlaceholer ?? _defConfig.errorPlaceholder
      ..backgroundColor = backgroundColor ?? _defConfig.backgroundColor
      ..useOpenGLRendering = useOpenGLRendering ?? _defConfig.useOpenGLRendering
      ..reduceQualityInLowMemory =
          compressInLowMemory ?? _defConfig.reduceQualityInLowMemory
      ..androidAvailableMemoryPercentage =
          cachedMemoryPercetage ?? _defConfig.androidAvailableMemoryPercentage;

    return _channel.invokeMethod(
      Methods.textureImageConfig,
      config.writeToBuffer(),
    );
  }

  static Future<void> cleanCache() async {
    _channel.invokeListMethod(Methods.releaseImageTextureCaches);
  }

  // endregion Channel Methods

  // region Message Building
  static $pb.ImageFetchInfo _buildFetchInfo(
    String url, {
    required double width,
    required double height,
    String? placeholder,
    String? errorPlaceholder,
    int blur = 0,
    int quality = 100,
    int downscaleSize = 80,
    bool grayScale = false,
    bool ignorAlpha = true,
    bool autoDownscale = true,
    double blurSampling = 1.0,
    BoxFit fit = BoxFit.contain,
    BorderRadius borderRadius = BorderRadius.zero,
  }) {
    final imageGeometry = $pb.Geometry()
      ..fit = _convertBoxFit(fit)
      ..width = width.evenSize
      ..height = height.evenSize
      ..supportAlpha = !ignorAlpha
      ..borderRadius = _convertBorderRadius(borderRadius);

    final imageQulality = $pb.Quality()
      ..autoDownscale = autoDownscale
      ..minimumAutoDownscaleTriggerSize = downscaleSize
      ..quality = quality;

    final rawInfo = $pb.ImageFetchInfo()
      ..url = url
      ..blur = blur
      ..grayScale = grayScale
      ..quality = imageQulality
      ..geometry = imageGeometry
      ..blurSampling = blurSampling
      ..placeholder = placeholder ?? ''
      ..errorPlaceholder = errorPlaceholder ?? '';

    final transformChain = ParamTransformerChain(
      index: 0,
      fetchInfo: rawInfo,
      transformers: _transforms,
    );

    return transformChain.proceed(rawInfo);
  }

  static $pb.BorderRadius _convertBorderRadius(BorderRadius radius) =>
      $pb.BorderRadius()
        ..topLeft = radius.topLeft.x
        ..topRight = radius.topRight.x
        ..bottomLeft = radius.bottomLeft.x
        ..bottomRight = radius.bottomRight.x;

  static $pb.BoxFit _convertBoxFit(BoxFit fit) {
    switch (fit) {
      case BoxFit.contain:
        return $pb.BoxFit.contain;
      case BoxFit.cover:
        return $pb.BoxFit.cover;
      case BoxFit.fitWidth:
        return $pb.BoxFit.fitWidth;
      case BoxFit.fitHeight:
        return $pb.BoxFit.fitHeight;
      default:
        return $pb.BoxFit.fill;
    }
  }
// endregion Message Building
}
