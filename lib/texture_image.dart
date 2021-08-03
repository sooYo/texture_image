import 'package:flutter/material.dart' hide BoxFit;
import 'package:texture_image/src/proto/pb_header.dart';
import 'package:texture_image/texture_image_plugin.dart';

export 'package:texture_image/src/proto/pb_header.dart';

class TextureImage extends StatefulWidget {
  TextureImage(
    this.url, {
    required this.width,
    required this.height,
    this.placeholder,
    this.fit = BoxFit.contain,
  });

  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget? placeholder;

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
              color: Colors.grey,
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
    final textureId = await TextureImagePlugin.createImageTexture(
      widget.url,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _textureId = textureId;
    });
  }

  void _disposeImage() async {
    TextureImagePlugin.destroyImageTexture(_textureId, widget.url);
  }
}
