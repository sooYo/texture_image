import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ResolutionUtils {
  double _ptPerPx = 1;
  bool _hadReSetPtPerPx = false;

  ResolutionUtils._() {
    _setupPt();
  }

  static ResolutionUtils get instance => _instance;
  static ResolutionUtils _instance = ResolutionUtils._();

  void _setupPt() {
    if (!_hadReSetPtPerPx) {
      MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
      Size screenSize = mediaQuery.size;
      double ptPerPx = screenSize.width / 375;

      if (ptPerPx > 0) {
        _ptPerPx = ptPerPx;
        _hadReSetPtPerPx = true;
      }
    }
  }

  double ptToPx(double pt) {
    _setupPt();
    return pt * _ptPerPx;
  }
}

double pt(double pt) {
  return ResolutionUtils.instance.ptToPx(pt);
}

double sp(double sp) {
  return ResolutionUtils.instance.ptToPx(sp);
}
