import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/controllers/app_settings_controller.dart';
import 'package:mini_wallet/core/utils/app_logger.dart';
import 'package:mini_wallet/features/auth/presentation/controllers/auth_controller.dart';
import 'package:mini_wallet/routes/app_routes.dart';

class SettingsController extends GetxController {
  final AppSettingsController appSettingsController;
  final AuthController authController;

  SettingsController({
    required this.appSettingsController,
    required this.authController,
  });

  final isLogoutInProgress = false.obs;

  Rx<ThemeMode> get appTheme => appSettingsController.themeMode;
  Rx<Locale> get appLocale => appSettingsController.locale;

  void onThemeChange(ThemeMode newTheme) {
    appSettingsController.changeThemeMode(newTheme);
  }

  void onLanguageChange(Locale newLocale) {
    appSettingsController.changeLanguage(newLocale);
  }

  void signOut() {
    try {
      isLogoutInProgress.value = true;
      authController.logout();
      appSettingsController.clearAppSetting();
      AppLogger.log('User signed out');
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      AppLogger.log('Error during sign out: $e');
    } finally {
      isLogoutInProgress.value = false;
    }
  }
}
