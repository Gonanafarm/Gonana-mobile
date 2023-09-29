// To parse this JSON data, do
//
//     final getOrderModel = getOrderModelFromJson(jsonString);

import 'dart:convert';

List<GetOrderModel> getOrderModelFromJson(String str) =>
    List<GetOrderModel>.from(
        json.decode(str).map((x) => GetOrderModel.fromJson(x)));

String getOrderModelToJson(List<GetOrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetOrderModel {
  List<Item>? items;
  int? sumTotal;
  String? paymentMethod;
  String? paymentUrl;
  String? paymentStatus;
  String? status;
  String? createdAt;
  String? updatedAt;

  GetOrderModel({
    this.items,
    this.sumTotal,
    this.paymentMethod,
    this.paymentUrl,
    this.paymentStatus,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory GetOrderModel.fromJson(Map<String, dynamic> json) => GetOrderModel(
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        sumTotal: json["sum_total"],
        paymentMethod: json["payment_method"],
        paymentUrl: json["payment_url"],
        paymentStatus: json["payment_status"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "sum_total": sumTotal,
        "payment_method": paymentMethod,
        "payment_url": paymentUrl,
        "payment_status": paymentStatus,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Item {
  String? image;
  String? productName;
  String? productId;
  int? quantity;
  int? amount;

  Item({
    this.image,
    this.productName,
    this.productId,
    this.quantity,
    this.amount,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        image: json["image"],
        productName: json["product_name"],
        productId: json["product_id"],
        quantity: json["quantity"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "product_name": productName,
        "product_id": productId,
        "quantity": quantity,
        "amount": amount,
      };
}
