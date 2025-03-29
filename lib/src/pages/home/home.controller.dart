import 'package:flutter/cupertino.dart';
import 'package:shortenerapp/src/core/api/shortener.api.dart';
import 'package:shortenerapp/src/core/models/url_shortener/create-url-shortener.request.dart';
import 'package:shortenerapp/src/shared/app_state.dart';

class HomeController {
  final urlController = TextEditingController();

  Future<void> saveNewUrl(AppState state) async {
     state.addNewUrl(
      await ShortenerApi().post(
        CreateUrlShortenerRequest(url: urlController.text),
      ),
    );
  }
}
