import 'dart:convert';

class CreateAccountResponse {
  int id;
  String email;
  DateTime createdAt;
  DateTime updatedAt;

  CreateAccountResponse({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreateAccountResponse.fromRawJson(String str) =>
      CreateAccountResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateAccountResponse.fromJson(Map<String, dynamic> json) =>
      CreateAccountResponse(
        id: json["id"],
        email: json["email"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
