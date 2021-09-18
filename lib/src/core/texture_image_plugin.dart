import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/error_codes.dart';
import '../constants/methods.dart';
import '../extension/image_config.dart';
import '../extension/material.dart';
import '../param_transform/param_transformer.dart';
import '../proto/pb_header.dart' as $pb;
import '../proxy/log_proxy.dart';
import '../utils/double_extension.dart';

class TextureImagePlugin {
  static const TAG = 'TextureImage';

  static const _channel = MethodChannel('texture_image');
  static final _transforms = <ParamTransformerImpl>[];

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
  static Future<$pb.ImageFetchResultInfo> createImageTexture(
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

    try {
      return $pb.ImageFetchResultInfo.fromBuffer(base64Data);
    } catch (e) {
      log.e(TAG, e.toString());

      return $pb.ImageFetchResultInfo()
        ..url = url
        ..textureId = Int64(-1)
        ..state = $pb.TaskState.failed
        ..code = ErrorCode.pbParseFailed
        ..message = 'PB parsed failed on Flutter side';
    }
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
    final config = $pb.ImageConfigInfo().load(
      placeholder: placeholder,
      errorPlaceholer: errorPlaceholer,
      backgroundColor: backgroundColor,
      useOpenGLRendering: useOpenGLRendering,
      compressInLowMemory: compressInLowMemory,
      memoryCacheSizeSpace: cachedMemoryPercetage,
    );

    return _channel.invokeMethod(
      Methods.textureImageConfig,
      config.writeToBuffer(),
    );
  }

  static Future<void> cleanCache() {
    return _channel.invokeListMethod(Methods.releaseImageTextureCaches);
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
      ..fit = fit.pbRepresent
      ..width = width.evenSize
      ..height = height.evenSize
      ..supportAlpha = !ignorAlpha
      ..borderRadius = borderRadius.pbRepresent;

    final imageQulality = $pb.Quality()
      ..quality = quality
      ..autoDownscale = autoDownscale
      ..minimumAutoDownscaleTriggerSize = downscaleSize;

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
// endregion Message Building
}
