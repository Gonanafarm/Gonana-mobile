// To parse this JSON data, do
//
//     final feedsModel = feedsModelFromJson(jsonString);

import 'dart:convert';

FeedsModel feedsModelFromJson(String str) =>
    FeedsModel.fromJson(json.decode(str));

String feedsModelToJson(FeedsModel data) => json.encode(data.toJson());

class FeedsModel {
  bool? success;
  List<Datum>? data;

  FeedsModel({
    this.success,
    this.data,
  });

  factory FeedsModel.fromJson(Map<String, dynamic> json) => FeedsModel(
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
  String? id;
  bool? selfShipping;
  List<Address>? address;
  Location? location;
  List<dynamic>? categories;
  int? weight;
  int? quantity;
  int? amount;
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
  List<dynamic>? comments;
  List<String>? likes;
  String? productId;
  

  Product({
    this.id,
    this.selfShipping,
    this.address,
    this.location,
    this.categories,
    this.weight,
    this.quantity,
    this.amount,
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
    this.comments,
    this.likes,
    this.productId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        selfShipping: json["self_shipping"],
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
        status: json["status"],
        tags: json["tags"] == null ? [] : 
          List<dynamic>.from(json["tags"]!.map((x) => x)),
        body: json["body"],
        images: json["images"] == null ? [] : 
          List<String>.from(json["images"]!.map((x) => x)),
        title: json["title"],
        type: json["type"],
        publisherId: json["publisher_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        v: json["__v"],
        comments: json["comments"] == null
            ? []
            : List<dynamic>.from(json["comments"]!.map((x) => x)),
        likes: json["likes"] == null
            ? []
            : List<String>.from(json["likes"]!.map((x) => x)),
        productId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "self_shipping": selfShipping,
        "address": address == null
            ? []
            : List<dynamic>.from(address!.map((x) => x.toJson())),
        "location": location?.toJson(),
        "categories": categories == null ? []
          : List<dynamic>.from(categories!.map((x) => x)),
        "weight": weight,
        "quantity": quantity,
        "amount": amount,
        "status": status,
        "tags": tags == null ? [] : 
          List<dynamic>.from(tags!.map((x) => x)),
        "body": body,
        "images": images == null ? [] : 
          List<dynamic>.from(images!.map((x) => x)),
        "title": title,
        "type": type,
        "publisher_id": publisherId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "__v": v,
        "comments":
            comments == null ? [] : List<dynamic>.from(comments!.map((x) => x)),
        "likes": likes == null ? [] : List<dynamic>.from(likes!.map((x) => x)),
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
