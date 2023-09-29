// To parse this JSON data, do
//
//     final getPostModel = getPostModelFromJson(jsonString);

import 'dart:convert';

GetPostModel getPostModelFromJson(String str) =>
    GetPostModel.fromJson(json.decode(str));

String getPostModelToJson(GetPostModel data) => json.encode(data.toJson());

class GetPostModel {
  String? type;
  String? name;
  String? image;
  String? body;
  String? title;
  String? status;
  int? amount;
  List<String>? categories;
  List<Attachment>? attachments;
  Location? location;
  String? createdAt;
  String? updatedAt;

  GetPostModel({
    this.type,
    this.name,
    this.image,
    this.body,
    this.title,
    this.status,
    this.amount,
    this.categories,
    this.attachments,
    this.location,
    this.createdAt,
    this.updatedAt,
  });

  factory GetPostModel.fromJson(Map<String, dynamic> json) => GetPostModel(
        type: json["type"],
        name: json["name"],
        image: json["image"],
        body: json["body"],
        title: json["title"],
        status: json["status"],
        amount: json["amount"],
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
        "body": body,
        "title": title,
        "status": status,
        "amount": amount,
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
