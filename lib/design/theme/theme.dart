import 'package:client/design/styles/colors.dart';
import 'package:client/design/styles/text_styles.dart';
import 'package:flutter/material.dart';

/// `💡` This class contains base theme indepedent styles. The styles are used as a basis where the various themes are applied onto it.
class BaseTheme {
  /// Default font family for application.
  static const String fontFamily = "SF Pro Rounded";

  /// Default theme agnostic text theme. This overrides the material styling for text and also introduces custom text themes for app.
  static TextTheme get textTheme => TextTheme(
        displaySmall: TextStyles.display,
        headlineLarge: TextStyles.title,
        headlineMedium: TextStyles.title,
        headlineSmall: TextStyles.heading,
        titleLarge: TextStyles.headingBold,
        titleMedium: TextStyles.headlineBold,
        titleSmall: TextStyles.headline,
        labelLarge: TextStyles.labelBold,
        labelMedium: TextStyles.label,
        labelSmall: TextStyles.label,
        bodyLarge: TextStyles.headline,
        bodyMedium: TextStyles.body,
        bodySmall: TextStyles.caption,
      );

  /// Overrides default material appbar to provide custom appbar that aligns with the app branding.
  static AppBarTheme get appBarTheme => AppBarTheme(
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          size: 30,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );

  /// This provides a custom dialog that aligns with app branding.
  static DialogTheme get dialogTheme => const DialogTheme();

  /// Theming for alert widget that aligns with the branding of app.
  static SnackBarThemeData get snackBarTheme => const SnackBarThemeData();

  /// Overriden tooltip theme to match to rest of app
  static TooltipThemeData get tooltipTheme => const TooltipThemeData();

  /// Overrides default styles of buttons to provide themed buttons for application.
  static ElevatedButtonThemeData get elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemedColors.light.primary,
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 30),
          textStyle: TextStyles.labelBold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );

  /// Overrides styles of textbutton adding custom theming to it.
  static TextButtonThemeData get textButtonThemeData =>
      TextButtonThemeData();

  /// Enables custom iconbuttons ie this is where buttons such as authbutton will derive their styling from.
  static IconButtonThemeData get iconButtonThemeData =>
      const IconButtonThemeData();

  /// Overrides default styling of drawers in the app.
  static DrawerThemeData get drawerThemeData => const DrawerThemeData();

  /// Overrides default scrollbar to fit theme
  static ScrollbarThemeData get scrollbarThemeData =>
      const ScrollbarThemeData();
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

/// `💡` This applies theming onto [BaseTheme] generating dark and light mode styles or themes
class Theming {
  /// Theming and styling for light mode
  static ThemeData get light => ThemeData(
        /// |-------- Global Styling ----------|
        brightness: Brightness.light,
        visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
        fontFamily: BaseTheme.fontFamily,
        scaffoldBackgroundColor: ThemedColors.light.bg,
        canvasColor: ThemedColors.light.bg,
        scrollbarTheme: BaseTheme.scrollbarThemeData,

        /// |-------- Component Styling ----------|
        textTheme: BaseTheme.textTheme,
        textButtonTheme: BaseTheme.textButtonThemeData,
        elevatedButtonTheme: BaseTheme.elevatedButtonTheme,
        iconButtonTheme: BaseTheme.iconButtonThemeData,
        appBarTheme: BaseTheme.appBarTheme.copyWith(
          foregroundColor: ThemedColors.light.text,
          backgroundColor: ThemedColors.light.bg,
          titleTextStyle:
              TextStyles.heading.copyWith(color: ThemedColors.light.text),
        ),

        drawerTheme: BaseTheme.drawerThemeData,
        snackBarTheme: BaseTheme.snackBarTheme,
        tooltipTheme: BaseTheme.tooltipTheme,
        dialogTheme: BaseTheme.dialogTheme,
      );

  /// Theming and styling for dark mode
  static ThemeData get dark => ThemeData(
        /// |-------- Global Styling ----------|
        brightness: Brightness.dark,
        visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
        fontFamily: BaseTheme.fontFamily,
        scaffoldBackgroundColor: ThemedColors.dark.bg,
        canvasColor: ThemedColors.dark.bg,
        scrollbarTheme: BaseTheme.scrollbarThemeData,

        /// |-------- Component Styling ----------|
        textTheme: BaseTheme.textTheme,
        textButtonTheme: BaseTheme.textButtonThemeData,
        elevatedButtonTheme: BaseTheme.elevatedButtonTheme,
        iconButtonTheme: BaseTheme.iconButtonThemeData,
        appBarTheme: BaseTheme.appBarTheme.copyWith(
          foregroundColor: ThemedColors.dark.text,
          backgroundColor: ThemedColors.dark.bg,
          titleTextStyle:
              TextStyles.heading.copyWith(color: ThemedColors.dark.text),
        ),
        drawerTheme: BaseTheme.drawerThemeData,
        snackBarTheme: BaseTheme.snackBarTheme,
        tooltipTheme: BaseTheme.tooltipTheme,
        dialogTheme: BaseTheme.dialogTheme,
      );
}
