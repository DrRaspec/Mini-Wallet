import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_wallet/core/utils/app_logger.dart';
import 'package:mini_wallet/core/widgets/app_toast.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:mini_wallet/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:mini_wallet/routes/route_paths.dart';

class TransactionDetailsController extends GetxController {
  TransactionDetailsController({
    required this.transaction,
    required this.repository,
  });

  final TransactionRepository repository;
  final TransactionModel transaction;
  final selectedTransaction = Rx<TransactionModel?>(null);

  final isDeleting = false.obs;

  @override
  void onInit() {
    super.onInit();
    selectedTransaction.value = transaction;
  }

  Future<void> onEdit(BuildContext context) async {
    final updatedTransaction = await context.push<TransactionModel>(
      RoutePaths.editTransaction,
      extra: selectedTransaction.value,
    );
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
        context.pop(true);
      }
    } catch (e) {
      AppLogger.log('Error deleting transaction: $e');
      AppToast.error('Error', 'Unable to delete transaction right now.');
    } finally {
      isDeleting.value = false;
    }
  }
}
