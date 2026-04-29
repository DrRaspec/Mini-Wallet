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

  final isDeleting = false.obs;

  void onEdit(BuildContext context) {
    context.push(RoutePaths.editTransaction, extra: transaction);
  }

  void onDeleteTransaction(BuildContext context) async {
    isDeleting.value = true;
    await repository.delete(transaction.id);
    isDeleting.value = false;
    if (context.mounted) {
      context.pop(true);
    }
  }
}
