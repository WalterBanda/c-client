import 'package:flutter/material.dart';

class ColorScheme {
  ColorScheme({
    required this.primary,
    required this.bg,
    required this.translucent,
    required this.opacity,
    required this.textPrimary,
    required this.emphasis,
    required this.error,
    required this.success,
    required this.input,
    required this.inputDark,
  });

  Color primary;

  Color bg;

  Color translucent;
  Color opacity;

  Color textPrimary;

  Color emphasis;
  Color success;
  Color error;
  Color input;
  Color inputDark;
}
