import 'package:dio/dio.dart';
import 'package:mini_wallet/core/constants/api_endpoints.dart';
import 'package:mini_wallet/core/network/api_client.dart';
import 'package:mini_wallet/features/auth/data/models/auth_response_model.dart';

class AuthRemoteDs {
  AuthRemoteDs(this.apiClient);

  final ApiClient apiClient;

  Future<AuthResponseModel> login(String username, String password) async {
    final res = await apiClient.dio.post(
      ApiEndpoints.login,
      data: {'username': username, 'password': password},
    );

    return _parseAuthResponse(res);
  }

  Future<AuthResponseModel> register(String username, String password) async {
    final res = await apiClient.dio.post(
      ApiEndpoints.register,
      data: {'username': username, 'password': password},
    );

    return _parseAuthResponse(res);
  }

  Future<AuthResponseModel> refreshToken(String refreshToken) async {
    final res = await apiClient.dio.post(
      ApiEndpoints.refreshToken,
      data: {'refreshToken': refreshToken},
    );

    return _parseAuthResponse(res);
  }

  AuthResponseModel _parseAuthResponse(Response<dynamic> response) {
    final data = response.data;

    if (data is! Map<String, dynamic>) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error: 'Invalid auth response from server',
      );
    }

    return AuthResponseModel.fromJson(data);
  }
}
