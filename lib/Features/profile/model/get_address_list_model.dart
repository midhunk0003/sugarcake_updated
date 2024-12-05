// To parse this JSON data, do
//
//     final getAddressListModel = getAddressListModelFromJson(jsonString);

import 'dart:convert';

GetAddressListModel getAddressListModelFromJson(String str) => GetAddressListModel.fromJson(json.decode(str));

String getAddressListModelToJson(GetAddressListModel data) => json.encode(data.toJson());

class GetAddressListModel {
  String? response;
  List<AddressList>? addressList;

  GetAddressListModel({
    this.response,
    this.addressList,
  });

  factory GetAddressListModel.fromJson(Map<String, dynamic> json) => GetAddressListModel(
    response: json["response"],
    addressList: List<AddressList>.from(json["address_list"].map((x) => AddressList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "address_list": List<dynamic>.from(addressList!.map((x) => x.toJson())),
  };
}

class AddressList {
  int? addressid;
  String? orderedfor;
  String? addressas;
  String? address;
  String? floor;
  String? landmark;
  String? contact;
  String? defaultadrs;

  AddressList({
    this.addressid,
    this.orderedfor,
    this.addressas,
    this.address,
    this.floor,
    this.landmark,
    this.contact,
    this.defaultadrs,
  });

  factory AddressList.fromJson(Map<String, dynamic> json) => AddressList(
    addressid: json["addressid"],
    orderedfor: json["orderedfor"],
    addressas: json["addressas"],
    address: json["address"],
    floor: json["floor"],
    landmark: json["landmark"],
    contact: json["contact"],
    defaultadrs: json["defaultadrs"],
  );

  Map<String, dynamic> toJson() => {
    "addressid": addressid,
    "orderedfor": orderedfor,
    "addressas": addressas,
    "address": address,
    "floor": floor,
    "landmark": landmark,
    "contact": contact,
    "defaultadrs": defaultadrs,
  };
}
