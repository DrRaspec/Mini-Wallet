import 'package:get/get.dart';
import 'package:mini_wallet/core/services/database_service.dart';
import 'package:mini_wallet/features/transaction/data/datasources/transaction_local_ds.dart';
import 'package:mini_wallet/features/transaction/data/repositories_impl/transaction_repository_impl.dart';
import 'package:mini_wallet/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<DatabaseService>()) {
      Get.lazyPut(() => DatabaseService());
    }

    if (!Get.isRegistered<TransactionLocalDataSource>()) {
      Get.lazyPut(() => TransactionLocalDataSource(Get.find()));
    }

    if (!Get.isRegistered<TransactionRepository>()) {
      Get.lazyPut<TransactionRepository>(
        () => TransactionRepositoryImpl(
          local: Get.find<TransactionLocalDataSource>(),
        ),
      );
    }
  }
}
