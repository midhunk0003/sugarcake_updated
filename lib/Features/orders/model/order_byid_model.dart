// To parse this JSON data, do
//
//     final getOrderByIdModel = getOrderByIdModelFromJson(jsonString);

import 'dart:convert';

GetOrderByIdModel getOrderByIdModelFromJson(String str) =>
    GetOrderByIdModel.fromJson(json.decode(str));

String getOrderByIdModelToJson(GetOrderByIdModel data) =>
    json.encode(data.toJson());

class GetOrderByIdModel {
  String? response;
  List<Orderdetail>? orderdetails;
  List<Itemlist>? itemlist;

  GetOrderByIdModel({
    this.response,
    this.orderdetails,
    this.itemlist,
  });

  factory GetOrderByIdModel.fromJson(Map<String, dynamic> json) =>
      GetOrderByIdModel(
        response: json["response"],
        orderdetails: List<Orderdetail>.from(
            json["orderdetails"].map((x) => Orderdetail.fromJson(x))),
        itemlist: List<Itemlist>.from(
            json["itemlist"].map((x) => Itemlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "orderdetails":
            List<dynamic>.from(orderdetails!.map((x) => x.toJson())),
        "itemlist": List<dynamic>.from(itemlist!.map((x) => x.toJson())),
      };
}

class Itemlist {
  String? orderNo;
  String? orderedDate;
  String? deliveryDate;
  String? deliveryCharge;
  String? paymentType;
  String? contact;
  String? productid;
  String? productName;
  String? categoryName;
  String? quantity;
  String? price;
  String? weight;
  String? flavoursName;
  String? amount;
  String? status;
  String? note;

  Itemlist({
    this.orderNo,
    this.orderedDate,
    this.deliveryDate,
    this.deliveryCharge,
    this.paymentType,
    this.contact,
    this.productid,
    this.productName,
    this.categoryName,
    this.quantity,
    this.price,
    this.weight,
    this.flavoursName,
    this.amount,
    this.status,
    this.note,
  });

  factory Itemlist.fromJson(Map<String, dynamic> json) => Itemlist(
        orderNo: json["orderNo"],
        orderedDate: json["ordered_date"],
        deliveryDate: json["delivery_date"],
        deliveryCharge: json["delivery_charge"],
        paymentType: json["payment_type"],
        contact: json["contact"],
        productid: json["productid"],
        productName: json["product_name"],
        categoryName: json["category_name"],
        quantity: json["quantity"],
        price: json["price"],
        weight: json["weight"],
        flavoursName: json["flavours_name"],
        amount: json["amount"],
        status: json["status"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "orderNo": orderNo,
        "ordered_date": orderedDate,
        "delivery_date": deliveryDate,
        "delivery_charge": deliveryCharge,
        "payment_type": paymentType,
        "contact": contact,
        "productid": productid,
        "product_name": productName,
        "category_name": categoryName,
        "quantity": quantity,
        "price": price,
        "weight": weight,
        "flavours_name": flavoursName,
        "amount": amount,
        "status": status,
        "note": note,
      };
}

class Orderdetail {
  int? id;
  String? orderNo;
  String? customerName;
  String? address;
  DateTime? orderedDate;
  String? deliveryCharge;
  String? total;
  String? itemCount;
  String? deliveryDate;
  String? deliveryTime;
  String? status;
  String? paymentType;
  String? paymentStatus;
  String? addressid;
  String? latitude;
  String? longitude;
  String? contact;
  String? pincode;
  String? selfPickup;
  String? userid;

  Orderdetail({
    this.id,
    this.orderNo,
    this.customerName,
    this.address,
    this.orderedDate,
    this.deliveryCharge,
    this.total,
    this.itemCount,
    this.deliveryDate,
    this.deliveryTime,
    this.status,
    this.paymentType,
    this.paymentStatus,
    this.addressid,
    this.latitude,
    this.longitude,
    this.contact,
    this.pincode,
    this.selfPickup,
    this.userid,
  });

  factory Orderdetail.fromJson(Map<String, dynamic> json) => Orderdetail(
        id: json["id"],
        orderNo: json["orderNo"],
        customerName: json["customer_name"],
        address: json["address"],
        orderedDate: DateTime.parse(json["ordered_date"]),
        deliveryCharge: json["delivery_charge"],
        total: json["total"],
        itemCount: json["item_count"],
        deliveryDate: json["delivery_date"],
        deliveryTime: json["delivery_time"],
        status: json["status"],
        paymentType: json["payment_type"],
        paymentStatus: json["payment_status"],
        addressid: json["addressid"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        contact: json["contact"],
        pincode: json["pincode"],
        selfPickup: json["self_pickup"],
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderNo": orderNo,
        "customer_name": customerName,
        "address": address,
        "ordered_date": orderedDate,
        "delivery_charge": deliveryCharge,
        "total": total,
        "item_count": itemCount,
        "delivery_date": deliveryDate,
        "delivery_time": deliveryTime,
        "status": status,
        "payment_type": paymentType,
        "payment_status": paymentStatus,
        "addressid": addressid,
        "latitude": latitude,
        "longitude": longitude,
        "contact": contact,
        "pincode": pincode,
        "self_pickup": selfPickup,
        "userid": userid,
      };
}
