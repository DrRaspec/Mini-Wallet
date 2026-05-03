import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/controllers/app_settings_controller.dart';
import 'package:mini_wallet/core/storage/local_storage.dart';
import 'package:mini_wallet/core/theme/app_theme.dart';
import 'package:mini_wallet/core/translations/app_translations.dart';
import 'package:mini_wallet/routes/app_pages.dart';
import 'package:mini_wallet/routes/app_routes.dart';
import 'package:toastification/toastification.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Get.find<AppSettingsController>();

    return ToastificationWrapper(
      child: Obx(
        () => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: settings.themeMode.value,
          translations: AppTranslations(),
          locale: settings.locale.value,
          fallbackLocale: LocaleStorage.fallbackLocale,
          initialRoute: AppRoutes.home,
          getPages: AppPages.pages,
        ),
      ),
    );
  }
}
