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
  int? rating;
  List<Comment>? comments;
  List<Like>? likes;
  bool? selfShipping;
  List<Address>? address;
  Location? location;
  List<dynamic>? categories;
  int? weight;
  int? quantity;
  int? amount;
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
  String? status;

  Product({
    this.id,
    this.rating,
    this.comments,
    this.likes,
    this.selfShipping,
    this.address,
    this.location,
    this.categories,
    this.weight,
    this.quantity,
    this.amount,
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
    this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        rating: json["rating"],
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"]!.map((x) => Comment.fromJson(x))),
        likes: json["likes"] == null
            ? []
            : List<Like>.from(json["likes"]!.map((x) => Like.fromJson(x))),
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
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "rating": rating,
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "likes": likes == null
            ? []
            : List<dynamic>.from(likes!.map((x) => x.toJson())),
        "self_shipping": selfShipping,
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
        "status": status,
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

class Comment {
  String? username;
  String? comment;
  String? image;

  Comment({
    this.username,
    this.comment,
    this.image,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        username: json["username"],
        comment: json["comment"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "comment": comment,
        "image": image,
      };
}

class Like {
  String? id;
  String? name;
  String? photo;

  Like({
    this.id,
    this.name,
    this.photo,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
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
