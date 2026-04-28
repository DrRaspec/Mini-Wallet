import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static final bool isReleaseMode = kReleaseMode;

  static void log(String message) {
    if (!isReleaseMode) {
      debugPrint('[AppLogger] $message');
    }
  }
}
