import 'package:get/get.dart';
import 'package:mini_wallet/core/network/api_client.dart';
import 'package:mini_wallet/core/storage/secure_token_storage.dart';
import 'package:mini_wallet/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:mini_wallet/features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:mini_wallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:mini_wallet/features/auth/presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthRemoteDs>()) {
      Get.lazyPut<AuthRemoteDs>(
        () => AuthRemoteDs(Get.find<ApiClient>()),
        fenix: true,
      );
    }

    if (!Get.isRegistered<AuthRepository>()) {
      Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(remote: Get.find<AuthRemoteDs>()),
        fenix: true,
      );
    }

    if (!Get.isRegistered<AuthController>()) {
      Get.lazyPut<AuthController>(
        () => AuthController(
          authRepository: Get.find<AuthRepository>(),
          tokenStorage: Get.find<SecureTokenStorage>(),
        ),
        fenix: true,
      );
    }
  }
}
