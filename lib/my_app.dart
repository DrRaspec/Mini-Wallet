import 'package:flutter/material.dart';
import 'package:mini_wallet/core/theme/app_theme.dart';
import 'package:mini_wallet/routes/app_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.routerConfig,
    );
  }
}
