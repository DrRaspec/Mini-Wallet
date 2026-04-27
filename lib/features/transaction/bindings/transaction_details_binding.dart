import 'package:get/get.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/transaction_details_controller.dart';

class TransactionDetailsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<TransactionDetailsController>()) {
      Get.lazyPut(() => TransactionDetailsController());
    }
  }
}
