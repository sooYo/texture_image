import 'package:texture_image/src/proto/pb_header.dart';

export 'transfromers/guard_transformer.dart';
export 'transfromers/qiniu_transformer.dart';

class ParamTransformerChain {
  ParamTransformerChain({
    required this.index,
    required this.fetchInfo,
    required List<ParamTransformerImpl> transformers,
  }) {
    _impls.addAll(transformers);
  }

  final int index;
  final ImageFetchInfo fetchInfo;
  final List<ParamTransformerImpl> _impls = <ParamTransformerImpl>[];

  ImageFetchInfo proceed(ImageFetchInfo fetchInfo) {
    if (_impls.isEmpty) {
      return fetchInfo;
    }

    final chain = ParamTransformerChain(
      index: index + 1,
      fetchInfo: fetchInfo,
      transformers: _impls,
    );

    if (index >= _impls.length) {
      assert(false, 'Loop over entire list without returning a legal result');
      return fetchInfo;
    }

    return _impls[index].transform(chain);
  }
}

/// An interface used to make transformation on the images' fecth
/// parameters. A typically application situation is to coporate
/// with third-party Cloud Storage Service, eg. [Qiniu](https://www.qiniu.com/)
/// from China. At this situation, some paramters, like `blur`
/// and `radius`, can be transfromed into a URL query, and thus
/// native side can skip the image transformation progress.
mixin ParamTransformerImpl {
  ImageFetchInfo transform(ParamTransformerChain chain);
}
