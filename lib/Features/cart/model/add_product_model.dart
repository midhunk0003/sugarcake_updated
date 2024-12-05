// To parse this JSON data, do
//
//     final addProductModel = addProductModelFromJson(jsonString);

import 'dart:convert';

AddProductModel addProductModelFromJson(String str) => AddProductModel.fromJson(json.decode(str));

String addProductModelToJson(AddProductModel data) => json.encode(data.toJson());

class AddProductModel {
  String? response;
  String? message;
  String? content;

  AddProductModel({
    this.response,
    this.message,
    this.content,
  });

  factory AddProductModel.fromJson(Map<String, dynamic> json) => AddProductModel(
    response: json["response"],
    message: json["message"],
    content: json["Content"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "Content": content,
  };
}
