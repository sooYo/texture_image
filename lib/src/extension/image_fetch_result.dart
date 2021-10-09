import 'package:texture_image/texture_image.dart';

import '../constants/constants.dart';
import '../proto/pb_header.dart';

extension PluginExtension on ResultInfo {
  ImageLoadState get loadState {
    switch (state) {
      case TaskState.initialized:
      case TaskState.loading:
        return ImageLoadState.init;
      case TaskState.completed:
      case TaskState.prepreReuse:
        return ImageLoadState.success;
      default:
        return ImageLoadState.fail;
    }
  }
}
