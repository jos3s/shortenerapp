import 'dart:convert';

class CreateUrlShortenerRequest {
  String url;

  CreateUrlShortenerRequest({required this.url});

  factory CreateUrlShortenerRequest.fromRawJson(String str) =>
      CreateUrlShortenerRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateUrlShortenerRequest.fromJson(Map<String, dynamic> json) =>
      CreateUrlShortenerRequest(url: json["url"]);

  Map<String, dynamic> toJson() => {"url": url};
}
