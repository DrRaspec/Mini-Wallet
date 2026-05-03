import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSettingsController extends GetxController {
  final locale = const Locale('en', 'US').obs;
  final themeMode = ThemeMode.light.obs;

  void changeLanguage(Locale newLocale) {
    locale.value = newLocale;
    Get.updateLocale(newLocale);
  }

  void changeThemeMode(ThemeMode newThemeMode) {
    themeMode.value = newThemeMode;
    Get.changeThemeMode(newThemeMode);
  }

  void toggleTheme() {
    final nextMode = themeMode.value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    changeThemeMode(nextMode);
  }
}
