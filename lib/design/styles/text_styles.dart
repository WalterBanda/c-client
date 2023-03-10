import 'package:flutter/material.dart';

/// Contains all typography styles for this app.
class Typography {

  static TextStyle largeTitle({required Color color}) => TextStyle(
        color: color,
        fontSize: 36,
        fontWeight: FontWeight.w700,
      );
  static TextStyle title({required Color color}) => TextStyle(
        color: color,
        fontSize: 30,
        fontWeight: FontWeight.w700,
      );
  static TextStyle headingBold({required Color color}) => TextStyle(
        color: color,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      );
  static TextStyle headingMedium({required Color color}) => TextStyle(
        color: color,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      );
  static TextStyle subheadingBold({required Color color}) => TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );
  static TextStyle subheadingSemiBold({required Color color}) => TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );
  static TextStyle headlineBold({required Color color}) => TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );
  static TextStyle headline({required Color color}) => TextStyle(
        color: color,
        fontSize: 16,
      );
  static TextStyle body({required Color color}) => TextStyle(
        color: color,
        fontSize: 15,
      );
  static TextStyle bodySemiBold({required Color color}) => TextStyle(
        color: color,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.90,
      );
  static TextStyle bodyBold({required Color color}) => TextStyle(
        color: color,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.90,
      );
  static TextStyle captionBold({required Color color}) => TextStyle(
        color: color,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      );
}
