import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PreferenceHelper {
  final _storage = const FlutterSecureStorage();
  static const _token = "token";

  Future setToken(String token) async {
    await _storage.write(key: _token, value: token);
  }

  Future<String?> getToken() async {
    return _storage.read(key: _token);
  }

  deleteAll() async {
    await _storage.deleteAll();
  }
}
