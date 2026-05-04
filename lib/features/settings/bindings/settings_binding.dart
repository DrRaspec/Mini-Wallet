import 'package:get/get.dart';
import 'package:mini_wallet/core/controllers/app_settings_controller.dart';
import 'package:mini_wallet/features/auth/presentation/controllers/auth_controller.dart';
import 'package:mini_wallet/features/settings/presentation/controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SettingsController(
        appSettingsController: Get.find<AppSettingsController>(),
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
