import 'package:flutter/material.dart';
import 'package:texture_image/texture_image_plugin.dart';

class TextureImage extends StatefulWidget {
  TextureImage(
    this.url, {
    required this.width,
    required this.height,
    this.placeholder,
  });

  final String url;
  final double width;
  final double height;

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
    final content = _textureId != null
        ? Texture(textureId: _textureId!)
        : (widget.placeholder ?? Container(color: Colors.grey));

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
