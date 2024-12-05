// To parse this JSON data, do
//
//     final userRegistarionModel = userRegistarionModelFromJson(jsonString);

import 'dart:convert';

UserRegistarionModel userRegistarionModelFromJson(String str) => UserRegistarionModel.fromJson(json.decode(str));

String userRegistarionModelToJson(UserRegistarionModel data) => json.encode(data.toJson());

class UserRegistarionModel {
  String? response;
  String? message;

  UserRegistarionModel({
    this.response,
    this.message,
  });

  factory UserRegistarionModel.fromJson(Map<String, dynamic> json) => UserRegistarionModel(
    response: json["response"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
  };
}
