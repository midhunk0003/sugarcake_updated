// To parse this JSON data, do
//
//     final getCartModel = getCartModelFromJson(jsonString);

import 'dart:convert';

GetCartModel getCartModelFromJson(String str) =>
    GetCartModel.fromJson(json.decode(str));

String getCartModelToJson(GetCartModel data) => json.encode(data.toJson());

class GetCartModel {
  String? response;
  List<CartDetail>? cartDetails;
  int? count;
  double? totalPrice;
  double? offerPrice;
  double? totalAmount;

  GetCartModel({
    this.response,
    this.cartDetails,
    this.count,
    this.totalPrice,
    this.offerPrice,
    this.totalAmount,
  });

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
        response: json["response"],
        cartDetails: List<CartDetail>.from(
            json["cart_details"].map((x) => CartDetail.fromJson(x))),
        count: json["count"],
        totalPrice: json["total_price"],
        offerPrice: json["offer_price"],
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "cart_details": List<dynamic>.from(cartDetails!.map((x) => x.toJson())),
        "count": count,
        "total_price": totalPrice,
        "offer_price": offerPrice,
        "total_amount": totalAmount,
      };
}

class CartDetail {
  String? imageurl;
  int? productid;
  String? productname;
  String? preparationtime;
  String? price;
  double? offerprice;
  String? weight;
  int? weightid;
  int? flavoursid;
  String? categoryName;
  String? flavoursname;
  int? quantity;
  String? categoryid;
  int? id;
  String? note;

  CartDetail({
    this.imageurl,
    this.productid,
    this.productname,
    this.preparationtime,
    this.price,
    this.offerprice,
    this.weight,
    this.weightid,
    this.flavoursid,
    this.categoryName,
    this.flavoursname,
    this.quantity,
    this.categoryid,
    this.id,
    this.note,
  });

  factory CartDetail.fromJson(Map<String, dynamic> json) => CartDetail(
        imageurl: json["imageurl"],
        productid: json["productid"],
        productname: json["productname"],
        preparationtime: json["preparationtime"],
        price: json["price"],
        offerprice: json["offerprice"],
        weight: json["weight"],
        weightid: json["weightid"],
        flavoursid: json["flavoursid"],
        categoryName: json["categoryName"],
        flavoursname: json["flavoursname"],
        quantity: json["quantity"],
        categoryid: json["categoryid"],
        id: json["id"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "imageurl": imageurl,
        "productid": productid,
        "productname": productname,
        "preparationtime": preparationtime,
        "price": price,
        "offerprice": offerprice,
        "weight": weight,
        "weightid": weightid,
        "flavoursid": flavoursid,
        "categoryName": categoryName,
        "flavoursname": flavoursname,
        "quantity": quantity,
        "categoryid": categoryid,
        "id": id,
        "note": note,
      };
}
