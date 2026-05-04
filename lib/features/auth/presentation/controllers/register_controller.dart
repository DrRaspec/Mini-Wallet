import 'package:get/get.dart';
import 'package:mini_wallet/core/widgets/app_toast.dart';
import 'package:mini_wallet/features/auth/presentation/controllers/auth_controller.dart';

class RegisterController extends GetxController {
  RegisterController({required this.authController});

  final AuthController authController;

  final passwordVisible = false.obs;
  final confirmPasswordVisible = false.obs;

  final isLoading = false.obs;

  Future<bool> submitRegister({
    required String username,
    required String password,
  }) async {
    isLoading.value = true;

    try {
      final result = await authController.register(
        username: username,
        password: password,
      );

      if (!result.isSuccess) {
        AppToast.error(
          'Register Failed',
          result.message ?? 'Unable to register.',
        );
        return false;
      }

      return true;
    } finally {
      isLoading.value = false;
    }
  }
}
