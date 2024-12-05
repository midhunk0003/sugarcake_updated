// To parse this JSON data, do
//
//     final sendotpModel = sendotpModelFromJson(jsonString);

import 'dart:convert';

SendotpModel sendotpModelFromJson(String str) => SendotpModel.fromJson(json.decode(str));

String sendotpModelToJson(SendotpModel data) => json.encode(data.toJson());

class SendotpModel {
  String? response;
  String? message;
  String? key;

  SendotpModel({
    this.response,
    this.message,
    this.key,
  });

  factory SendotpModel.fromJson(Map<String, dynamic> json) => SendotpModel(
    response: json["response"],
    message: json["message"],
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "key": key,
  };
}
