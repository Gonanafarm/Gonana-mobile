import 'dart:convert';

GetOrdersModel getOrdersModelFromJson(String str) =>
    GetOrdersModel.fromJson(json.decode(str));

String getOrdersModelToJson(GetOrdersModel data) => json.encode(data.toJson());

class GetOrdersModel {
  List<Order>? orders;

  GetOrdersModel({
    this.orders,
  });

  factory GetOrdersModel.fromJson(Map<String, dynamic> json) => GetOrdersModel(
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
  String? paymentMethod;
  String? customerId;
  int? amount;
  int? quantity;
  String? productId;
  String? productName;
  List<String>? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? orderId;

  Order({
    this.id,
    this.paymentMethod,
    this.customerId,
    this.amount,
    this.quantity,
    this.productId,
    this.productName,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.orderId,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"],
        paymentMethod: json["payment_method"],
        customerId: json["customer_id"],
        amount: json["amount"],
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
        orderId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "payment_method": paymentMethod,
        "customer_id": customerId,
        "amount": amount,
        "quantity": quantity,
        "product_id": productId,
        "product_name": productName,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
        "id": orderId,
      };
}
