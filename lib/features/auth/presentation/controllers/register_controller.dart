import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/widgets/app_toast.dart';
import 'package:mini_wallet/features/auth/presentation/controllers/auth_controller.dart';

class RegisterController extends GetxController {
  RegisterController({required this.authController});

  final AuthController authController;

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;

  Future<bool> submitRegister() async {
    if (!(formKey.currentState?.validate() ?? false)) return false;

    if (passwordController.text != confirmPasswordController.text) {
      AppToast.error('Register Failed', 'Passwords do not match.');
      return false;
    }

    isLoading.value = true;

    try {
      final result = await authController.register(
        username: usernameController.text.trim(),
        password: passwordController.text,
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

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
