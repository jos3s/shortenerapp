import 'package:flutter/material.dart';
import 'package:shortenerapp/src/core/models/url_shortener/url_shortener.response.dart';

class AppState extends ChangeNotifier {
  var urlShorteners = [
  ];

  addNewUrl(UrlShortenerResponse response) {
    urlShorteners.add(response);
    notifyListeners();
  }

  removeUrl(int id) {
    urlShorteners.removeWhere((url) => url.id == id);
    notifyListeners();
  }
}
