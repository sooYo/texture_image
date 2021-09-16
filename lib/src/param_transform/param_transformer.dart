import 'package:texture_image/src/proto/pb_header.dart';

export 'transfromers/guard_transformer.dart';

class ParamTransformerChain {
  ParamTransformerChain({
    required int index,
    required ImageFetchInfo fetchInfo,
    required List<ParamTransformerImpl> transformers,
  })  : _index = index,
        _impls = transformers,
        _fetchInfo = fetchInfo;

  int _index = 0;
  ImageFetchInfo _fetchInfo;
  List<ParamTransformerImpl> _impls;

  ImageFetchInfo get fetchInfo => _fetchInfo;

  ImageFetchInfo proceed(ImageFetchInfo fetchInfo) {
    if (_impls.isEmpty) {
      return fetchInfo;
    }

    final chain = ParamTransformerChain(
      index: _index + 1,
      fetchInfo: fetchInfo,
      transformers: _impls,
    );

    if (_index >= _impls.length) {
      assert(false, 'Loop over entire list without returning a legal result');
      return fetchInfo;
    }

    return _impls[_index].transform(chain);
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
