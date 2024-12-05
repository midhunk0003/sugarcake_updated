
import 'dart:convert';

GetFeatureProductsModel getFeatureProductsModelFromJson(String str) => GetFeatureProductsModel.fromJson(json.decode(str));

String getFeatureProductsModelToJson(GetFeatureProductsModel data) => json.encode(data.toJson());

class GetFeatureProductsModel {
  String? response;
  List<FeaturedproductsList>? featuredproductsList;

  GetFeatureProductsModel({
    this.response,
    this.featuredproductsList,
  });

  factory GetFeatureProductsModel.fromJson(Map<String, dynamic> json) => GetFeatureProductsModel(
    response: json["response"],
    featuredproductsList: List<FeaturedproductsList>.from(json["featuredproducts_list"].map((x) => FeaturedproductsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "featuredproducts_list": List<dynamic>.from(featuredproductsList!.map((x) => x.toJson())),
  };
}

class FeaturedproductsList {
  int? productId;
  String? productname;
  double? offerprice;
  String? imageurl;
  double? price;
  String? status;
  String? iswishlist;
  double? rating;

  FeaturedproductsList({
    this.productId,
    this.productname,
    this.offerprice,
    this.imageurl,
    this.price,
    this.status,
    this.iswishlist,
    this.rating,
  });

  factory FeaturedproductsList.fromJson(Map<String, dynamic> json) => FeaturedproductsList(
    productId: json["productId"],
    productname: json["productname"],
    offerprice: json["offerprice"],
    imageurl: json["imageurl"],
    price: json["price"],
    status: json["status"],
    iswishlist: json["iswishlist"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productname": productname,
    "offerprice": offerprice,
    "imageurl": imageurl,
    "price": price,
    "status": status,
    "iswishlist": iswishlist,
    "rating": rating,
  };
}
