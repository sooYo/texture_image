import 'dart:io';

import 'package:flutter/material.dart';
import 'package:texture_image/src/texture_image_plugin.dart' as $ti;

/// Image widget using [Texture] to display images
///
/// The image is supported by native side images libraries and much of
/// the enhancement works are done by native side.
///
/// On Android, it is [Coil](https://github.com/coil-kt/coil)
/// On iOS, it is [SDWebImage](https://github.com/SDWebImage/SDWebImage)
///
/// Image compression can be controled across the [quality], [autoDownscale],
/// [ignorableAlphaChannel] and [downscaleTriggerSize] properties.
///
/// Use the [blur], [blurSampling] and [maskColor] to achieve a simple blur effect.
///
/// [grayScale] helps to make a solid gray style image, this is helpful for some
/// situation like showing an offline status avatar
///
/// Reusing logic is decided by [reuseAfterDispose], this will allow the backend
/// data buffer to be reused for saving buffer creation cost
class TextureImage extends StatefulWidget {
  TextureImage(
    this.url, {
    required this.width,
    required this.height,
    this.placeholder,
    this.placeholderPath,
    this.errorPlaceholder,
    this.errorPlaceholderPath,
    this.blur = 0,
    this.quality = 100,
    this.grayScale = false,
    this.blurSampling = 1.0,
    this.autoDownscale = true,
    this.downscaleTriggerSize = 80,
    this.reuseAfterDispose = true,
    this.ignorableAlphaChannel = true,
    this.fit = BoxFit.contain,
    this.maskColor = Colors.transparent,
    this.borderRadius = BorderRadius.zero,
  });

  final String url;
  final double width;
  final double height;

  final BoxFit fit;
  final BorderRadius borderRadius;

  /// Placeholder when image is loading
  ///
  /// User can provide both a widget, say [placeholder], and also a
  /// assets file path [placeholderPath] to enable this feature. If
  /// the two values are provided at the same time, [placeholder]
  /// shall be used at high priority
  final Widget? placeholder;
  final String? placeholderPath;

  /// Error placeholder when image loading failed
  ///
  /// The priority is same as placeholder
  final Widget? errorPlaceholder;
  final String? errorPlaceholderPath;

  /// Ignore alpha channel
  ///
  /// Indicating image can ignore alpha channel can do some help
  /// on memory reducing from the native side. Once an image can
  /// ignore alpha channel, the picture format will automatically
  /// change to RGB_565, which is half size of the origin format
  /// ARGB_8888.
  ///
  /// It's suggested to enable this feature if you know what will
  /// happend under the hood
  final bool ignorableAlphaChannel;

  /// Blur effect
  ///
  /// [blur] gives the blur radius, ranging from 0 to 50. With 0 stands for 'no blur'.
  /// The larger the value is, the less detail shall be remained.
  final int blur;

  /// Sampling with blur effect
  ///
  /// If [blur] is equal to 0, or current platform isn't [Platform.isAndroid],
  /// this value is ignored. The sampling multiplier used to scale the image.
  /// Values > 1 will downscale the image. Values between 0 and 1 will upscale
  /// the image
  final double blurSampling;

  /// A colored mask lay over the image. Usually combine with the blur effect.
  final Color maskColor;

  /// Show gray style image instead of full-color one
  final bool grayScale;

  /// Automatically compress image
  ///
  /// Allow the plugin to reduce image quality according to the image size
  /// and device pixel ratio. Images will be downscaled by multiply a size
  /// factor. Refer to ImageInfo.kt for detail calculation logic.
  ///
  /// [downscaleTriggerSize] takes effect only when [autoDownscale] is `true`,
  /// it decides the minimum size that auto compression should perform. For
  /// example, image with [downscaleTriggerSize] sets to 80 will not perform
  /// auto comprssion if one aspect size is smaller than 80, like 100 x 40
  final bool autoDownscale;
  final int downscaleTriggerSize;

  /// Force compression
  ///
  /// If this value is lower than 100, then a force compression shall be
  /// performed,[autoDownscale] and [downscaleTriggerSize] will be both
  /// ignored. The legal value ranging from 0 to 100, with 100 stands
  /// for 'no compress'.
  ///
  /// It's not suggested to compress image using this property unless
  /// it's in a very bad memory situation, because compression proceed
  /// consumes more CPU resources.
  final int quality;

  /// Reuse image's data buffer
  ///
  /// Indicates whether the backend SurfaceTexture can be reused for saving
  /// creation time. The reused SurfaceTexture will be released later is it's
  /// free and [TextureImagePlugin.cleanCache] is invoked
  final bool reuseAfterDispose;

  @override
  State<StatefulWidget> createState() => _ImageState();
}

class _ImageState extends State<TextureImage> {
  int? _textureId;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void dispose() {
    _disposeImage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = _textureId != null && _textureId! >= 0
        ? Texture(textureId: _textureId!)
        : (widget.placeholder ??
            Container(
              height: widget.height,
              width: widget.width,
            ));

    return Container(
      width: widget.width,
      height: widget.height,
      child: content,
    );
  }

  void _loadImage() async {
    final textureId = await $ti.TextureImagePlugin.createImageTexture(
      widget.url,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      blur: widget.blur,
      quality: widget.quality,
      grayScale: widget.grayScale,
      blurSampling: widget.blurSampling,
      autoDownscale: widget.autoDownscale,
      placeholderPath: widget.placeholderPath,
      ignorAlpha: widget.ignorableAlphaChannel,
      downscaleSize: widget.downscaleTriggerSize,
      errorPlaceholderPath: widget.errorPlaceholderPath,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _textureId = textureId;
    });
  }

  void _disposeImage() async {
    $ti.TextureImagePlugin.destroyImageTexture(
      _textureId,
      widget.url,
      canBeResused: widget.reuseAfterDispose,
    );
  }
}
