import '../proto/pb_header.dart';

final DefaultConfig = ImageConfigInfo()
  ..useOpenGLRendering = false
  ..reduceQualityInLowMemory = true
  ..backgroundColor = '0xFF000000'
  ..androidAvailableMemoryPercentage = 0.1
  ..placeholder = 'lib/assets/ic_placeholder.png'
  ..errorPlaceholder = 'lib/assets/ic_error.png';
