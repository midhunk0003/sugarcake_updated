// To parse this JSON data, do
//
//     final getBannerModel = getBannerModelFromJson(jsonString);

import 'dart:convert';

GetBannerModel getBannerModelFromJson(String str) => GetBannerModel.fromJson(json.decode(str));

String getBannerModelToJson(GetBannerModel data) => json.encode(data.toJson());

class GetBannerModel {
  String? response;
  List<BannerList>? bannerList;

  GetBannerModel({
    this.response,
    this.bannerList,
  });

  factory GetBannerModel.fromJson(Map<String, dynamic> json) => GetBannerModel(
    response: json["response"],
    bannerList: List<BannerList>.from(json["banner_list"].map((x) => BannerList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "banner_list": List<dynamic>.from(bannerList!.map((x) => x.toJson())),
  };
}

class BannerList {
  int? id;
  String? imageurl;
  DateTime? createdDate;
  String? status;

  BannerList({
    this.id,
    this.imageurl,
    this.createdDate,
    this.status,
  });

  factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(
    id: json["id"],
    imageurl: json["imageurl"],
    createdDate: DateTime.parse(json["createdDate"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imageurl": imageurl,
    "createdDate": createdDate!.toIso8601String(),
    "status": status,
  };
}
