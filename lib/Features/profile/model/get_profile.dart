

import 'dart:convert';

GetProfileModel getProfileModelFromJson(String str) => GetProfileModel.fromJson(json.decode(str));

String getProfileModelToJson(GetProfileModel data) => json.encode(data.toJson());

class GetProfileModel {
  String? response;
  UserDetails? userDetails;

  GetProfileModel({
    this.response,
    this.userDetails,
  });

  factory GetProfileModel.fromJson(Map<String, dynamic> json) => GetProfileModel(
    response: json["response"],
    userDetails: UserDetails.fromJson(json["user_details"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "user_details": userDetails!.toJson(),
  };
}

class UserDetails {
  String? userId;
  int? id;
  String? name;
  String? email;
  String? phoneNumber;

  UserDetails({
    this.userId,
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    userId: json["userId"],
    id: json["Id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "Id": id,
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
  };
}
