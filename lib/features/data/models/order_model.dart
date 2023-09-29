// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

OrdersModel ordersModelFromJson(String str) =>
    OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  List<Order>? orders;

  OrdersModel({
    this.orders,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  String? id;
  int? units;

  Order({
    this.id,
    this.units,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        units: json["units"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "units": units,
      };
}
