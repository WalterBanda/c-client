import 'package:flutter/material.dart';

class ColorScheme {
  ColorScheme({
    required this.primary,
    required this.bg,
    required this.input,
    required this.text,
    required this.placeholder,
    required this.translucent,
    required this.gain,
    required this.loss,
    required this.gainGradient,
    required this.lossGradient,
    required this.emphasis,
    required this.error,
    required this.success,
  });

  Color primary;

  Color bg;
  Color input;

  Color translucent;

  Color text;
  Color placeholder;

  Color emphasis;
  Color success;
  Color error;
  Color gain;
  Color loss;
  Color gainGradient;
  Color lossGradient;
}
