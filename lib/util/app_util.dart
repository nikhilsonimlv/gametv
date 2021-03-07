import 'dart:ui';

import 'package:flutter/material.dart';

class AppUtil {
  static getColorFromHex(String hexCode) {
    hexCode = hexCode.replaceAll("#", "");
    if (hexCode.length == 6) {
      hexCode = "FF" + hexCode;
    }
    if (hexCode.length == 8) {
      return Color(int.parse("0x$hexCode"));
    }
  }
}
