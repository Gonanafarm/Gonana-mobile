// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  bool? success;
  List<Datum>? data;

  PostModel({
    this.success,
    this.data,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Product? product;
  String? ownerId;
  String? ownerPhoto;
  String? ownerName;

  Datum({
    this.product,
    this.ownerId,
    this.ownerPhoto,
    this.ownerName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        ownerId: json["ownerId"],
        ownerPhoto: json["ownerPhoto"],
        ownerName: json["ownerName"],
      );

  Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
        "ownerId": ownerId,
        "ownerPhoto": ownerPhoto,
        "ownerName": ownerName,
      };
}

class Product {
  bool? selfShipping;
  String? id;
  List<Address>? address;
  Location? location;
  List<dynamic>? categories;
  int? weight;
  int? quantity;
  int? amount;
  dynamic? usd_price;
  String? status;
  List<dynamic>? tags;
  String? body;
  List<String>? images;
  String? title;
  String? type;
  String? publisherId;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? productId;

  Product({
    this.selfShipping,
    this.id,
    this.address,
    this.location,
    this.categories,
    this.weight,
    this.quantity,
    this.amount,
    this.usd_price,
    this.status,
    this.tags,
    this.body,
    this.images,
    this.title,
    this.type,
    this.publisherId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.productId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        selfShipping: json["self_shipping"],
        id: json["_id"],
        address: json["address"] == null
            ? []
            : List<Address>.from(
                json["address"]!.map((x) => Address.fromJson(x))),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        categories: json["categories"] == null
            ? []
            : List<dynamic>.from(json["categories"]!.map((x) => x)),
        weight: json["weight"],
        quantity: json["quantity"],
        amount: json["amount"],
        usd_price: json["usd_price"],
        status: json["status"],
        tags: json["tags"] == null
            ? []
            : List<dynamic>.from(json["tags"]!.map((x) => x)),
        body: json["body"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        title: json["title"],
        type: json["type"],
        publisherId: json["publisher_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        v: json["__v"],
        productId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "self_shipping": selfShipping,
        "_id": id,
        "address": address == null
            ? []
            : List<dynamic>.from(address!.map((x) => x.toJson())),
        "location": location?.toJson(),
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
        "weight": weight,
        "quantity": quantity,
        "amount": amount,
        "usd_price": usd_price,
        "status": status,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "body": body,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "title": title,
        "type": type,
        "publisher_id": publisherId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "__v": v,
        "id": productId,
      };
}

class Address {
  String? address;
  int? code;

  Address({
    this.address,
    this.code,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "code": code,
      };
}

class Location {
  String? type;
  List<dynamic>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(
                json["coordinates"]!.map((x) => double.parse(x.toString())),
              ),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
