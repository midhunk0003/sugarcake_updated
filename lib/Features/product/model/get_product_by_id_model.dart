import 'dart:convert';
//
GetProductByIdModel getProductByIdFromJson(String str) =>
    GetProductByIdModel.fromJson(json.decode(str));

String getProductByIdToJson(GetProductByIdModel data) =>
    json.encode(data.toJson());

class GetProductByIdModel {
  String? response;
  List<ProductDetail>? productDetails;
  List<Flavour>? flavours;
  List<Weight>? weights;
  List<Imagelist>? imagelist;

  GetProductByIdModel({
    this.response,
    this.productDetails,
    this.flavours,
    this.weights,
    this.imagelist,
  });

  factory GetProductByIdModel.fromJson(Map<String, dynamic> json) =>
      GetProductByIdModel(
        response: json["response"],
        productDetails: List<ProductDetail>.from(
            json["product_details"].map((x) => ProductDetail.fromJson(x))),
        flavours: List<Flavour>.from(
            json["flavours"].map((x) => Flavour.fromJson(x))),
        weights: List<Weight>.from(
            json["weights"].map((x) => Weight.fromJson(x))),
        imagelist: List<Imagelist>.from(
            json["imagelist"].map((x) => Imagelist.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "response": response,
        "product_details": List<dynamic>.from(
            productDetails!.map((x) => x.toJson())),
        "flavours": List<dynamic>.from(flavours!.map((x) => x.toJson())),
        "weights": List<dynamic>.from(weights!.map((x) => x.toJson())),
        "imagelist": List<dynamic>.from(imagelist!.map((x) => x.toJson())),
      };
}

class Flavour {
  int? id;
  String? flavoursname;

  Flavour({
    this.id,
    this.flavoursname,
  });

  factory Flavour.fromJson(Map<String, dynamic> json) =>
      Flavour(
        id: json["id"],
        flavoursname: json["flavoursname"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "flavoursname": flavoursname,
      };
}

class Imagelist {
  int? id;
  DateTime? createddate;
  int? productId;
  String? imageurl1;
  String? imageurl2;
  String? imageurl3;
  String? imageurl4;

  Imagelist({
    this.id,
    this.createddate,
    this.productId,
    this.imageurl1,
    this.imageurl2,
    this.imageurl3,
    this.imageurl4,
  });

  factory Imagelist.fromJson(Map<String, dynamic> json) =>
      Imagelist(
        id: json["id"],
        createddate: DateTime.parse(json["createddate"]),
        productId: json["productId"],
        imageurl1: json["imageurl1"],
        imageurl2: json["imageurl2"],
        imageurl3: json["imageurl3"],
        imageurl4: json["imageurl4"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "createddate": createddate!.toIso8601String(),
        "productId": productId,
        "imageurl1": imageurl1,
        "imageurl2": imageurl2,
        "imageurl3": imageurl3,
        "imageurl4": imageurl4,
      };
}

class ProductDetail {
  int? id;
  String? productname;
  String? description;
  String? status;
  String? preparationtime;
  String? imageurl;
  double? offerprice;
  double? price;
  int? categoryid;
  String? categoryname;
  dynamic rating;
  String? iswishlist;

  ProductDetail({
    this.id,
    this.productname,
    this.description,
    this.status,
    this.preparationtime,
    this.imageurl,
    this.offerprice,
    this.price,
    this.categoryid,
    this.categoryname,
    this.rating,
    this.iswishlist,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) =>
      ProductDetail(
        id: json["id"],
        productname: json["productname"],
        description: json["description"],
        status: json["status"],
        preparationtime:json["preparationtime"],
        imageurl: json["imageurl"],
        offerprice: json["offerprice"],
        price: json["price"],
        categoryid: json["categoryid"],
        categoryname: json["categoryname"],
        rating: json["rating"],
        iswishlist: json["iswishlist"],

      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "productname": productname,
        "description": description,
        "status": status,
        "preparationtime":preparationtime,
        "imageurl": imageurl,
        "offerprice": offerprice,
        "price": price,
        "categoryid": categoryid,
        "categoryname": categoryname,
        "rating": rating,
        "iswishlist": iswishlist,

      };
}

class Weight {
  int? id;
  String? weight;
  String? price;

  Weight({
    this.id,
    this.weight,
    this.price,
  });

  factory Weight.fromJson(Map<String, dynamic> json) =>
      Weight(
          id: json["id"],
          weight: json["weight"],
          price: json["price"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "weight": weight,
        "price" : price,
      };
}
