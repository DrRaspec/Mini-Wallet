import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  AppEnv._();

  static String get appFlavor {
    return dotenv.env['APP_FLAVOR'] ?? 'dev';
  }

  static String get apiBaseUrl {
    return dotenv.env['API_BASE_URL'] ?? 'https://api.example.com';
  }

  static String get apiPrefix {
    return dotenv.env['API_PREFIX'] ?? 'api';
  }

  static String get apiVersion {
    return dotenv.env['API_VERSION'] ?? 'v1';
  }

  static String get apiUrl {
    final baseUrl = _trimSlashes(apiBaseUrl);
    final prefix = _trimSlashes(apiPrefix);
    final version = _trimSlashes(apiVersion);

    return '$baseUrl/$prefix/$version';
  }

  static int get apiTimeoutSeconds {
    return int.tryParse(dotenv.env['API_TIMEOUT_SECONDS'] ?? '') ?? 15;
  }

  static bool get isProduction {
    return appFlavor == 'prod';
  }

  static String _trimSlashes(String value) {
    return value
        .replaceFirst(RegExp(r'^/+'), '')
        .replaceFirst(RegExp(r'/+$'), '');
  }
}
