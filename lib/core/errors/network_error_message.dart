import 'package:dio/dio.dart';

class NetworkErrorMessage {
  static String fromDio(DioException error, {required String fallback}) {
    final isTimeout =
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout;

    if (isTimeout) {
      return 'Request timed out. Please check your connection and try again.';
    }

    if (error.type == DioExceptionType.connectionError) {
      return 'Unable to connect. Please check your internet connection.';
    }

    return fallback;
  }
}
