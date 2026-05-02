import 'package:get/get.dart';
import 'package:mini_wallet/features/shell/presentation/controllers/app_shell_controller.dart';

class AppShellBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AppShellController>()) {
      Get.lazyPut(() => AppShellController());
    }
  }
}
