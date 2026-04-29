import 'package:dio/dio.dart';
import 'package:mini_wallet/core/config/app_env.dart';
import 'package:mini_wallet/core/storage/secure_token_storage.dart';

class ApiClient {
  ApiClient(this._tokenStorage) {
    dio = Dio(
      BaseOptions(
        baseUrl: AppEnv.apiUrl,
        connectTimeout: Duration(seconds: AppEnv.apiTimeoutSeconds),
        receiveTimeout: Duration(seconds: AppEnv.apiTimeoutSeconds),
        sendTimeout: Duration(seconds: AppEnv.apiTimeoutSeconds),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStorage.getAccessToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _tokenStorage.deleteTokens();
          }

          handler.next(error);
        },
      ),
    );
  }

  final SecureTokenStorage _tokenStorage;

  late final Dio dio;
}
