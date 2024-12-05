// To parse this JSON data, do
//
//     final getCategoryListModel = getCategoryListModelFromJson(jsonString);

import 'dart:convert';

GetCategoryListModel getCategoryListModelFromJson(String str) =>
    GetCategoryListModel.fromJson(json.decode(str));

String getCategoryListModelToJson(GetCategoryListModel data) =>
    json.encode(data.toJson());

class GetCategoryListModel {
  String? response;
  List<Productlist>? productlist;

  GetCategoryListModel({
    this.response,
    this.productlist,
  });

  factory GetCategoryListModel.fromJson(Map<String, dynamic> json) =>
      GetCategoryListModel(
        response: json["response"],
        productlist: List<Productlist>.from(
            json["productlist"].map((x) => Productlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "productlist": List<dynamic>.from(productlist!.map((x) => x.toJson())),
      };
}

class Productlist {
  int? id;
  String? productname;
  int? categoryId;
  String? description;
  int? quantity;
  double? offerprice;
  double? price;
  int? flavoursId;
  String? imageurl;
  String? type;
  String? status;
  DateTime? createddate;
  String? arabicname;
  double? rating;
  String? iswishlist;

  Productlist({
    this.id,
    this.productname,
    this.categoryId,
    this.description,
    this.quantity,
    this.offerprice,
    this.price,
    this.flavoursId,
    this.imageurl,
    this.type,
    this.status,
    this.createddate,
    this.arabicname,
    this.rating,
    this.iswishlist,
  });

  factory Productlist.fromJson(Map<String, dynamic> json) => Productlist(
        id: json["id"],
        productname: json["productname"],
        categoryId: json["categoryId"],
        description: json["description"],
        quantity: json["quantity"],
        offerprice: json["offerprice"],
        price: json["price"],
        flavoursId: json["flavoursId"],
        imageurl: json["imageurl"],
        type: json["type"],
        status: json["status"],
        createddate: DateTime.parse(json["createddate"]),
        arabicname: json["Arabicname"],
        rating:  json["rating"] != null ? json["rating"].toDouble() : null,
        iswishlist: json["iswishlist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productname": productname,
        "categoryId": categoryId,
        "description": description,
        "quantity": quantity,
        "offerprice": offerprice,
        "price": price,
        "flavoursId": flavoursId,
        "imageurl": imageurl,
        "type": type,
        "status": status,
        "createddate": createddate!.toIso8601String(),
        "Arabicname": arabicname,
        "rating": rating,
        "iswishlist": iswishlist,
      };
}
