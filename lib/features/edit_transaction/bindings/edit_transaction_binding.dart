import 'package:get/get.dart';
import 'package:mini_wallet/features/edit_transaction/presentation/controllers/edit_transaction_controller.dart';

class EditTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditTransactionController());
  }
}
