import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/errors/network_error_message.dart';
import 'package:mini_wallet/core/utils/app_logger.dart';
import 'package:mini_wallet/core/widgets/app_toast.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:mini_wallet/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:mini_wallet/routes/app_routes.dart';

class TransactionDetailsController extends GetxController {
  TransactionDetailsController({required this.repository});

  final TransactionRepository repository;
  final selectedTransaction = Rx<TransactionModel?>(null);

  final isDeleting = false.obs;

  @override
  void onInit() {
    super.onInit();
    selectedTransaction.value = Get.arguments as TransactionModel?;
  }

  Future<void> onEdit(BuildContext context) async {
    final updatedTransaction =
        Get.toNamed(
              AppRoutes.editTransaction,
              arguments: selectedTransaction.value,
            )
            as TransactionModel?;
    if (updatedTransaction != null) {
      selectedTransaction.value = updatedTransaction;
    }
  }

  void onDeleteTransaction(BuildContext context) async {
    final transaction = selectedTransaction.value;
    if (transaction == null) return;

    try {
      isDeleting.value = true;
      await repository.delete(transaction.id);
      AppToast.success('Deleted', 'Transaction deleted successfully.');
      if (context.mounted) {
        Get.back(result: true);
      }
    } on DioException catch (e) {
      final message = NetworkErrorMessage.fromDio(
        e,
        fallback: 'Unable to delete transaction right now.',
      );
      AppLogger.log('Error deleting transaction: $e');
      AppToast.error('Error', message);
    } catch (e) {
      AppLogger.log('Error deleting transaction: $e');
      AppToast.error('Error', 'Unable to delete transaction right now.');
    } finally {
      isDeleting.value = false;
    }
  }
}
