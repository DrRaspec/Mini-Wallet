import 'package:flutter/material.dart';
import 'package:mini_wallet/core/constants/storage_keys.dart';
import 'package:mini_wallet/core/services/storage_service.dart';

class LocaleStorage {
  final StorageService _storage;

  LocaleStorage(this._storage);

  static const _key = StorageKeys.appLocale;
  static const fallbackLocale = Locale('en', 'US');

  void save(Locale locale) {
    final countryCode = locale.countryCode;
    final value = countryCode == null || countryCode.isEmpty
        ? locale.languageCode
        : '${locale.languageCode}_$countryCode';

    _storage.write<String>(_key, value);
  }

  Locale get() {
    final raw = _storage.read<String>(_key);
    if (raw == null || raw.isEmpty) {
      return fallbackLocale;
    }

    final parts = raw.split('_');
    if (parts.length == 1) {
      return Locale(parts.first);
    }

    return Locale(parts.first, parts[1]);
  }

  void clear() => _storage.remove(_key);
}
