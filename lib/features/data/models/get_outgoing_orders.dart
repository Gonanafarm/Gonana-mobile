// To parse this JSON data, do
//
//     final getOutgoingOrdersModel = getOutgoingOrdersModelFromJson(jsonString);

import 'dart:convert';

GetOutgoingOrdersModel getOutgoingOrdersModelFromJson(String str) =>
    GetOutgoingOrdersModel.fromJson(json.decode(str));

String getOutgoingOrdersModelToJson(GetOutgoingOrdersModel data) =>
    json.encode(data.toJson());

class GetOutgoingOrdersModel {
  bool? success;
  List<Datum>? data;

  GetOutgoingOrdersModel({
    this.success,
    this.data,
  });

  factory GetOutgoingOrdersModel.fromJson(Map<String, dynamic> json) =>
      GetOutgoingOrdersModel(
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
  String? status;
  String? id;
  String? paymentMethod;
  String? type;
  String? shipbubbleId;
  String? productDescription;
  String? farmerId;
  int? productAmount;
  int? quantity;
  String? productId;
  String? productName;
  List<String>? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? datumId;

  Datum({
    this.status,
    this.id,
    this.paymentMethod,
    this.type,
    this.shipbubbleId,
    this.productDescription,
    this.farmerId,
    this.productAmount,
    this.quantity,
    this.productId,
    this.productName,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.datumId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        status: json["status"],
        id: json["_id"],
        paymentMethod: json["payment_method"],
        type: json["type"],
        shipbubbleId: json["shipbubble_id"],
        productDescription: json["product_description"],
        farmerId: json["farmer_id"],
        productAmount: json["product_amount"],
        quantity: json["quantity"],
        productId: json["product_id"],
        productName: json["product_name"],
        image: json["image"] == null
            ? []
            : List<String>.from(json["image"]!.map((x) => x)),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        v: json["__v"],
        datumId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "payment_method": paymentMethod,
        "type": type,
        "shipbubble_id": shipbubbleId,
        "product_description": productDescription,
        "farmer_id": farmerId,
        "product_amount": productAmount,
        "quantity": quantity,
        "product_id": productId,
        "product_name": productName,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
        "id": datumId,
      };
}
