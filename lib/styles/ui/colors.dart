import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color.fromRGBO(0, 0, 0, 1);

  static const Color bg = Color.fromRGBO(53, 54, 58, 1);
  static const Color bgDark = Color.fromRGBO(255, 255, 255, 1);

  static const Color translucent = Color.fromRGBO(0, 0, 0, 0.260);
  static Color opacity({double? level}) =>
      Color.fromRGBO(0, 0, 0, level ?? 0.15);

  static const Color textPrimary = Color.fromRGBO(106, 106, 106, 1);
  static const Color textDark = Color.fromRGBO(234, 234, 234, 1);

  static const Color emphasis = Color.fromRGBO(250, 74, 12, 1);
  static const Color success = Color.fromRGBO(66, 133, 244, 1);
  static const Color error = Color.fromRGBO(255, 26, 26, 1);

  static const Color input = Color.fromRGBO(241, 243, 244, 1);
  static const Color inputDark = Color.fromRGBO(32, 33, 36, 1);
}
