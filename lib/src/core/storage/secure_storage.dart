import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  final String _keyEmail = "email";
  final String _keyPassword = "password";
  final String _keyToken = "token";

  Future setEmail(String username) async {
    await storage.write(key: _keyEmail, value: username);
  }

  Future<String?> getEmail() async {
    return await storage.read(key: _keyEmail);
  }

  Future setPassword(String password) async {
    await storage.write(key: _keyPassword, value: password);
  }

  Future<String?> getPassword() async {
    return await storage.read(key: _keyPassword);
  }

  Future setToken(String? token) async {
    await storage.write(key: _keyToken, value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: _keyToken);
  }

  Future<void> resetFields() async {
    await storage.delete(key: _keyEmail);
    await storage.delete(key: _keyPassword);
    await storage.delete(key: _keyToken);
  }
}
