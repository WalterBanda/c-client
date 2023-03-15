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
      const ElevatedButtonThemeData();

  /// Overrides styles of textbutton adding custom theming to it.
  static TextButtonThemeData get textButtonThemeData =>
      const TextButtonThemeData();

  /// Enables custom iconbuttons ie this is where buttons such as authbutton will derive their styling from.
  static IconButtonThemeData get iconButtonThemeData =>
      const IconButtonThemeData();

  /// Overrides default styling of drawers in the app.
  static DrawerThemeData get drawerThemeData => const DrawerThemeData();

  /// Overrides default scrollbar to fit theme
  static ScrollbarThemeData get scrollbarThemeData =>
      const ScrollbarThemeData();
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
        appBarTheme: BaseTheme.appBarTheme
            .copyWith(backgroundColor: ThemedColors.dark.emphasis),

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
        appBarTheme: BaseTheme.appBarTheme
            .copyWith(backgroundColor: ThemedColors.light.emphasis),
        drawerTheme: BaseTheme.drawerThemeData,
        snackBarTheme: BaseTheme.snackBarTheme,
        tooltipTheme: BaseTheme.tooltipTheme,
        dialogTheme: BaseTheme.dialogTheme,
      );
}
