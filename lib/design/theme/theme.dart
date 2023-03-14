import 'package:client/design/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// `💡` This class contains base theme indepedent styles. The styles are used as a basis where the various themes are applied onto it.
class BaseTheme {
  /// Default font family for application.
  static const String fontFamily = "SF Pro Rounded";

  /// Default theme agnostic text theme. This overrides the material styling for text and also introduces custom text themes for app.
  static TextTheme get textTheme => const TextTheme();

  /// Overrides default material appbar to provide custom appbar that aligns with the app branding.
  static AppBarTheme get appBarTheme => AppBarTheme(
        elevation: 0,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );

  /// This provides a custom dialog that aligns with app branding.
  static DialogTheme get dialogTheme => const DialogTheme();

  /// Theming for alert widget that aligns with the branding of app.
  static SnackBarThemeData get snackBarTheme => const SnackBarThemeData();

  /// Overrides default styles of buttons to provide themed buttons for application.
  static ElevatedButtonThemeData get elevatedButtonTheme =>
      const ElevatedButtonThemeData();

  /// Overrides styles of textbutton adding custom theming to it.
  static TextButtonThemeData get textButtonThemeData =>
      const TextButtonThemeData();

  /// Enables custom iconbuttons ie this is where buttons such as authbutton will derive their styling from.
  static IconButtonThemeData get iconButtonThemeData =>
      const IconButtonThemeData();

  /// Overrides default styling of drawers in the app.
  static DrawerThemeData get drawerThemeData => const DrawerThemeData();
}

/// `💡` This applies theming onto [BaseTheme] generating dark and light mode styles or themes
class Theming {
  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        fontFamily: BaseTheme.fontFamily,
        textTheme: BaseTheme.textTheme,
        textButtonTheme: BaseTheme.textButtonThemeData,
        elevatedButtonTheme: BaseTheme.elevatedButtonTheme,
        iconButtonTheme: BaseTheme.iconButtonThemeData,
        appBarTheme: BaseTheme.appBarTheme,
        drawerTheme: BaseTheme.drawerThemeData,
        snackBarTheme: BaseTheme.snackBarTheme,
        dialogTheme: BaseTheme.dialogTheme,
      );
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        fontFamily: BaseTheme.fontFamily,
        textTheme: BaseTheme.textTheme,
        textButtonTheme: BaseTheme.textButtonThemeData,
        elevatedButtonTheme: BaseTheme.elevatedButtonTheme,
        iconButtonTheme: BaseTheme.iconButtonThemeData,
        appBarTheme: BaseTheme.appBarTheme,
        drawerTheme: BaseTheme.drawerThemeData,
        snackBarTheme: BaseTheme.snackBarTheme,
        dialogTheme: BaseTheme.dialogTheme,
      );
}
