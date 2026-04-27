import 'package:get/get.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/edit_transaction_controller.dart';

class EditTransactionBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<EditTransactionController>()) {
      Get.lazyPut(() => EditTransactionController());
    }
  }
}
