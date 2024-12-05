// To parse this JSON data, do
//
//     final getOrder = getOrderFromJson(jsonString);

import 'dart:convert';

GetOrder getOrderFromJson(String str) => GetOrder.fromJson(json.decode(str));

String getOrderToJson(GetOrder data) => json.encode(data.toJson());

class GetOrder {
  String? response;
  List<Orderdetail>? orderdetails;

  GetOrder({
    this.response,
    this.orderdetails,
  });

  factory GetOrder.fromJson(Map<String, dynamic> json) => GetOrder(
    response: json["response"],
    orderdetails: List<Orderdetail>.from(json["orderdetails"].map((x) => Orderdetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "orderdetails": List<dynamic>.from(orderdetails!.map((x) => x.toJson())),
  };
}

class Orderdetail {
  int? id;
  String? orderNo;
  CustomerName? customerName;
  Address? address;
  DateTime? orderedDate;
  String? deliveryCharge;
  String? total;
  String? itemCount;
  String? deliveryDate;
  String? deliveryTime;
  String? status;
  Payment? paymentType;
  Payment? paymentStatus;
  String? addressid;
  String? latitude;
  String? longitude;
  String? contact;
  String? pincode;
  SelfPickup? selfPickup;
  Userid? userid;
  dynamic rating;

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
    this.rating,
  });

  factory Orderdetail.fromJson(Map<String, dynamic> json) => Orderdetail(
    id: json["id"],
    orderNo: json["orderNo"],
    customerName: customerNameValues.map[json["customer_name"]],
    address: addressValues.map[json["address"]],
    orderedDate: DateTime.parse(json["ordered_date"]),
    deliveryCharge: json["delivery_charge"],
    total: json["total"],
    itemCount: json["item_count"],
    deliveryDate: json["delivery_date"],
    deliveryTime: json["delivery_time"],
    status: json["status"],
    paymentType: paymentValues.map[json["payment_type"]],
    paymentStatus: paymentValues.map[json["payment_status"]],
    addressid: json["addressid"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    contact: json["contact"],
    pincode: json["pincode"],
    selfPickup: selfPickupValues.map[json["self_pickup"]],
    userid: useridValues.map[json["userid"]],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "orderNo": orderNo,
    "customer_name": customerNameValues.reverse[customerName],
    "address": addressValues.reverse[address],
    "ordered_date": orderedDate!.toIso8601String(),
    "delivery_charge": deliveryCharge,
    "total": total,
    "item_count": itemCount,
    "delivery_date": deliveryDateValues.reverse[deliveryDate],
    "delivery_time": deliveryTimeValues.reverse[deliveryTime],
    "status": statusValues.reverse[status],
    "payment_type": paymentValues.reverse[paymentType],
    "payment_status": paymentValues.reverse[paymentStatus],
    "addressid": addressid,
    "latitude": latitude,
    "longitude": longitude,
    "contact": contact,
    "pincode": pincode,
    "self_pickup": selfPickupValues.reverse[selfPickup],
    "userid": useridValues.reverse[userid],
    "rating": rating,
  };
}

enum Address {
  CVG_TYGHTH_FLOOR_GHGHH,
  EMPTY,
  GHH_GHHHTH_FLOOR_GGGG
}

final addressValues = EnumValues({
  " cvg, tyghth floor ,ghghh": Address.CVG_TYGHTH_FLOOR_GHGHH,
  "": Address.EMPTY,
  "ghh, ghhhth floor ,gggg": Address.GHH_GHHHTH_FLOOR_GGGG
});

enum CustomerName {
  SHEFF
}

final customerNameValues = EnumValues({
  "sheff": CustomerName.SHEFF
});

enum DeliveryDate {
  THE_15052024,
  THE_29042024
}

final deliveryDateValues = EnumValues({
  "15/05/2024": DeliveryDate.THE_15052024,
  "29/04/2024": DeliveryDate.THE_29042024
});

enum DeliveryTime {
  DELIVERY_TIME_11_AM,
  THE_11_AM
}

final deliveryTimeValues = EnumValues({
  "11:am": DeliveryTime.DELIVERY_TIME_11_AM,
  "11 am": DeliveryTime.THE_11_AM
});

enum Payment {
  COD
}

final paymentValues = EnumValues({
  "Cod": Payment.COD
});

enum SelfPickup {
  NO,
  SELF_PICKUP_NO
}

final selfPickupValues = EnumValues({
  "No": SelfPickup.NO,
  "no": SelfPickup.SELF_PICKUP_NO
});

enum Status {
  PENDING
}

final statusValues = EnumValues({
  "Pending": Status.PENDING
});

enum Userid {
  SHEFF706
}

final useridValues = EnumValues({
  "sheff706": Userid.SHEFF706
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
