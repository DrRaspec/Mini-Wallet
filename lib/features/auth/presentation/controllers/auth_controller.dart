import 'package:get/get.dart';
import 'package:mini_wallet/core/storage/secure_token_storage.dart';
import 'package:mini_wallet/core/utils/app_logger.dart';
import 'package:mini_wallet/features/auth/domain/entities/auth_result.dart';
import 'package:mini_wallet/features/auth/domain/repositories/auth_repository.dart';

class AuthController extends GetxController {
  AuthController({required this.authRepository, required this.tokenStorage});

  final AuthRepository authRepository;
  final SecureTokenStorage tokenStorage;

  Future<AuthResult> login(String username, String password) async {
    try {
      final res = await authRepository.login(username, password);

      final accessToken = res.accessToken?.trim();
      final refreshToken = res.refreshToken?.trim();

      final hasTokens =
          accessToken != null &&
          accessToken.isNotEmpty &&
          refreshToken != null &&
          refreshToken.isNotEmpty;

      if (!hasTokens) {
        AppLogger.log('Login failed: Missing tokens in response');
        return const AuthResult.failure(
          'Unable to login. Please try again later.',
        );
      }

      await tokenStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      return const AuthResult.success();
    } catch (e, stackTrace) {
      AppLogger.log('Login failed: $e');
      AppLogger.log(stackTrace.toString());

      return const AuthResult.failure(
        'Please check your username and password.',
      );
    }
  }

  Future<AuthResult> register({
    required String username,
    required String password,
  }) async {
    try {
      final res = await authRepository.register(username, password);

      final accessToken = res.accessToken?.trim();
      final refreshToken = res.refreshToken?.trim();

      final hasTokens =
          accessToken != null &&
          accessToken.isNotEmpty &&
          refreshToken != null &&
          refreshToken.isNotEmpty;

      if (!hasTokens) {
        AppLogger.log('Register failed: Missing tokens in response');
        return const AuthResult.failure(
          'Unable to register. Please try again later.',
        );
      }

      await tokenStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      return const AuthResult.success();
    } catch (e, stackTrace) {
      AppLogger.log('Register failed: $e');
      AppLogger.log(stackTrace.toString());

      return const AuthResult.failure(
        'Unable to create account. Please try again.',
      );
    }
  }
}
