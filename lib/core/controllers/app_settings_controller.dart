import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/storage/local_storage.dart';
import 'package:mini_wallet/core/storage/theme_storage.dart';

class AppSettingsController extends GetxController {
  final ThemeStorage themeStorage;
  final LocaleStorage localeStorage;

  AppSettingsController({
    required this.themeStorage,
    required this.localeStorage,
  });

  final locale = LocaleStorage.fallbackLocale.obs;
  final themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();

    final storedThemeMode = themeStorage.get();
    final storedLocale = localeStorage.get();

    themeMode.value = storedThemeMode;
    locale.value = storedLocale;
  }

  void changeLanguage(Locale newLocale) {
    locale.value = newLocale;
    localeStorage.save(newLocale);
    Get.updateLocale(newLocale);
  }

  void changeThemeMode(ThemeMode newThemeMode) {
    themeMode.value = newThemeMode;
    themeStorage.save(newThemeMode);
    Get.changeThemeMode(newThemeMode);
  }

  void toggleTheme() {
    final nextMode = themeMode.value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    changeThemeMode(nextMode);
  }
}
