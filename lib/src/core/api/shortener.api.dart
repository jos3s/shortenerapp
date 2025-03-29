import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shortenerapp/src/core/exceptions/unauthorized.exception.dart';
import 'package:shortenerapp/src/core/models/auth/login.request.dart';
import 'package:shortenerapp/src/core/models/auth/login.response.dart';
import 'package:shortenerapp/src/core/models/url_shortener/create-url-shortener.request.dart';
import 'package:shortenerapp/src/core/models/url_shortener/url_shortener.response.dart';
import 'package:shortenerapp/src/core/storage/secure_storage.dart';

class ShortenerApi {
  static const url = 'http://localhost:3000';
  final _secureStorage = SecureStorage();

  Future<String?> _getToken() => _secureStorage.getToken();

  Future<LoginResponse> login(LoginRequest request) async {
    var client = http.Client();
    var uri = Uri.parse('$url/auth');
    var response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw Exception(response.body);
    }
  }

  Future<UrlShortenerResponse> post(CreateUrlShortenerRequest request) async {
    var client = http.Client();
    var token = await _getToken();
    var uri = Uri.parse('$url/');
    var response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 201) {
      return UrlShortenerResponse.fromRawJson(response.body);
    } else {
      throw Exception();
    }
  }

  Future<List<UrlShortenerResponse>> getAllUrl() async {
    var client = http.Client();
    var token = await _getToken();
    var uri = Uri.parse('$url/all');
    var response = await client.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return List<UrlShortenerResponse>.from(
        json.decode(response.body).map((x) => UrlShortenerResponse.fromJson(x)),
      );
    } else {
      throw Exception();
    }
  }

}
