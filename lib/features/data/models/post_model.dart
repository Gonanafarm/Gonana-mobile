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
  String? id;
  String? deliveryCompany;
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

  Product({
    this.id,
    this.deliveryCompany,
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
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        deliveryCompany: json["delivery_company"],
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
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "delivery_company": deliveryCompany,
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
      };
}

class Location {
  String? type;
  List<int>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: (json["coordinates"] as List<dynamic>?)
            ?.map((dynamic value) => value is int
                ? value
                : int.tryParse(value.toString()) ??
                    0) // Handle non-integer values by providing a default value (0 in this case)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
