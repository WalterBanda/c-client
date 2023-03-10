import 'package:flutter/material.dart';

class Fonts {
  static String get title => "Roboto";
}

class FontSizes {
  static double get display => 36;
  static double get title => 30;
  static double get heading => 24;
  static double get label => 18;
  static double get headline => 16;
  static double get body => 15;
  static double get caption => 13;
}

/// Contains all typography styles for this app.
class TextStyles {
  static TextStyle get display => TextStyle(
        fontSize: FontSizes.display,
      );

  static TextStyle get title => TextStyle(
        fontSize: FontSizes.title,
      );
  static TextStyle get heading => TextStyle(
        fontSize: FontSizes.heading,
      );
  static TextStyle get label => TextStyle(
        fontSize: FontSizes.label,
      );
  static TextStyle get headline => TextStyle(
        fontSize: FontSizes.headline,
      );
  static TextStyle get body => TextStyle(
        fontSize: FontSizes.body,
      );
  static TextStyle get caption => TextStyle(
        fontSize: FontSizes.caption,
      );
}
