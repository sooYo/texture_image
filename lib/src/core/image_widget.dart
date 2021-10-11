import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';

import '../constants/constants.dart';
import '../extension/image_fetch_result.dart';
import '../proto/pb_header.dart' as $pb;
import '../utils/utils.dart';
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

  ImageLoadState _loadState = ImageLoadState.init;

  /// With a solid mask, the image content is invisible at all
  bool get _isSolidMask => widget.maskColor.alpha == 255;

  /// An invisible mask can be removed from the view hierarchy
  bool get _isVisibleMask => widget.maskColor.alpha != 0;

  /// Whether the image loading completed successfuly
  bool get _imageLoaded => _loadState == ImageLoadState.success;

  /// State to control animation
  CrossFadeState get _crossFadeState => _loadState == ImageLoadState.init
      ? CrossFadeState.showFirst
      : CrossFadeState.showSecond;

  /// Shortcut for globalConfig
  $pb.ImageConfigInfo get config => TextureImagePlugin.globalConfig;

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
    final placeholder = _Placeholder(
      widget.placeholderPath ?? config.placeholder,
      widget: widget.placeholder,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
      borderRadius: widget.borderRadius,
      backgroundColor: config.backgroundColor,
    );

    // Widget to show when image loading failed
    final errorWidget = _Placeholder(
      widget.errorPlaceholderPath ?? config.errorPlaceholder,
      widget: widget.errorPlaceholder,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
      borderRadius: widget.borderRadius,
      backgroundColor: config.backgroundColor,
    );

    final imageContent = Container(
      width: widget.width,
      height: widget.height,
      child: _imageLoaded && _textureId != null && _textureId! >= 0
          ? Texture(textureId: _textureId!)
          : Container(),
    );

    final image = _isVisibleMask
        ? Stack(children: [imageContent, colorMask])
        : imageContent;

    // Add a fade-in-out effect
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
      _loadState = fetchResult.loadState;
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

class _Placeholder extends StatelessWidget {
  _Placeholder(
    this.placeholder, {
    String? backgroundColor,
    required this.width,
    required this.height,
    this.widget,
    this.borderRadius,
    this.fit = BoxFit.cover,
  })  : isOpaqueBackground = backgroundColor?.isOpaqueColor ?? false,
        backgroundColor = backgroundColor?.color ?? Colors.transparent,
        assert(
          widget != null || placeholder != null,
          'At least provide a way to construct this widget',
        );

  final double width;
  final double height;

  /// Custom style of this placeholder
  final Widget? widget;

  final BoxFit fit;
  final String? placeholder;
  final BorderRadius? borderRadius;

  /// Calculated from the `backgroundColor` string
  final Color backgroundColor;
  final bool isOpaqueBackground;

  @override
  Widget build(BuildContext context) {
    if (widget != null) {
      return widget!;
    }

    Widget result = Image.asset(
      placeholder ?? DefaultConfig.placeholder,
      width: width,
      height: height,
      fit: fit,
    );

    if (borderRadius != null && borderRadius != BorderRadius.zero) {
      result = ClipRRect(
        borderRadius: borderRadius!,
        child: result,
      );
    }

    if (isOpaqueBackground) {
      result = Container(
        color: backgroundColor,
        child: result,
      );
    }

    return result;
  }
}
