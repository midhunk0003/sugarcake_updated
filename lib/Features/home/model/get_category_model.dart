// To parse this JSON data, do
//
//     final getCategoryModel = getCategoryModelFromJson(jsonString);

import 'dart:convert';

GetCategoryModel getCategoryModelFromJson(String str) => GetCategoryModel.fromJson(json.decode(str));

String getCategoryModelToJson(GetCategoryModel data) => json.encode(data.toJson());

class GetCategoryModel {
  String? response;
  List<CategoryList>? categoryList;

  GetCategoryModel({
    this.response,
    this.categoryList,
  });

  factory GetCategoryModel.fromJson(Map<String, dynamic> json) => GetCategoryModel(
    response: json["response"],
    categoryList: List<CategoryList>.from(json["category_list"].map((x) => CategoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "category_list": List<dynamic>.from(categoryList!.map((x) => x.toJson())),
  };
}

class CategoryList {
  int? id;
  String? categoryname;
  String? imageurl;

  CategoryList({
    this.id,
    this.categoryname,
    this.imageurl,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
    id: json["id"],
    categoryname: json["categoryname"],
    imageurl: json["imageurl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryname": categoryname,
    "imageurl": imageurl,
  };
}
