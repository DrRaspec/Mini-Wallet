import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/errors/network_error_message.dart';
import 'package:mini_wallet/core/utils/app_logger.dart';
import 'package:mini_wallet/core/widgets/app_toast.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:mini_wallet/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/home_controller.dart';
import 'package:uuid/uuid.dart';

class AddTransactionController extends GetxController {
  final TransactionRepository repository;

  AddTransactionController({required this.repository});

  final addTransactionFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final isIncome = false.obs;

  final isLoading = false.obs;
  final transaction = Rx<TransactionModel?>(null);

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount';
    }
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Please enter a valid amount';
    }
    return null;
  }

  Future<bool> addTransaction() async {
    try {
      isLoading.value = true;
      if (transaction.value == null) return false;
      await repository.add(transaction.value!);
      if (Get.isRegistered<HomeController>()) {
        await Get.find<HomeController>().fetchTransactions();
        await Get.find<HomeController>().fetchTotalBalance();
      }
      AppToast.success('Saved', 'Transaction added successfully.');
      AppLogger.log('Transaction added successfully: ${transaction.value}');
      return true;
    } on DioException catch (e) {
      final message = NetworkErrorMessage.fromDio(
        e,
        fallback: 'Unable to add transaction right now.',
      );
      AppLogger.log('Error occurred while adding transaction: $e');
      AppToast.error('Error', message);
      return false;
    } catch (e) {
      AppLogger.log('Error occurred while adding transaction: $e');
      AppToast.error('Error', 'Unable to add transaction right now.');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> onAddTransaction() async {
    if (!(addTransactionFormKey.currentState?.validate() ?? false)) {
      return false;
    }

    final newTransaction = TransactionModel(
      id: const Uuid().v4(),
      title: titleController.text.trim(),
      amount: double.parse(amountController.text),
      isIncome: isIncome.value,
      date: DateTime.now(),
    );
    transaction.value = newTransaction;

    final didSave = await addTransaction();
    if (didSave) {
      titleController.clear();
      amountController.clear();
      isIncome.value = false;
      transaction.value = null;
    }
    return didSave;
  }

  @override
  void onClose() {
    titleController.dispose();
    amountController.dispose();
    super.onClose();
  }
}
