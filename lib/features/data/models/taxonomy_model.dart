import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

// List<TaxonomyModel> taxonomyModelFromJson(String str) =>
//     List<TaxonomyModel>.from(
//         json.decode(str.toString()).map((x) => TaxonomyModel.fromJson(x)));

// String taxonomyModelToJson(List<TaxonomyModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


@JsonSerializable()
class TaxonomyModel {
  String? id;
  String? image;
  String? parentId;
  String? description;
  String? name;
  String? taxonomyContext;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? taxonomyModelId;

  TaxonomyModel({
    this.id,
    this.image,
    this.parentId,
    this.description,
    this.name,
    this.taxonomyContext,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.taxonomyModelId,
  });

  TaxonomyModel fromJson(Map<String, dynamic> json) {
    return TaxonomyModel(
      id: json["_id"],
      image: json["image"],
      parentId: json["parent_id"],
      description: json["description"],
      name: json["name"],
      taxonomyContext: json["taxonomy_context"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      v: json["__v"],
      taxonomyModelId: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "parent_id": parentId,
        "description": description,
        "name": name,
        "taxonomy_context": taxonomyContext,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
        "id": taxonomyModelId,
      };
}
