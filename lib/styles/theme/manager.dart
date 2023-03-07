import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  changeTheme(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }
}
