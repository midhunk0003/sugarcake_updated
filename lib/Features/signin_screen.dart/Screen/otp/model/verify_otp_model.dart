// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  String? response;
  String? message;

  VerifyOtpModel({
    this.response,
    this.message,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
    response: json["response"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
  };
}
