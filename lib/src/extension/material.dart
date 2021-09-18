import 'package:flutter/material.dart';

import '../proto/pb_header.dart' as $pb;

extension PBTransform on BoxFit {
  $pb.BoxFit get pbRepresent {
    switch (this) {
      case BoxFit.contain:
        return $pb.BoxFit.contain;
      case BoxFit.cover:
        return $pb.BoxFit.cover;
      case BoxFit.fitWidth:
        return $pb.BoxFit.fitWidth;
      case BoxFit.fitHeight:
        return $pb.BoxFit.fitHeight;
      default:
        return $pb.BoxFit.fill;
    }
  }
}

extension PBTrarnsform on BorderRadius {
  $pb.BorderRadius get pbRepresent {
    return $pb.BorderRadius()
      ..topLeft = topLeft.x
      ..topRight = topRight.x
      ..bottomLeft = bottomLeft.x
      ..bottomRight = bottomRight.x;
  }
}
