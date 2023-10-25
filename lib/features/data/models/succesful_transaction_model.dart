// To parse this JSON data, do
//
//     final succesfullTransactionModel = succesfullTransactionModelFromJson(jsonString);

import 'dart:convert';

SuccesfullTransactionModel succesfullTransactionModelFromJson(String str) =>
    SuccesfullTransactionModel.fromJson(json.decode(str));

String succesfullTransactionModelToJson(SuccesfullTransactionModel data) =>
    json.encode(data.toJson());

class SuccesfullTransactionModel {
  int? productCost;
  List<String>? shippingReqToken;
  List<String>? serviceCode;
  double? totalShippingCost;
  List<String>? courierId;

  SuccesfullTransactionModel({
    this.productCost,
    this.shippingReqToken,
    this.serviceCode,
    this.totalShippingCost,
    this.courierId,
  });

  factory SuccesfullTransactionModel.fromJson(Map<String, dynamic> json) =>
      SuccesfullTransactionModel(
        productCost: json["product_cost"],
        shippingReqToken: json["shipping_req_token"] == null
            ? []
            : List<String>.from(json["shipping_req_token"]!.map((x) => x)),
        serviceCode: json["service_code"] == null
            ? []
            : List<String>.from(json["service_code"]!.map((x) => x)),
        totalShippingCost: json["total_shipping_cost"]?.toDouble(),
        courierId: json["courier_id"] == null
            ? []
            : List<String>.from(json["courier_id"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "product_cost": productCost,
        "shipping_req_token": shippingReqToken == null
            ? []
            : List<dynamic>.from(shippingReqToken!.map((x) => x)),
        "service_code": serviceCode == null
            ? []
            : List<dynamic>.from(serviceCode!.map((x) => x)),
        "total_shipping_cost": totalShippingCost,
        "courier_id": courierId == null
            ? []
            : List<dynamic>.from(courierId!.map((x) => x)),
      };
}
