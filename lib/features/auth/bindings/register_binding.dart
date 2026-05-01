import 'package:get/get.dart';
import 'package:mini_wallet/features/auth/bindings/auth_binding.dart';
import 'package:mini_wallet/features/auth/presentation/controllers/auth_controller.dart';
import 'package:mini_wallet/features/auth/presentation/controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();

    Get.lazyPut<RegisterController>(
      () => RegisterController(authController: Get.find<AuthController>()),
    );
  }
}
