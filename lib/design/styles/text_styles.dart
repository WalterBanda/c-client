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
  static TextStyle get display =>
      TextStyle(fontSize: FontSizes.display, fontWeight: FontWeight.bold);
  static TextStyle get title =>
      TextStyle(fontSize: FontSizes.title, fontWeight: FontWeight.bold);

  static TextStyle get heading =>
      TextStyle(fontSize: FontSizes.heading, fontWeight: FontWeight.w500);
  static TextStyle get headingBold =>
      heading.copyWith(fontWeight: FontWeight.bold);

  static TextStyle get label =>
      TextStyle(fontSize: FontSizes.label, fontWeight: FontWeight.w600);
  static TextStyle get labelBold => label.copyWith(fontWeight: FontWeight.bold);

  static TextStyle get headline => TextStyle(fontSize: FontSizes.headline);
  static TextStyle get headlineBold =>
      headline.copyWith(fontWeight: FontWeight.bold);

  static TextStyle get body => TextStyle(fontSize: FontSizes.body);
  static TextStyle get bodySemibold =>
      body.copyWith(fontWeight: FontWeight.w600);
  static TextStyle get bodyBold => body.copyWith(fontWeight: FontWeight.bold);

  static TextStyle get caption => TextStyle(fontSize: FontSizes.caption);
  static TextStyle get captionBold =>
      caption.copyWith(fontWeight: FontWeight.bold);
}
