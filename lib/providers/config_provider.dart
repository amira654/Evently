import 'package:flutter/material.dart';

class ConfigProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLang = "en";

  bool get isDark => currentTheme == ThemeMode.dark;

  bool get isEnglish => currentLang == "en";

  void changeAppTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }

  void changeAppLang(String newLang) {
    if (currentLang == newLang) return;
    currentLang = newLang;
    notifyListeners();
  }
}
