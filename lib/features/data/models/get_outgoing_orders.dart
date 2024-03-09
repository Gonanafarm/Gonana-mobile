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
  String? id;
  String? paymentMethod;
  String? customerId;
  String? status;
  String? type;
  bool? selfShipping;
  String? shipbubbleId;
  String? productDescription;
  bool? customerReceived;
  bool? farmerShipped;
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
  DateTime? farmer_ship_date;
  DateTime? customer_received_date;

  Datum({
    this.id,
    this.paymentMethod,
    this.customerId,
    this.status,
    this.type,
    this.selfShipping,
    this.shipbubbleId,
    this.productDescription,
    this.customerReceived,
    this.farmerShipped,
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
    this.farmer_ship_date,
    this.customer_received_date,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        paymentMethod: json["payment_method"],
        customerId: json["customer_id"],
        status: json["status"],
        type: json["type"],
        selfShipping: json["self_shipping"],
        shipbubbleId: json["shipbubble_id"],
        productDescription: json["product_description"],
        customerReceived: json["customer_received"],
        farmerShipped: json["farmer_shipped"],
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
        farmer_ship_date: json["farmer_ship_date"] == null
            ? null
            : DateTime.parse(json["farmer_ship_date"]),
        customer_received_date: json["customer_received_date"] == null
            ? null
            : DateTime.parse(json["customer_received_date"]),
        datumId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "payment_method": paymentMethod,
        "customer_id": customerId,
        "status": status,
        "type": type,
        "self_shipping": selfShipping,
        "shipbubble_id": shipbubbleId,
        "product_description": productDescription,
        "customer_received": customerReceived,
        "farmer_shipped": farmerShipped,
        "farmer_id": farmerId,
        "product_amount": productAmount,
        "quantity": quantity,
        "product_id": productId,
        "product_name": productName,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "farmer_ship_date": farmer_ship_date?.toIso8601String(),
        "customer_received_date": customer_received_date?.toIso8601String(),
        "__v": v,
        "id": datumId,
      };
}
