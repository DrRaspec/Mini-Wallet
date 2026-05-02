import 'package:dio/dio.dart';
import 'package:mini_wallet/core/config/app_env.dart';
import 'package:mini_wallet/core/constants/api_endpoints.dart';
import 'package:mini_wallet/core/storage/secure_token_storage.dart';

class ApiClient {
  ApiClient(this._tokenStorage, {this.onUnauthorized}) {
    dio = Dio(_baseOptions);

    _refreshDio = Dio(_baseOptions);

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
          final statusCode = error.response?.statusCode;
          final requestPath = error.requestOptions.path;

          final isAuthRequest =
              requestPath == ApiEndpoints.login ||
              requestPath == ApiEndpoints.register ||
              requestPath == ApiEndpoints.refreshToken;

          if (isAuthRequest || statusCode != 401) {
            handler.next(error);
            return;
          }

          final didRefresh = await _refreshToken();

          if (!didRefresh) {
            await _handleUnauthorized();
            handler.next(error);
            return;
          }

          try {
            final newAccessToken = await _tokenStorage.getAccessToken();

            final retryOptions = error.requestOptions;
            retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';

            final response = await dio.fetch<dynamic>(retryOptions);
            handler.resolve(response);
          } on DioException catch (retryError) {
            handler.next(retryError);
          }
        },
      ),
    );
  }

  final SecureTokenStorage _tokenStorage;
  final void Function()? onUnauthorized;

  late final Dio dio;
  late final Dio _refreshDio;

  Future<bool>? _refreshRequest;

  BaseOptions get _baseOptions {
    return BaseOptions(
      baseUrl: AppEnv.apiUrl,
      connectTimeout: Duration(seconds: AppEnv.apiTimeoutSeconds),
      receiveTimeout: Duration(seconds: AppEnv.apiTimeoutSeconds),
      sendTimeout: Duration(seconds: AppEnv.apiTimeoutSeconds),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
  }

  Future<bool> _refreshToken() {
    _refreshRequest ??= _refreshTokenInternal();

    return _refreshRequest!.whenComplete(() {
      _refreshRequest = null;
    });
  }

  Future<bool> _refreshTokenInternal() async {
    final refreshToken = await _tokenStorage.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    try {
      final res = await _refreshDio.post<Map<String, dynamic>>(
        ApiEndpoints.refreshToken,
        data: {'refresh_token': refreshToken},
      );

      final data = res.data;

      if (data == null) return false;

      final newAccessToken = data['accessToken'] as String?;
      final newRefreshToken = data['refreshToken'] as String?;

      if (newAccessToken == null ||
          newAccessToken.trim().isEmpty ||
          newRefreshToken == null ||
          newRefreshToken.trim().isEmpty) {
        return false;
      }

      await _tokenStorage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      return true;
    } on DioException {
      return false;
    }
  }

  Future<void> _handleUnauthorized() async {
    await _tokenStorage.deleteTokens();
    onUnauthorized?.call();
  }
}
