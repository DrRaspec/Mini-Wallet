import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
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
    selectedTransaction.value = transaction;
    super.onInit();
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

    isDeleting.value = true;
    await repository.delete(transaction.id);
    isDeleting.value = false;
    if (context.mounted) {
      context.pop(true);
    }
  }
}
