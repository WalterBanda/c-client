import 'package:client/design/font_constants.dart';
import 'package:flutter/material.dart';

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
  /// Global TextStyle config
  static TextStyle get base =>
      const TextStyle(fontFamily: FontConstants.fontFamily);

  /// This is the style used for the branded name of app
  static TextStyle get display =>
      base.copyWith(fontSize: FontSizes.display, fontWeight: FontWeight.bold);

  /// Style used mostly for title of dialogs
  static TextStyle get title =>
      base.copyWith(fontSize: FontSizes.title, fontWeight: FontWeight.bold);

  /// Styles used mostly for `screen or page` headings
  static TextStyle get heading =>
      base.copyWith(fontSize: FontSizes.heading, fontWeight: FontWeight.w500);
  static TextStyle get headingBold =>
      heading.copyWith(fontWeight: FontWeight.bold);

  /// Styles used for labels of form fields
  static TextStyle get label =>
      base.copyWith(fontSize: FontSizes.label, fontWeight: FontWeight.w600);
  static TextStyle get labelBold => label.copyWith(fontWeight: FontWeight.bold);

  /// Styles used for headings of sections
  static TextStyle get headline => base.copyWith(fontSize: FontSizes.headline);
  static TextStyle get headlineBold =>
      headline.copyWith(fontWeight: FontWeight.bold);

  /// General styles to be used in the body of app.
  static TextStyle get body => base.copyWith(fontSize: FontSizes.body);
  static TextStyle get bodySemibold =>
      body.copyWith(fontWeight: FontWeight.w600);
  static TextStyle get bodyBold => body.copyWith(fontWeight: FontWeight.bold);

  /// Used for captions of any emphasis texts.
  static TextStyle get caption => base.copyWith(fontSize: FontSizes.caption);
  static TextStyle get captionBold =>
      caption.copyWith(fontWeight: FontWeight.bold);
}
