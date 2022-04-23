import 'package:flutter/material.dart';

class AppTheme {
  ThemeData buildLightTheme() {
    return ThemeData(
      fontFamily: "SF Pro Rounded",
      textTheme: const TextTheme(),
    );
  }

  ThemeData buildDarkTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith();
  }
}
