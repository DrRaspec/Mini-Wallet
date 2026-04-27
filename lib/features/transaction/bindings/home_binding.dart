import 'package:get/instance_manager.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<HomeController>()) {
      Get.lazyPut(() => HomeController());
    }
  }
}
