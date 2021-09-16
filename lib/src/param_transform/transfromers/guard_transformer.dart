import '../../proto/src/image_info.pb.dart';
import '../param_transformer.dart';

/// This class simply return the origin fetch info. It is
/// aimed at breaking the chain to prevent infinite looping
///
/// It should always be the last object in the transformers list
class ParamTransformerChainGuard implements ParamTransformerImpl {
  @override
  ImageFetchInfo transform(ParamTransformerChain chain) => chain.fetchInfo;
}
