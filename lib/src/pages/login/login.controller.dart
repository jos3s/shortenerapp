import 'package:flutter/widgets.dart';
import 'package:shortenerapp/src/core/api/shortener.api.dart';
import 'package:shortenerapp/src/core/models/auth/login.request.dart';
import 'package:shortenerapp/src/core/storage/secure_storage.dart';

class LoginController {
  final _secureStorage = SecureStorage();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateEmail(value) {
    if (value == null || value.isEmpty) return 'Email is not empty';
    return null;
  }

  String? validatePassword(value) {
    if (value == null || value.isEmpty) return 'Password is not empty';
    return null;
  }

  Future<void> fetchSecureStorageData() async {
    emailController.text = await _secureStorage.getEmail() ?? '';
    passwordController.text = await _secureStorage.getPassword() ?? '';
  }

  Future<String> login() async {
    try {
      await _secureStorage.setEmail(emailController.text);
      await _secureStorage.setPassword(passwordController.text);

      var response = await ShortenerApi().login(
        LoginRequest(
          email: emailController.text,
          password: passwordController.text,
        ),
      );

      await _secureStorage.setToken(response.accessToken);
      return response.accessToken;
    } catch (e) {
      rethrow;
    }
  }
}
