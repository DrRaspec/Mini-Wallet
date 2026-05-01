import 'package:get/get.dart';
import 'package:mini_wallet/features/auth/bindings/auth_binding.dart';
import 'package:mini_wallet/features/auth/presentation/controllers/auth_controller.dart';
import 'package:mini_wallet/features/auth/presentation/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();

    Get.lazyPut<LoginController>(
      () => LoginController(authController: Get.find<AuthController>()),
    );
  }
}
