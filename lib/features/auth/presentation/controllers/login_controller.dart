import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/widgets/app_toast.dart';
import 'package:mini_wallet/features/auth/presentation/controllers/auth_controller.dart';

class LoginController extends GetxController {
  LoginController({required this.authController});

  final AuthController authController;

  final loginFormKey = GlobalKey<FormState>();
  final lUsernameController = TextEditingController();
  final rPasswordController = TextEditingController();

  final isLoading = false.obs;

  Future<bool> submitLogin() async {
    if (!(loginFormKey.currentState?.validate() ?? false)) return false;

    isLoading.value = true;

    try {
      final result = await authController.login(
        lUsernameController.text.trim(),
        rPasswordController.text,
      );

      if (!result.isSuccess) {
        AppToast.error('Login Failed', result.message ?? 'Unable to login.');
        return false;
      }

      return true;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    lUsernameController.dispose();
    rPasswordController.dispose();
    super.onClose();
  }
}
