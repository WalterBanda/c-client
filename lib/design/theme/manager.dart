import 'package:flutter/material.dart';

/// Responsible for switching between the various themes and theme modes in the application
class ThemeManager extends ChangeNotifier {
  /// This is responsible for switching between the various themes modes, has a default of [ThemeMode.system]
  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  /// This fn changes the theme across the application
  changeTheme(ThemeMode thememode) {
    _mode = thememode;
    notifyListeners();
  }
}
