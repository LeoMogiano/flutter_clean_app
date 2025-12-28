import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {

  SecureStorage() {
    _storage = const FlutterSecureStorage();
  }
  late final FlutterSecureStorage _storage;

  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read({required String key}) async {
    return _storage.read(key: key);
  }

  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
