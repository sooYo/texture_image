import '../constants/constants.dart';
import '../proto/pb_header.dart';

extension PluginExtension on ImageConfigInfo {
  ImageConfigInfo load({
    bool? useOpenGLRendering,
    bool? compressInLowMemory,
    String? placeholder,
    String? errorPlaceholer,
    String? backgroundColor,
    double? memoryCacheSizeSpace,
  }) {
    this.placeholder = placeholder ?? DefaultConfig.placeholder;
    this.errorPlaceholder = errorPlaceholer ?? DefaultConfig.errorPlaceholder;
    this.backgroundColor = backgroundColor ?? DefaultConfig.backgroundColor;
    this.useOpenGLRendering = useOpenGLRendering ?? DefaultConfig.useOpenGLRendering;
    this.reduceQualityInLowMemory = compressInLowMemory ?? DefaultConfig.reduceQualityInLowMemory;
    this.androidAvailableMemoryPercentage = memoryCacheSizeSpace ?? DefaultConfig.androidAvailableMemoryPercentage;
    return this;
  }
}
