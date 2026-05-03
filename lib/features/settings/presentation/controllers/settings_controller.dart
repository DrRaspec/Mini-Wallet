import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/controllers/app_settings_controller.dart';

class SettingsController extends GetxController {
  final AppSettingsController appSettingsController;

  SettingsController({required this.appSettingsController});

  Rx<ThemeMode> get appTheme => appSettingsController.themeMode;
  Rx<Locale> get appLocale => appSettingsController.locale;

  void onThemeChange(ThemeMode newTheme) {
    appSettingsController.changeThemeMode(newTheme);
  }

  void onLanguageChange(Locale newLocale) {
    appSettingsController.changeLanguage(newLocale);
  }
}
