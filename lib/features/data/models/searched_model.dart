import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SearchProduct {
  String? id;
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

  SearchProduct({
    this.id,
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
  });

  SearchProduct fromJson(Map<String, dynamic> json) {
    return SearchProduct(
      id: json["_id"],
      selfShipping: json["self_shipping"],
      address: json["address"] == null ? [] : List<Address>.from(json["address"]!.map((x) => Address.fromJson(x))),
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      categories: json["categories"] == null ? [] : List<dynamic>.from(json["categories"]!.map((x) => x)),
      weight: json["weight"],
      quantity: json["quantity"],
      amount: json["product"]["amount"],
      tags: json["tags"] == null ? []  : List<dynamic>.from(json["tags"]!.map((x) => x)),
      body: json["product"]["body"],
      images: json["product"]["images"] == null  ? []  : List<String>.from(json["product"]["images"].map((x) => x)),
      title: json["product"]["title"],
      type: json["type"],
      publisherId: json["publisher_id"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      v: json["__v"],
      productId: json["product"]["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
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
