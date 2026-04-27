import 'package:get/get.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/add_transaction_controller.dart';

class AddTransactionBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AddTransactionController>()) {
      Get.lazyPut(() => AddTransactionController());
    }
  }
}
