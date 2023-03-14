import 'package:client/design/styles/colors.dart';
import 'package:flutter/material.dart';

mixin BaseTheme {
  final String fontFamily = "SF Pro Rounded";
  TextTheme textTheme({required ThemeMode mode}) => const TextTheme();
  AppBarTheme appBarTheme({required Color bg}) => AppBarTheme(
      backgroundColor: bg,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
  DialogTheme dialogTheme({required ThemeMode mode}) => const DialogTheme();

  SnackBarThemeData snackBarTheme({required ThemeMode mode}) =>
      const SnackBarThemeData();

  ElevatedButtonThemeData elevatedButtonTheme({required ThemeMode mode}) =>
      const ElevatedButtonThemeData();
  TextButtonThemeData textButtonThemeData({required ThemeMode mode}) =>
      const TextButtonThemeData();
  IconButtonThemeData iconButtonThemeData({required ThemeMode mode}) =>
      const IconButtonThemeData();
  DrawerThemeData drawerThemeData({required ThemeMode mode}) =>
      const DrawerThemeData();
}

class AppTheme with BaseTheme {
  static final AppTheme _singleton = AppTheme._internal();

  /// This singleton class holds themedata helpers for dark and light mode, also responsible for styling.
  factory AppTheme() {
    return _singleton;
  }

  AppTheme._internal();

  ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: ColorsScheme.light.primary,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: ColorsScheme.light.bg,
      appBarTheme: appBarTheme(bg: ColorsScheme.light.bg),
      textTheme: textTheme(mode: ThemeMode.light),
      dialogBackgroundColor: ColorsScheme.light.bg,
      dialogTheme: dialogTheme(mode: ThemeMode.light),
      snackBarTheme: snackBarTheme(mode: ThemeMode.light),
      elevatedButtonTheme: elevatedButtonTheme(mode: ThemeMode.light),
      textButtonTheme: textButtonThemeData(mode: ThemeMode.light),
      iconButtonTheme: iconButtonThemeData(mode: ThemeMode.light),
      drawerTheme: drawerThemeData(mode: ThemeMode.light),
    );
  }

  ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: fontFamily,
      primaryColor: ColorsScheme.dark.primary,
      scaffoldBackgroundColor: ColorsScheme.dark.bg,
      appBarTheme: appBarTheme(bg: ColorsScheme.dark.bg),
      textTheme: textTheme(mode: ThemeMode.dark),
      dialogBackgroundColor: ColorsScheme.dark.bg,
      dialogTheme: dialogTheme(mode: ThemeMode.dark),
      snackBarTheme: snackBarTheme(mode: ThemeMode.dark),
      elevatedButtonTheme: elevatedButtonTheme(mode: ThemeMode.dark),
      textButtonTheme: textButtonThemeData(mode: ThemeMode.dark),
      iconButtonTheme: iconButtonThemeData(mode: ThemeMode.dark),
      drawerTheme: drawerThemeData(mode: ThemeMode.dark),
    );
  }
}
