// To parse this JSON data, do
//
//     final limitPopularProducts = limitPopularProductsFromJson(jsonString);

import 'dart:convert';

LimitPopularProducts limitPopularProductsFromJson(String str) =>
    LimitPopularProducts.fromJson(json.decode(str));

String limitPopularProductsToJson(LimitPopularProducts data) =>
    json.encode(data.toJson());

class LimitPopularProducts {
  String? response;
  List<PopularproductList>? popularproductList;

  LimitPopularProducts({
    this.response,
    this.popularproductList,
  });

  factory LimitPopularProducts.fromJson(Map<String, dynamic> json) =>
      LimitPopularProducts(
        response: json["response"],
        popularproductList: List<PopularproductList>.from(
            json["popularproduct_list"]
                .map((x) => PopularproductList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "popularproduct_list":
            List<dynamic>.from(popularproductList!.map((x) => x.toJson())),
      };
}

class PopularproductList {
  int? productId;
  String? productname;
  double? price;
  double? offerprice;
  String? imageurl;
  String? status;
  String? iswishlist;
  double? rating;

  PopularproductList({
    this.productId,
    this.productname,
    this.price,
    this.offerprice,
    this.imageurl,
    this.status,
    this.iswishlist,
    this.rating,
  });

  factory PopularproductList.fromJson(Map<String, dynamic> json) =>
      PopularproductList(
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
