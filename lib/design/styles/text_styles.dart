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
  /// This is the style used for the branded name of app
  static TextStyle get display =>
      TextStyle(fontSize: FontSizes.display, fontWeight: FontWeight.bold);

  /// Style used mostly for title of dialogs
  static TextStyle get title =>
      TextStyle(fontSize: FontSizes.title, fontWeight: FontWeight.bold);

  /// Styles used mostly for `screen or page` headings
  static TextStyle get heading =>
      TextStyle(fontSize: FontSizes.heading, fontWeight: FontWeight.w500);
  static TextStyle get headingBold =>
      heading.copyWith(fontWeight: FontWeight.bold);

  /// Styles used for labels of form fields
  static TextStyle get label =>
      TextStyle(fontSize: FontSizes.label, fontWeight: FontWeight.w600);
  static TextStyle get labelBold => label.copyWith(fontWeight: FontWeight.bold);

  /// Styles used for headings of sections
  static TextStyle get headline => TextStyle(fontSize: FontSizes.headline);
  static TextStyle get headlineBold =>
      headline.copyWith(fontWeight: FontWeight.bold);

  /// General styles to be used in the body of app.
  static TextStyle get body => TextStyle(fontSize: FontSizes.body);
  static TextStyle get bodySemibold =>
      body.copyWith(fontWeight: FontWeight.w600);
  static TextStyle get bodyBold => body.copyWith(fontWeight: FontWeight.bold);

  /// Used for captions of any emphasis texts.
  static TextStyle get caption => TextStyle(fontSize: FontSizes.caption);
  static TextStyle get captionBold =>
      caption.copyWith(fontWeight: FontWeight.bold);
}

extension CustomTextTheme on TextTheme {
  static TextStyle get display => TextStyles.display;

  /// Style used mostly for title of dialogs
  static TextStyle get title => TextStyles.title;

  /// Styles used mostly for `screen or page` headings
  static TextStyle get heading => TextStyles.heading;
  static TextStyle get headingBold => TextStyles.headingBold;

  /// Styles used for labels of form fields
  static TextStyle get label => TextStyles.label;
  static TextStyle get labelBold => TextStyles.labelBold;

  /// Styles used for headings of sections
  static TextStyle get headline => TextStyles.headline;
  static TextStyle get headlineBold => TextStyles.headlineBold;

  /// General styles to be used in the body of app.
  static TextStyle get body => TextStyles.body;
  static TextStyle get bodySemibold => TextStyles.bodySemibold;
  static TextStyle get bodyBold => TextStyles.bodyBold;

  /// Used for captions of any emphasis texts.
  static TextStyle get caption => TextStyles.caption;
  static TextStyle get captionBold => TextStyles.captionBold;
}
