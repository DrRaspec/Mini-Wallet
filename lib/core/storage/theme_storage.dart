import 'package:flutter/material.dart';
import 'package:mini_wallet/core/constants/storage_keys.dart';
import 'package:mini_wallet/core/services/storage_service.dart';

class ThemeStorage {
  final StorageService _storage;

  ThemeStorage(this._storage);

  static const _key = StorageKeys.appTheme;

  void save(ThemeMode mode) {
    _storage.write<int>(_key, mode.index);
  }

  ThemeMode get() {
    final raw = _storage.read<int>(_key);
    if (raw != null && raw >= 0 && raw < ThemeMode.values.length) {
      return ThemeMode.values[raw];
    }
    return ThemeMode.system;
  }

  void clear() => _storage.remove(_key);
}
