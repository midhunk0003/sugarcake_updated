import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? response;
  Logindetails? logindetails;
  String? message;

  LoginModel({
    this.response,
    this.logindetails,
    this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    response: json["response"],
    logindetails: json["logindetails"] != null ? Logindetails.fromJson(json["logindetails"]) : null,
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "logindetails": logindetails?.toJson(),
    "message": message,
  };
}

class Logindetails {
  String? token;
  String? username;
  String? id;
  String? type;
  String? status;
  DateTime? tokenExpiry;
  DateTime? expiryTime;

  Logindetails({
    this.token,
    this.username,
    this.id,
    this.type,
    this.status,
    this.tokenExpiry,
    this.expiryTime,
  });

  factory Logindetails.fromJson(Map<String, dynamic> json) => Logindetails(
    token: json["token"],
    username: json["username"],
    id: json["id"],
    type: json["type"],
    status: json["status"],
    tokenExpiry: json["token_expiry"] != null ? DateTime.parse(json["token_expiry"]) : null,
    expiryTime: json["expiry_time"] != null ? DateTime.parse(json["expiry_time"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "username": username,
    "id": id,
    "type": type,
    "status": status,
    "token_expiry": tokenExpiry?.toIso8601String(),
    "expiry_time": expiryTime?.toIso8601String(),
  };
}

// Function to parse the response
LoginModel parseResponse(String str) {
  return loginModelFromJson(str);
}