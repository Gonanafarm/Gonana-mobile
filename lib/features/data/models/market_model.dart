// To parse this JSON data, do
//
//     final marketModel = marketModelFromJson(jsonString);

import 'dart:convert';

List<MarketModel> marketModelFromJson(String str) => List<MarketModel>.from(
    json.decode(str).map((x) => MarketModel.fromJson(x)));

String marketModelToJson(List<MarketModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MarketModel {
  String? type;
  String? name;
  String? image;
  String? body;
  String? title;
  List<String>? tags;
  String? status;
  int? amount;
  int? quantity;
  List<String>? categories;
  List<Attachment>? attachments;
  Location? location;
  String? createdAt;
  String? updatedAt;

  MarketModel({
    this.type,
    this.name,
    this.image,
    this.body,
    this.title,
    this.tags,
    this.status,
    this.amount,
    this.quantity,
    this.categories,
    this.attachments,
    this.location,
    this.createdAt,
    this.updatedAt,
  });

  factory MarketModel.fromJson(Map<String, dynamic> json) => MarketModel(
        type: json["type"],
        name: json["name"],
        image: json["image"],
        body: json["body"],
        title: json["title"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        status: json["status"],
        amount: json["amount"],
        quantity: json["quantity"],
        categories: json["categories"] == null
            ? []
            : List<String>.from(json["categories"]!.map((x) => x)),
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "image": image,
        "title": title,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "status": status,
        "amount": amount,
        "quantity": quantity,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "location": location?.toJson(),
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Attachment {
  String? status;
  int? size;
  String? fileType;
  String? source;
  String? contentUrl;

  Attachment({
    this.status,
    this.size,
    this.fileType,
    this.source,
    this.contentUrl,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        status: json["status"],
        size: json["size"],
        fileType: json["file_type"],
        source: json["source"],
        contentUrl: json["content_url"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "size": size,
        "file_type": fileType,
        "source": source,
        "content_url": contentUrl,
      };
}

class Location {
  String? type;
  List<String>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<String>.from(json["coordinates"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
