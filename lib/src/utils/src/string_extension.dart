import 'package:flutter/material.dart';

import '../../proxy/log_proxy.dart';

extension ValueParse on String {
  /// Check if this string represents a [Color] that's not transparent
  bool get isOpaqueColor {
    final test = trim();

    if (RegExp(r'^(0x|#)[A-F0-9]{6}$').hasMatch(test)) {
      // This is recognized as the RRGGBB format
      return true;
    }

    if (RegExp(r'^(0x|#)[A-F0-9]{8}$').hasMatch(test)) {
      // This is the AARRGGBB format, we need to check the first 2 mask values
      final value = test.replaceFirst('#', '').replaceFirst('0x', '').trim();
      return !value.startsWith('00');
    }

    // It's not a legal format color string
    log.w('Color', '$this is not a legal format color string');
    return false;
  }

  /// Construct a color from HEX string
  ///
  /// The leagl format should start with '0x' or '#' and followed
  /// by 6 or 8 digit numbers, for the length 6 format, it is 'RRGGBB'
  /// with alpha channel always be 255. the length 8 format is 'AARRGGBB'
  Color get color {
    if (isEmpty) {
      return Colors.black;
    }

    final hex = trim().replaceFirst('#', '').replaceFirst('0x', '').trim();

    if (hex.length != 6 && hex.length != 8) {
      return Colors.black;
    }

    final base = hex.length == 6 ? 0xFF000000 : 0x00000000;
    return Color(int.tryParse(hex, radix: 16) ?? 0x00000000 + base);
  }
}
