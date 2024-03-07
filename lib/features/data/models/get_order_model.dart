// To parse this JSON data, do
//
//     final getOrdersModel = getOrdersModelFromJson(jsonString);

import 'dart:convert';

GetOrdersModel getOrdersModelFromJson(String str) =>
    GetOrdersModel.fromJson(json.decode(str));

String getOrdersModelToJson(GetOrdersModel data) => json.encode(data.toJson());

class GetOrdersModel {
  bool? success;
  List<Datum>? data;

  GetOrdersModel({
    this.success,
    this.data,
  });

  factory GetOrdersModel.fromJson(Map<String, dynamic> json) => GetOrdersModel(
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
  String? productId;
  String? productDescription;
  String? customerId;
  String? farmerId;
  String? productName;
  int? productAmount;
  int? quantity;
  String? shipbubbleId;
  String? type;
  String? status;
  List<String>? image;
  String? paymentMethod;
  bool? selfShipping;
  bool? farmerShipped;
  bool? customerReceived;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.productId,
    this.productDescription,
    this.customerId,
    this.farmerId,
    this.productName,
    this.productAmount,
    this.quantity,
    this.shipbubbleId,
    this.type,
    this.status,
    this.image,
    this.paymentMethod,
    this.selfShipping,
    this.farmerShipped,
    this.customerReceived,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        productId: json["product_id"],
        productDescription: json["product_description"],
        customerId: json["customer_id"],
        farmerId: json["farmer_id"],
        productName: json["product_name"],
        productAmount: json["product_amount"],
        quantity: json["quantity"],
        shipbubbleId: json["shipbubble_id"],
        type: json["type"],
        status: json["status"],
        image: json["image"] == null
            ? []
            : List<String>.from(json["image"]!.map((x) => x)),
        paymentMethod: json["payment_method"],
        selfShipping: json["self_shipping"],
        farmerShipped: json["farmer_shipped"],
        customerReceived: json["customer_received"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product_id": productId,
        "product_description": productDescription,
        "customer_id": customerId,
        "farmer_id": farmerId,
        "product_name": productName,
        "product_amount": productAmount,
        "quantity": quantity,
        "shipbubble_id": shipbubbleId,
        "type": type,
        "status": status,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "payment_method": paymentMethod,
        "self_shipping": selfShipping,
        "farmer_shipped": farmerShipped,
        "customer_received": customerReceived,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
