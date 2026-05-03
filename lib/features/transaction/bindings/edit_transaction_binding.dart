import 'package:get/get.dart';
import 'package:mini_wallet/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/edit_transaction_controller.dart';

class EditTransactionBinding extends Bindings {
  @override
  void dependencies() {
    final controller = EditTransactionController(
      repository: Get.find<TransactionRepository>(),
    );

    if (Get.isRegistered<EditTransactionController>()) {
      Get.replace<EditTransactionController>(controller);
    } else {
      Get.put<EditTransactionController>(controller);
    }
  }
}
