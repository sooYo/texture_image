import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';

import '../constants/load_state.dart';
import '../extension/image_fetch_result.dart';
import 'texture_image_plugin.dart';

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

  ImageLoadState _loadingState = ImageLoadState.init;

  /// With a solid mask, the image content is invisible at all
  bool get _isSolidMask => widget.maskColor.alpha == 255;

  /// An invisible mask can be removed from the view hierarchy
  bool get _isVisibleMask => widget.maskColor.alpha != 0;

  /// State to control animation
  CrossFadeState get _crossFadeState => _loadingState == ImageLoadState.init
      ? CrossFadeState.showFirst
      : CrossFadeState.showSecond;

  /// Whether the image loading completed successfuly
  bool get _imageLoaded => _loadingState == ImageLoadState.success;

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
    // The color mask lay above the image content
    final colorMask = Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        color: widget.maskColor,
      ),
    );

    if (_isSolidMask) {
      // A solid mask will not have any animated effect
      return colorMask;
    }

    // Placeholder comes into view at first
    final placeholder = widget.placeholder ??
        Image.asset(
          widget.placeholderPath ?? '',
          width: widget.width,
          height: widget.height,
          fit: BoxFit.cover,
        );

    // Widget to show when image loading failed
    final errorWidget = widget.errorPlaceholder ??
        Image.asset(
          widget.errorPlaceholderPath ?? '',
          width: widget.width,
          height: widget.height,
          fit: BoxFit.cover,
        );

    final imageContent = Container(
      width: widget.width,
      height: widget.height,
      child: _textureId != null && _textureId! >= 0
          ? Texture(textureId: _textureId!)
          : Container(),
    );

    final image = _isVisibleMask
        ? Stack(children: [imageContent, colorMask])
        : imageContent;

    return AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: _imageLoaded ? image : errorWidget,
      crossFadeState: _crossFadeState,
      firstCurve: Curves.easeInToLinear,
      secondCurve: Curves.linearToEaseOut,
      duration: Duration(milliseconds: 1000),
    );
  }

  void _loadImage() async {
    if (_isSolidMask) {
      // Mask color cover the image and is fully opaque
      // thus is unnecessary to draw the image itself
      return;
    }

    final fetchResult = await TextureImagePlugin.createImageTexture(
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
      _loadingState = fetchResult.loadState;
      _textureId = fetchResult.textureId.toInt();
    });
  }

  void _disposeImage() async {
    if (_isSolidMask) {
      return;
    }

    unawaited(
      TextureImagePlugin.destroyImageTexture(
        _textureId,
        widget.url,
        canBeResused: widget.reuseAfterDispose,
      ),
    );
  }
}
