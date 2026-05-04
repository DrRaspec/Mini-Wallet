import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/controllers/app_settings_controller.dart';
import 'package:mini_wallet/core/network/api_client.dart';
import 'package:mini_wallet/core/services/storage_service.dart';
import 'package:mini_wallet/core/storage/local_storage.dart';
import 'package:mini_wallet/core/storage/secure_token_storage.dart';
import 'package:mini_wallet/core/storage/theme_storage.dart';
import 'package:mini_wallet/features/auth/bindings/auth_binding.dart';
import 'package:mini_wallet/features/transaction/bindings/transaction_binding.dart';
import 'package:mini_wallet/routes/app_routes.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => const FlutterSecureStorage(), fenix: true);
    Get.lazyPut(
      () => SecureTokenStorage(Get.find<FlutterSecureStorage>()),
      fenix: true,
    );

    Get.lazyPut(
      () => ApiClient(
        Get.find<SecureTokenStorage>(),
        onUnauthorized: () {
          Get.offAllNamed(AppRoutes.login);
        },
      ),
      fenix: true,
    );

    Get.lazyPut(() => StorageService(), fenix: true);

    Get.lazyPut(() => ThemeStorage(Get.find<StorageService>()), fenix: true);
    Get.lazyPut(() => LocaleStorage(Get.find<StorageService>()), fenix: true);

    Get.put(
      AppSettingsController(
        themeStorage: Get.find<ThemeStorage>(),
        localeStorage: Get.find<LocaleStorage>(),
      ),
      permanent: true,
    );

    AuthBinding().dependencies();

    TransactionBinding().dependencies();
  }
}
