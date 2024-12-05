
import 'dart:convert';

GetExploreModel getExploreModelFromJson(String str) => GetExploreModel.fromJson(json.decode(str));

String getExploreModelToJson(GetExploreModel data) => json.encode(data.toJson());

class GetExploreModel {
  String? response;
  List<ProductDetail>? productDetails;

  GetExploreModel({
    this.response,
    this.productDetails,
  });

  factory GetExploreModel.fromJson(Map<String, dynamic> json) => GetExploreModel(
    response: json["response"],
    productDetails: List<ProductDetail>.from(json["product_details"].map((x) => ProductDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "product_details": List<dynamic>.from(productDetails!.map((x) => x.toJson())),
  };
}

class ProductDetail {
  int? id;
  String? productname;
  double? offerprice;
  String? imageurl;
  double? price;
  String? status;
  String? categoryName;
  String? iswishlist;
  double? rating;

  ProductDetail({
    this.id,
    this.productname,
    this.offerprice,
    this.imageurl,
    this.price,
    this.status,
    this.categoryName,
    this.iswishlist,
    this.rating,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    id: json["id"],
    productname: json["productname"],
    offerprice: json["offerprice"],
    imageurl: json["imageurl"],
    price: json["price"],
    status: json["status"],
    categoryName: json["categoryName"],
    iswishlist: json["iswishlist"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productname": productname,
    "offerprice": offerprice,
    "imageurl": imageurl,
    "price": price,
    "status": status,
    "categoryName": categoryName,
    "iswishlist": iswishlist,
    "rating": rating,
  };
}
