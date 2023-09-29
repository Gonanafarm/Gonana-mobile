// To parse this JSON data, do
//
//     final userPostModel = userPostModelFromJson(jsonString);

import 'dart:convert';

UserPostModel userPostModelFromJson(String str) =>
    UserPostModel.fromJson(json.decode(str));

String userPostModelToJson(UserPostModel data) => json.encode(data.toJson());

class UserPostModel {
  bool? success;
  List<Datum>? data;

  UserPostModel({
    this.success,
    this.data,
  });

  factory UserPostModel.fromJson(Map<String, dynamic> json) => UserPostModel(
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
  String? deliveryCompany;
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
  String? datumId;

  Datum({
    this.id,
    this.location,
    this.categories,
    this.weight,
    this.quantity,
    this.amount,
    this.deliveryCompany,
    this.tags,
    this.body,
    this.images,
    this.title,
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
        deliveryCompany: json["delivery_company"],
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
        "delivery_company": deliveryCompany,
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
        "id": datumId,
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
        coordinates: json["coordinates"] == null
            ? []
            : List<int>.from(json["coordinates"].map(
                (dynamic value) {
                  if (value is int) {
                    return value;
                  } else if (value is String) {
                    return int.tryParse(value) ??
                        0; // Convert string to int, default to 0 if parsing fails
                  }
                  return 0; // Default value if not int or string
                },
              )),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
