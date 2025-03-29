import 'dart:convert';

class LoginResponse {
  String email;
  String accessToken;

  LoginResponse({required this.email, required this.accessToken});

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(email: json["email"], accessToken: json["access_token"]);

  Map<String, dynamic> toJson() => {
    "email": email,
    "access_token": accessToken,
  };
}
