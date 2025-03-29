import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shortenerapp/src/core/models/url_shortener/create-url-shortener.request.dart';
import 'package:shortenerapp/src/core/models/url_shortener/url_shortener.response.dart';

class ShortenerApi {
  static const url = 'http://localhost:3000/';

  Future<UrlShortenerResponse> post(CreateUrlShortenerRequest request) async {
    var client = http.Client();
    var uri = Uri.parse('$url/');
    var response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 201) {
      return UrlShortenerResponse.fromRawJson(response.body);
    } else {
      throw Exception();
    }
  }
}
