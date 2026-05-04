import 'package:get_storage/get_storage.dart';

class StorageService {
  final box = GetStorage();

  T? read<T>(String key) => box.read<T>(key);
  void write<T>(String key, T value) => box.write(key, value);
  void remove(String key) => box.remove(key);
}
