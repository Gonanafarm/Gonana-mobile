// To parse this JSON data, do
//
//     final discountedProductModel = discountedProductModelFromJson(jsonString);

import 'dart:convert';

DiscountedProductModel discountedProductModelFromJson(String str) =>
    DiscountedProductModel.fromJson(json.decode(str));

String discountedProductModelToJson(DiscountedProductModel data) =>
    json.encode(data.toJson());

class DiscountedProductModel {
  bool? success;
  List<Datum>? data;

  DiscountedProductModel({
    this.success,
    this.data,
  });

  factory DiscountedProductModel.fromJson(Map<String, dynamic> json) =>
      DiscountedProductModel(
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
  String? id;
  Location? location;
  List<dynamic>? categories;
  int? weight;
  int? quantity;
  int? amount;
  List<dynamic>? tags;
  String? body;
  String? title;
  String? deliveryCompany;
  List<dynamic>? images;
  String? type;
  String? publisherId;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? datumId;

  Datum({
    this.id,
    this.location,
    this.categories,
    this.weight,
    this.quantity,
    this.amount,
    this.tags,
    this.body,
    this.title,
    this.deliveryCompany,
    this.images,
    this.type,
    this.publisherId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.datumId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
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
        title: json["title"],
        deliveryCompany: json["delivery_company"],
        images: json["images"] == null
            ? []
            : List<dynamic>.from(json["images"]!.map((x) => x)),
        type: json["type"],
        publisherId: json["publisher_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        v: json["__v"],
        datumId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "location": location?.toJson(),
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
        "weight": weight,
        "quantity": quantity,
        "amount": amount,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "body": body,
        "title": title,
        "delivery_company": deliveryCompany,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "type": type,
        "publisher_id": publisherId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "__v": v,
        "id": datumId,
      };
}

class Location {
  String? type;
  List<num>? coordinates; // Using num to allow both int and double

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<num>.from(json["coordinates"]!.map((x) {
                if (x is int) {
                  return x.toDouble(); // Convert int to double
                } else if (x is double) {
                  return x; // Keep double values as-is
                } else if (x is String) {
                  return double.tryParse(x) ??
                      0; // Attempt to parse string as double
                } else {
                  return 0; // Default to 0 if value is not recognized
                }
              })),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
