import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';
import '../extension/image_config.dart';
import '../extension/material.dart';
import '../param_transform/param_transformer.dart';
import '../proto/pb_header.dart' as $pb;
import '../proxy/log_proxy.dart';
import '../utils/utils.dart';

class TextureImagePlugin {
  static const TAG = 'TextureImage';

  static const _channel = MethodChannel('texture_image');
  static final _transforms = <ParamTransformerImpl>[];

  static $pb.ImageConfigInfo _globalConfig = DefaultConfig;

  static $pb.ImageConfigInfo get globalConfig => _globalConfig;

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
      'Use ParamTransformerChainGuard to ensure halting the loop',
    );
  }

  // endregion Param Transforms

  // region Channel Methods
  static Future<$pb.ResultInfo> createImageTexture(
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
      blurSampling: blurSampling,
      quality: quality,
      grayScale: grayScale,
      ignorAlpha: ignorAlpha,
      borderRadius: borderRadius,
      autoDownscale: autoDownscale,
      downscaleSize: downscaleSize,
    );

    final base64Data = await _channel.invokeMethod(
      Methods.createImageTexture,
      imageInfo.writeToBuffer(),
    );

    try {
      return $pb.ResultInfo.fromBuffer(base64Data);
    } catch (e) {
      log.e(TAG, 'create text image: $e');
      return _buildPBParseFailedResult(url: url);
    }
  }

  static Future<$pb.ResultInfo> destroyImageTexture(
    int? textureId,
    String url, {
    bool canBeResused = true,
  }) async {
    final cancelInfo = $pb.ImageDisposeInfo()
      ..url = url
      ..canBeReused = canBeResused
      ..textureId = Int64(textureId ?? -1);

    final base64Data = await _channel.invokeMethod(
      Methods.disposeImageTexture,
      cancelInfo.writeToBuffer(),
    );

    try {
      return $pb.ResultInfo.fromBuffer(base64Data);
    } catch (e) {
      log.e(TAG, 'Dispose image: $e');
      return _buildPBParseFailedResult(
        textureId: textureId,
        url: url,
      );
    }
  }

  static Future<$pb.ResultInfo> updateConfig({
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

    _globalConfig = config;

    final base64Data = await _channel.invokeMethod(
      Methods.textureImageConfig,
      config.writeToBuffer(),
    );

    try {
      return $pb.ResultInfo.fromBuffer(base64Data);
    } catch (e) {
      log.e(TAG, 'Update config: $e');
      return _buildPBParseFailedResult();
    }
  }

  static Future<$pb.ResultInfo> cleanCache() async {
    final base64Data = await _channel.invokeMethod(
      Methods.releaseImageTextureCaches,
    );

    try {
      return $pb.ResultInfo.fromBuffer(base64Data);
    } catch (e) {
      log.e(TAG, 'Clean cache:$e');
      return _buildPBParseFailedResult();
    }
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

  static $pb.ResultInfo _buildPBParseFailedResult({
    int? textureId,
    String? url,
  }) {
    return $pb.ResultInfo()
      ..url = url ?? ''
      ..textureId = Int64(textureId ?? -1)
      ..state = $pb.TaskState.failed
      ..code = ErrorCode.pbParseFailed
      ..message = 'PB parsed failed on Flutter side';
  }
// endregion Message Building
}
