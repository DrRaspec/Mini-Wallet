import 'package:flutter/material.dart';
import 'package:mini_wallet/core/theme/app_colors.dart';
import 'package:mini_wallet/core/theme/app_text.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  AppToast._();

  static void success(String title, String message) {
    _show(
      title: title,
      message: message,
      type: ToastificationType.custom(
        'wallet_success',
        AppColors.income,
        Icons.check_circle_rounded,
      ),
    );
  }

  static void error(String title, String message) {
    _show(
      title: title,
      message: message,
      type: ToastificationType.custom(
        'wallet_error',
        AppColors.expense,
        Icons.error_rounded,
      ),
    );
  }

  static void info(String title, String message) {
    _show(
      title: title,
      message: message,
      type: ToastificationType.custom(
        'wallet_info',
        AppColors.secondary,
        Icons.info_rounded,
      ),
    );
  }

  static void _show({
    required String title,
    required String message,
    required ToastificationType type,
  }) {
    toastification.show(
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 3),
      type: type,
      style: ToastificationStyle.flat,
      title: Text(
        title,
        style: AppText.textTheme.titleMedium?.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
      description: Text(
        message,
        style: AppText.textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      primaryColor: type.color,
      backgroundColor: AppColors.card,
      foregroundColor: AppColors.textPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: AppColors.border),
      boxShadow: [
        BoxShadow(
          color: AppColors.primary.withValues(alpha: 0.10),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ],
      showProgressBar: false,
      closeOnClick: true,
      dragToClose: true,
      pauseOnHover: true,
    );
  }
}
