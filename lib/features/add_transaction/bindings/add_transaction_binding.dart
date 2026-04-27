import 'package:get/get.dart';
import 'package:mini_wallet/features/add_transaction/presentation/controllers/add_transaction_controller.dart';

class AddTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTransactionController());
  }
}
