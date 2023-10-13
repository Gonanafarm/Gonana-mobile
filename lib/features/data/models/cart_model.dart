// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  bool? success;
  List<Product>? products;

  CartModel({
    this.success,
    this.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        success: json["success"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  String? id;
  String? title;
  int? amount;
  int? unit;
  String? body;
  String? from;
  List<String>? image;

  Product({
    this.id,
    this.title,
    this.amount,
    this.unit,
    this.body,
    this.from,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["Title"],
        amount: json["Amount"],
        body: json["body"],
        from: json["From"],
        image: json["image"] == null
            ? []
            : List<String>.from(json["image"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Title": title,
        "Amount": amount,
        "body": body,
        "From": from,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
      };
}
