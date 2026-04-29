import 'package:get/get.dart';
import 'package:mini_wallet/core/network/api_client.dart';
import 'package:mini_wallet/features/transaction/data/datasources/transaction_remote_ds.dart';
import 'package:mini_wallet/features/transaction/data/repositories_impl/transaction_repository_impl.dart';
import 'package:mini_wallet/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<TransactionRemoteDataSource>()) {
      Get.lazyPut(() => TransactionRemoteDataSource(Get.find<ApiClient>()));
    }

    if (!Get.isRegistered<TransactionRepository>()) {
      Get.lazyPut<TransactionRepository>(
        () => TransactionRepositoryImpl(
          remote: Get.find<TransactionRemoteDataSource>(),
        ),
      );
    }
  }
}
