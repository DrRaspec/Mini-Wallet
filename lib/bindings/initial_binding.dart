import 'package:get/get.dart';
import 'package:mini_wallet/features/shell/bindings/app_shell_binding.dart';
import 'package:mini_wallet/features/transaction/bindings/transaction_binding.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    AppShellBinding().dependencies();
    TransactionBinding().dependencies();
  }
}
