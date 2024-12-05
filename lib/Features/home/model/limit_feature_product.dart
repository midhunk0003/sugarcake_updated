// To parse this JSON data, do
//
//     final limitFeatureProducts = limitFeatureProductsFromJson(jsonString);

import 'dart:convert';

LimitFeatureProducts limitFeatureProductsFromJson(String str) => LimitFeatureProducts.fromJson(json.decode(str));

String limitFeatureProductsToJson(LimitFeatureProducts data) => json.encode(data.toJson());

class LimitFeatureProducts {
  String? response;
  List<LimitfeaturedProductsList>? limitfeaturedProductsList;

  LimitFeatureProducts({
    this.response,
    this.limitfeaturedProductsList,
  });

  factory LimitFeatureProducts.fromJson(Map<String, dynamic> json) => LimitFeatureProducts(
    response: json["response"],
    limitfeaturedProductsList: List<LimitfeaturedProductsList>.from(json["limitfeatured_products_list"].map((x) => LimitfeaturedProductsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "limitfeatured_products_list": List<dynamic>.from(limitfeaturedProductsList!.map((x) => x.toJson())),
  };
}

class LimitfeaturedProductsList {
  int? productId;
  String? productname;
  double? price;
  double? offerprice;
  String? imageurl;
  String? status;
  String? iswishlist;
  double? rating;

  LimitfeaturedProductsList({
    this.productId,
    this.productname,
    this.price,
    this.offerprice,
    this.imageurl,
    this.status,
    this.iswishlist,
    this.rating,
  });

  factory LimitfeaturedProductsList.fromJson(Map<String, dynamic> json) => LimitfeaturedProductsList(
    productId: json["productId"],
    productname: json["productname"],
    price: json["price"],
    offerprice: json["offerprice"],
    imageurl: json["imageurl"],
    status: json["status"],
    iswishlist: json["iswishlist"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productname": productname,
    "price": price,
    "offerprice": offerprice,
    "imageurl": imageurl,
    "status": status,
    "iswishlist": iswishlist,
    "rating": rating,
  };
}
