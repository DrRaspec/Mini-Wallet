import 'package:get/get.dart';
import 'package:mini_wallet/core/network/api_client.dart';
import 'package:mini_wallet/features/transaction/data/datasources/transaction_remote_ds.dart';
import 'package:mini_wallet/features/transaction/data/repositories_impl/transaction_repository_impl.dart';
import 'package:mini_wallet/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:mini_wallet/features/transaction/presentation/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionRemoteDataSource>(
      () => TransactionRemoteDataSource(Get.find<ApiClient>()),
      fenix: true,
    );

    Get.lazyPut<TransactionRepository>(
      () => TransactionRepositoryImpl(
        remote: Get.find<TransactionRemoteDataSource>(),
      ),
      fenix: true,
    );

    Get.lazyPut<HomeController>(
      () => HomeController(repository: Get.find<TransactionRepository>()),
    );
  }
}
