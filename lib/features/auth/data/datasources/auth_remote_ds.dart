import 'package:dio/dio.dart';
import 'package:mini_wallet/core/constants/api_endpoints.dart';
import 'package:mini_wallet/core/network/api_client.dart';
import 'package:mini_wallet/core/utils/app_logger.dart';
import 'package:mini_wallet/features/auth/data/models/auth_response_model.dart';

class AuthRemoteDs {
  AuthRemoteDs(this.apiClient);

  final ApiClient apiClient;

  Future<AuthResponseModel> login(String username, String password) async {
    try {
      final res = await apiClient.dio.post(
        ApiEndpoints.login,
        data: {'username': username, 'password': password},
      );

      return AuthResponseModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      AppLogger.log('Error during login: ${e.message}');
      rethrow;
    }
  }

  Future<AuthResponseModel> register(String username, String password) async {
    try {
      final res = await apiClient.dio.post(
        ApiEndpoints.register,
        data: {'username': username, 'password': password},
      );

      return AuthResponseModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      AppLogger.log('Error during registration: ${e.message}');
      rethrow;
    }
  }

  Future<AuthResponseModel> refreshToken(String refreshToken) async {
    try {
      final res = await apiClient.dio.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      return AuthResponseModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      AppLogger.log('Error during token refresh: ${e.message}');
      rethrow;
    }
  }
}
