
import 'dart:convert';

GetPopularProducts getPopularProductsFromJson(String str) => GetPopularProducts.fromJson(json.decode(str));

String getPopularProductsToJson(GetPopularProducts data) => json.encode(data.toJson());

class GetPopularProducts {
  String? response;
  List<PopularproductsList>? popularproductsList;

  GetPopularProducts({
    this.response,
    this.popularproductsList,
  });

  factory GetPopularProducts.fromJson(Map<String, dynamic> json) => GetPopularProducts(
    response: json["response"],
    popularproductsList: List<PopularproductsList>.from(json["popularproducts_list"].map((x) => PopularproductsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "popularproducts_list": List<dynamic>.from(popularproductsList!.map((x) => x.toJson())),
  };
}

class PopularproductsList {
  int? productId;
  String? productname;
  double? offerprice;
  double? price;
  String? imageurl;
  String? status;
  String? iswishlist;
  double? rating;

  PopularproductsList({
    this.productId,
    this.productname,
    this.offerprice,
    this.price,
    this.imageurl,
    this.status,
    this.iswishlist,
    this.rating,
  });

  factory PopularproductsList.fromJson(Map<String, dynamic> json) => PopularproductsList(
    productId: json["productId"],
    productname: json["productname"],
    offerprice: json["offerprice"],
    price: json["price"],
    imageurl: json["imageurl"],
    status: json["status"],
    iswishlist: json["iswishlist"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productname": productname,
    "offerprice": offerprice,
    "price": price,
    "imageurl": imageurl,
    "status": status,
    "iswishlist": iswishlist,
    "rating": rating,
  };
}
