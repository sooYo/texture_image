import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';

import 'texture_image_plugin.dart' as $ti;

class TextureImageWidget extends StatefulWidget {
  TextureImageWidget(
    this.url, {
    required this.fit,
    required this.blur,
    required this.width,
    required this.height,
    required this.quality,
    required this.maskColor,
    required this.borderRadius,
    required this.grayScale,
    required this.blurSampling,
    required this.autoDownscale,
    required this.reuseAfterDispose,
    required this.downscaleTriggerSize,
    required this.ignorableAlphaChannel,
    this.placeholder,
    this.placeholderPath,
    this.errorPlaceholder,
    this.errorPlaceholderPath,
  });

  final String url;

  final double width;
  final double height;
  final double blurSampling;

  final BoxFit fit;
  final Color maskColor;
  final BorderRadius borderRadius;

  final Widget? placeholder;
  final String? placeholderPath;

  final Widget? errorPlaceholder;
  final String? errorPlaceholderPath;

  final bool grayScale;
  final bool autoDownscale;
  final bool reuseAfterDispose;
  final bool ignorableAlphaChannel;

  final int blur;
  final int quality;
  final int downscaleTriggerSize;

  @override
  State<StatefulWidget> createState() => _ImageState();
}

class _ImageState extends State<TextureImageWidget> {
  int? _textureId;

  /// With a solid mask, the image content is invisible at all
  bool get _isSolidMask => widget.maskColor.alpha == 255;

  /// An invisible mask can be removed from the view hierarchy
  bool get _isVisibleMask => widget.maskColor.alpha != 0;

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
    final mask = Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        color: widget.maskColor,
      ),
    );

    if (_isSolidMask) {
      return mask;
    }

    final content = _textureId != null && _textureId! >= 0
        ? Texture(textureId: _textureId!)
        : Container();

    final image = Container(
      width: widget.width,
      height: widget.height,
      child: content,
    );

    return _isVisibleMask ? Stack(children: [image, mask]) : image;
  }

  void _loadImage() async {
    if (_isSolidMask) {
      // Mask color cover the image and is fully opaque
      // thus is unnecessary to draw the image itself
      return;
    }

    final textureId = await $ti.TextureImagePlugin.createImageTexture(
      widget.url,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      blur: widget.blur,
      quality: widget.quality,
      grayScale: widget.grayScale,
      borderRadius: widget.borderRadius,
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
    if (_isSolidMask) {
      return;
    }

    unawaited(
      $ti.TextureImagePlugin.destroyImageTexture(
        _textureId,
        widget.url,
        canBeResused: widget.reuseAfterDispose,
      ),
    );
  }
}
