import 'dart:convert';

class UrlShortenerResponse {
  int id;
  String url;
  String originalUrl;
  DateTime createdAt;
  DateTime updatedAt;

  UrlShortenerResponse({
    required this.id,
    required this.url,
    required this.originalUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UrlShortenerResponse.fromRawJson(String str) =>
      UrlShortenerResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UrlShortenerResponse.fromJson(Map<String, dynamic> json) =>
      UrlShortenerResponse(
        id: json["id"],
        url: json["url"],
        originalUrl: json["original_url"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "original_url": originalUrl,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
