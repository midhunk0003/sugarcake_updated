
import 'dart:convert';

GetWhislistModel getWhislistModelFromJson(String str) => GetWhislistModel.fromJson(json.decode(str));

String getWhislistModelToJson(GetWhislistModel data) => json.encode(data.toJson());

class GetWhislistModel {
  String? response;
  List<WishlistList>? wishlistList;

  GetWhislistModel({
    this.response,
    this.wishlistList,
  });

  factory GetWhislistModel.fromJson(Map<String, dynamic> json) => GetWhislistModel(
    response: json["response"],
    wishlistList: List<WishlistList>.from(json["wishlist_list"].map((x) => WishlistList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "wishlist_list": List<dynamic>.from(wishlistList!.map((x) => x.toJson())),
  };
}

class WishlistList {
  int? id;
  String? productname;
  double? offerprice;
  String? status;
  String? imageurl;
  double? price;
  String? rating;

  WishlistList({
    this.id,
    this.productname,
    this.offerprice,
    this.status,
    this.imageurl,
    this.price,
    this.rating,
  });

  factory WishlistList.fromJson(Map<String, dynamic> json) => WishlistList(
    id: json["id"],
    productname: json["productname"],
    offerprice: json["offerprice"],
    status: json["status"],
    imageurl: json["imageurl"],
    price: json["price"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productname": productname,
    "offerprice": offerprice,
    "status": status,
    "imageurl": imageurl,
    "price": price,
    "rating": rating,
  };
}
