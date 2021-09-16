import 'dart:math';

import '../../proto/pb_header.dart';
import '../param_transformer.dart';

/// Qiniu parameter converter
///
/// Using qiniu imageMogr2 API to achieve image transformation
/// If the image url starts with a legal host, then some of the
/// fetching parameters will be converted into URL queries, and
/// reset the ImageFetchInfo to reduce native side work
class QiniuParamTransformer with ParamTransformerImpl {
  QiniuParamTransformer(this.devicePixelRatio);

  /// Pixel ratio used to calculate the actual pixel size of this image
  final double devicePixelRatio;

  @override
  ImageFetchInfo transform(ParamTransformerChain chain) {
    if (!chain.fetchInfo._isQiniuHostedImage) {
      return chain.proceed(chain.fetchInfo);
    }

    final fetchInfo = chain.fetchInfo
        .applyImageProceedCommand(devicePixelRatio)
        .applyRoundPicProceedCommand(devicePixelRatio);

    return chain.proceed(fetchInfo);
  }
}

extension _QiniuUrlHandler on ImageFetchInfo {
  bool get _isQiniuHostedImage {
    final host = Uri.tryParse(url)?.host;
    return ['img.ah-suuwaa.com'].contains(host);
  }

  ImageFetchInfo _invokeQiniuCommand(String api) {
    if (url.contains(api)) {
      return this;
    }

    final append = url.contains(r'(?:imageMogr2|roundPic|');
    return this..url += '${append ? '|' : '?'}$api';
  }

  // region ImageMogr2 Command
  ImageFetchInfo applyImageProceedCommand(double devicePixelRatio) => this
      ._invokeQiniuCommand('imageMogr2')
      ._convertSizeParams(devicePixelRatio)
      ._convertBlurParams();

  ImageFetchInfo _convertSizeParams(double devicePixelRatio) {
    final pixelWidth = geometry.width * devicePixelRatio;
    final pixelHeight = geometry.height * devicePixelRatio;
    final sizeQuery = '/thumbnail/${pixelWidth}x$pixelHeight';

    return this..url += sizeQuery;
  }

  ImageFetchInfo _convertBlurParams() {
    final blur = max(1, min(this.blur, 50));
    this.blur = 0; // Skip native proceeding
    return this..url += '/blur/${blur}x$blur';
  }

  // endregion ImageMogr2 Command

  // region RoundPic Command
  ImageFetchInfo applyRoundPicProceedCommand(double devicePixelRatio) {
    // Qiniu cannot hanlde unequal radius
    if (geometry.borderRadius.isRegular) {
      return this;
    }

    return this
        ._invokeQiniuCommand('roundPic')
        ._convertBorderRadiusParams(devicePixelRatio);
  }

  ImageFetchInfo _convertBorderRadiusParams(double devicePixelRatio) {
    // Skip native proceed
    geometry.borderRadius = BorderRadius();

    final radius = geometry.borderRadius.topLeft * devicePixelRatio;
    return this..url += '/roundPic/radius/$radius';
  }

// endRegion RoundPic Command
}

extension _Introspection on BorderRadius {
  // Whether all radius of four conrners are equals
  bool get isRegular {
    final sum = topLeft + topRight + bottomLeft + bottomRight;
    return (sum / 4.0) - topLeft <= 0.0001;
  }
}
