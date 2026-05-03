import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/bindings/app_binding.dart';
import 'package:mini_wallet/core/theme/app_theme.dart';
import 'package:mini_wallet/routes/app_pages.dart';
import 'package:mini_wallet/routes/app_routes.dart';
import 'package:toastification/toastification.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialBinding: AppBinding(),
        initialRoute: AppRoutes.home,
        getPages: AppPages.pages,
      ),
    );
  }
}
