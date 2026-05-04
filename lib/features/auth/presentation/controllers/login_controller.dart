import 'package:get/get.dart';
import 'package:mini_wallet/core/widgets/app_toast.dart';
import 'package:mini_wallet/features/auth/presentation/controllers/auth_controller.dart';

class LoginController extends GetxController {
  LoginController({required this.authController});

  final AuthController authController;

  final isPasswordVisible = false.obs;

  final isLoading = false.obs;

  Future<bool> submitLogin(String username, String password) async {
    isLoading.value = true;

    try {
      final result = await authController.login(username, password);

      if (!result.isSuccess) {
        AppToast.error('Login Failed', result.message ?? 'Unable to login.');
        return false;
      }

      return true;
    } finally {
      isLoading.value = false;
    }
  }
}
