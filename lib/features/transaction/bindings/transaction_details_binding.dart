import 'package:get/get.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:mini_wallet/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/transaction_details_controller.dart';

class TransactionDetailsBinding extends Bindings {
  TransactionDetailsBinding({required this.transaction});

  final TransactionModel transaction;

  @override
  void dependencies() {
    final controller = TransactionDetailsController(
      transaction: transaction,
      repository: Get.find<TransactionRepository>(),
    );

    if (Get.isRegistered<TransactionDetailsController>()) {
      Get.replace<TransactionDetailsController>(controller);
    } else {
      Get.put<TransactionDetailsController>(controller);
    }
  }
}
