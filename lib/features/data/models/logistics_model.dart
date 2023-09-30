// To parse this JSON data, do
//
//     final succesfullTransactionModel = succesfullTransactionModelFromJson(jsonString);

import 'dart:convert';

SuccesfullTransactionModel succesfullTransactionModelFromJson(String str) =>
    SuccesfullTransactionModel.fromJson(json.decode(str));

String succesfullTransactionModelToJson(SuccesfullTransactionModel data) =>
    json.encode(data.toJson());

class SuccesfullTransactionModel {
  String? accountNumber;
  String? bankName;
  String? accountName;
  int? productCost;
  String? shippingReqToken;
  String? courierId;
  String? courierName;
  String? courierImage;
  String? courierCode;
  double? totalShippingCost;
  CheckoutData? checkoutData;

  SuccesfullTransactionModel({
    this.accountNumber,
    this.bankName,
    this.accountName,
    this.productCost,
    this.shippingReqToken,
    this.courierId,
    this.courierName,
    this.courierImage,
    this.courierCode,
    this.totalShippingCost,
    this.checkoutData,
  });

  factory SuccesfullTransactionModel.fromJson(Map<String, dynamic> json) =>
      SuccesfullTransactionModel(
        accountNumber: json["accountNumber"],
        bankName: json["bankName"],
        accountName: json["accountName"],
        productCost: json["product_cost"],
        shippingReqToken: json["shipping_req_token"],
        courierId: json["courier_id"],
        courierName: json["courier_name"],
        courierImage: json["courier_image"],
        courierCode: json["courier_code"],
        totalShippingCost: json["total_shipping_cost"]?.toDouble(),
        checkoutData: json["checkout_data"] == null
            ? null
            : CheckoutData.fromJson(json["checkout_data"]),
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "bankName": bankName,
        "accountName": accountName,
        "product_cost": productCost,
        "shipping_req_token": shippingReqToken,
        "courier_id": courierId,
        "courier_name": courierName,
        "courier_image": courierImage,
        "courier_code": courierCode,
        "total_shipping_cost": totalShippingCost,
        "checkout_data": checkoutData?.toJson(),
      };
}

class CheckoutData {
  Ship? shipFrom;
  Ship? shipTo;
  String? currency;
  int? packageAmount;
  int? packageWeight;
  String? pickupDate;

  CheckoutData({
    this.shipFrom,
    this.shipTo,
    this.currency,
    this.packageAmount,
    this.packageWeight,
    this.pickupDate,
  });

  factory CheckoutData.fromJson(Map<String, dynamic> json) => CheckoutData(
        shipFrom:
            json["ship_from"] == null ? null : Ship.fromJson(json["ship_from"]),
        shipTo: json["ship_to"] == null ? null : Ship.fromJson(json["ship_to"]),
        currency: json["currency"],
        packageAmount: json["package_amount"],
        packageWeight: json["package_weight"],
        pickupDate: json["pickup_date"],
      );

  Map<String, dynamic> toJson() => {
        "ship_from": shipFrom?.toJson(),
        "ship_to": shipTo?.toJson(),
        "currency": currency,
        "package_amount": packageAmount,
        "package_weight": packageWeight,
        "pickup_date": pickupDate,
      };
}

class Ship {
  String? name;
  String? phone;
  String? email;
  String? address;

  Ship({
    this.name,
    this.phone,
    this.email,
    this.address,
  });

  factory Ship.fromJson(Map<String, dynamic> json) => Ship(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "address": address,
      };
}
