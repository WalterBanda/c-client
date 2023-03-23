import 'package:client/design/constants/font.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/text_styles.dart';

/// `💡` This class contains base theme indepedent styles. The styles are used as a basis where the various themes are applied onto it.
class BaseTheme {
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
  static DialogTheme get dialogTheme => DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 0,
      );

  /// Theming for alert widget that aligns with the branding of app.
  static SnackBarThemeData get snackBarTheme => SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        width: 270,
        contentTextStyle: TextStyles.bodySemibold,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      );

  /// Theming for the banner widget
  static MaterialBannerThemeData get bannerTheme =>
      const MaterialBannerThemeData(
        dividerColor: Colors.transparent,
        elevation: 2,
        padding: EdgeInsets.all(10),
      );

  /// Overrides default styling of drawers in the app.
  static DrawerThemeData get drawerThemeData => const DrawerThemeData(
        elevation: 0,
      );
  static ListTileThemeData get listTile => ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        mouseCursor: MaterialStateMouseCursor.clickable,
      );

  /// Overrides default styles of buttons to provide themed buttons for application.
  static ElevatedButtonThemeData get elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemedColors.light.primary,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      );

  /// Overrides styles of textbutton adding custom theming to it.
  static TextButtonThemeData textButtonThemeData({required Color primary}) =>
      TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: primary));

  /// Overrides default scrollbar to fit theme
  static ScrollbarThemeData get scrollbarThemeData =>
      const ScrollbarThemeData(radius: Radius.circular(4));
}

extension CustomTextTheme on TextTheme {
  TextStyle get display => TextStyles.display;

  /// Style used mostly for title of dialogs
  TextStyle get title => TextStyles.title;

  /// Styles used mostly for `screen or page` headings
  TextStyle get heading => TextStyles.heading;
  TextStyle get headingBold => TextStyles.headingBold;

  /// Styles used for labels of form fields
  TextStyle get label => TextStyles.label;
  TextStyle get labelBold => TextStyles.labelBold;

  /// Styles used for headings of sections
  TextStyle get headline => TextStyles.headline;
  TextStyle get headlineBold => TextStyles.headlineBold;

  /// General styles to be used in the body of app.
  TextStyle get body => TextStyles.body;
  TextStyle get bodySemibold => TextStyles.bodySemibold;
  TextStyle get bodyBold => TextStyles.bodyBold;

  /// Used for captions of any emphasis texts.
  TextStyle get caption => TextStyles.caption;
  TextStyle get captionBold => TextStyles.captionBold;
}

/// `💡` This applies theming onto [BaseTheme] generating dark and light mode styles or themes
class Theming {
  /// Theming and styling for light mode
  static ThemeData get light => ThemeData(
        /// |-------- Global Styling ----------|
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          primary: ThemedColors.light.primary,
          secondary: ThemedColors.light.primary,
          error: ThemedColors.light.error,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: FontConstants.fontFamily,
        scaffoldBackgroundColor: ThemedColors.light.bg,
        canvasColor: ThemedColors.light.bg,
        scrollbarTheme: BaseTheme.scrollbarThemeData.copyWith(
            thumbColor: MaterialStateProperty.all(ThemedColors.light.text)),

        /// |-------- Component Styling ----------|
        textTheme: BaseTheme.textTheme,
        textButtonTheme:
            BaseTheme.textButtonThemeData(primary: ThemedColors.light.text),
        elevatedButtonTheme: BaseTheme.elevatedButtonTheme,
        appBarTheme: BaseTheme.appBarTheme.copyWith(
          foregroundColor: ThemedColors.light.text,
          backgroundColor: ThemedColors.light.bg,
          titleTextStyle:
              TextStyles.headingBold.copyWith(color: ThemedColors.light.text),
        ),

        drawerTheme: BaseTheme.drawerThemeData,
        listTileTheme: BaseTheme.listTile,
        snackBarTheme: BaseTheme.snackBarTheme.copyWith(
          closeIconColor: ThemedColors.light.text,
          contentTextStyle:
              TextStyles.bodySemibold.copyWith(color: ThemedColors.light.text),
          backgroundColor: ThemedColors.light.bg,
        ),
        bannerTheme: BaseTheme.bannerTheme.copyWith(
          contentTextStyle:
              TextStyles.bodySemibold.copyWith(color: ThemedColors.light.text),
          backgroundColor: ThemedColors.light.bg,
        ),
        dialogTheme: BaseTheme.dialogTheme.copyWith(
          contentTextStyle:
              TextStyles.headline.copyWith(color: ThemedColors.light.text),
        ),
      );

  /// Theming and styling for dark mode
  static ThemeData get dark => ThemeData(
        /// |-------- Global Styling ----------|
        brightness: Brightness.dark,
        colorScheme: ColorScheme.light(
          brightness: Brightness.dark,
          primary: ThemedColors.dark.primary,
          secondary: ThemedColors.dark.primary,
          error: ThemedColors.dark.error,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: FontConstants.fontFamily,
        scaffoldBackgroundColor: ThemedColors.dark.bg,
        canvasColor: ThemedColors.dark.bg,
        scrollbarTheme: BaseTheme.scrollbarThemeData.copyWith(
            thumbColor: MaterialStateProperty.all(ThemedColors.dark.text)),

        /// |-------- Component Styling ----------|
        textTheme: BaseTheme.textTheme,
        textButtonTheme:
            BaseTheme.textButtonThemeData(primary: ThemedColors.dark.text),
        elevatedButtonTheme: BaseTheme.elevatedButtonTheme,
        appBarTheme: BaseTheme.appBarTheme.copyWith(
          foregroundColor: ThemedColors.dark.text,
          backgroundColor: ThemedColors.dark.bg,
          titleTextStyle:
              TextStyles.headingBold.copyWith(color: ThemedColors.dark.text),
        ),
        drawerTheme: BaseTheme.drawerThemeData,
        listTileTheme: BaseTheme.listTile,
        snackBarTheme: BaseTheme.snackBarTheme.copyWith(
          closeIconColor: ThemedColors.dark.text,
          contentTextStyle:
              TextStyles.bodySemibold.copyWith(color: ThemedColors.dark.text),
          backgroundColor: ThemedColors.dark.bg,
        ),
        bannerTheme: BaseTheme.bannerTheme.copyWith(
          contentTextStyle:
              TextStyles.bodySemibold.copyWith(color: ThemedColors.dark.text),
          backgroundColor: ThemedColors.dark.bg,
        ),
        dialogTheme: BaseTheme.dialogTheme.copyWith(
          contentTextStyle:
              TextStyles.headline.copyWith(color: ThemedColors.dark.text),
        ),
      );
}
