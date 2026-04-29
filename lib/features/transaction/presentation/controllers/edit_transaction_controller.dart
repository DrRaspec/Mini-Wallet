import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/utils/app_logger.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:mini_wallet/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/home_controller.dart';

class EditTransactionController extends GetxController {
  EditTransactionController({
    required this.repository,
    required this.initialTransaction,
  });

  final TransactionRepository repository;
  final TransactionModel? initialTransaction;

  final editTransactionFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final isIncome = false.obs;
  final isLoading = false.obs;
  final transaction = Rx<TransactionModel?>(null);

  @override
  void onInit() {
    transaction.value = initialTransaction;
    final selectedTransaction = initialTransaction;
    if (selectedTransaction != null) {
      titleController.text = selectedTransaction.title;
      amountController.text = selectedTransaction.amount.toStringAsFixed(2);
      isIncome.value = selectedTransaction.isIncome;
    }
    super.onInit();
  }

  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an amount';
    }
    final amount = double.tryParse(value.trim());
    if (amount == null || amount <= 0) {
      return 'Please enter a valid amount';
    }
    return null;
  }

  Future<TransactionModel?> onUpdateTransaction() async {
    if (!(editTransactionFormKey.currentState?.validate() ?? false)) {
      return null;
    }

    final selectedTransaction = transaction.value;
    if (selectedTransaction == null) {
      Get.snackbar(
        'No transaction',
        'Open a transaction detail before editing.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }

    final updatedTransaction = selectedTransaction.copyWith(
      title: titleController.text.trim(),
      amount: double.parse(amountController.text.trim()),
      isIncome: isIncome.value,
    );

    try {
      isLoading.value = true;
      await repository.update(updatedTransaction);
      transaction.value = updatedTransaction;
      if (Get.isRegistered<HomeController>()) {
        await Get.find<HomeController>().refreshHome();
      }
      Get.snackbar(
        'Updated',
        'Transaction updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return updatedTransaction;
    } catch (e) {
      AppLogger.log('Error updating transaction: $e');
      Get.snackbar(
        'Error',
        'Unable to update transaction right now.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    amountController.dispose();
    super.onClose();
  }
}
