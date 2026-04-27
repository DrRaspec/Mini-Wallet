import 'package:get/get.dart';
import 'package:mini_wallet/features/transaction_details/presentation/controllers/transaction_details_controller.dart';

class TransactionDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionDetailsController());
  }
}
