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
  String? product_cost_in_usd;
  List<String>? shippingReqToken;
  List<String>? serviceCode;
  double? totalShippingCost;
  String? total_shipping_cost_in_usd;
  List<String>? courierId;

  SuccesfullTransactionModel({
    this.productCost,
    this.product_cost_in_usd,
    this.shippingReqToken,
    this.serviceCode,
    this.totalShippingCost,
    this.total_shipping_cost_in_usd,
    this.courierId,
  });

  factory SuccesfullTransactionModel.fromJson(Map<String, dynamic> json) =>
      SuccesfullTransactionModel(
        productCost: json["product_cost"],
        product_cost_in_usd: json["product_cost_in_usd"],
        shippingReqToken: json["shipping_req_token"] == null
            ? []
            : List<String>.from(json["shipping_req_token"]!.map((x) => x)),
        serviceCode: json["service_code"] == null
            ? []
            : List<String>.from(json["service_code"]!.map((x) => x)),
        totalShippingCost: json["total_shipping_cost"]?.toDouble(),
        total_shipping_cost_in_usd: json["total_shipping_cost_in_usd"],
        courierId: json["courier_id"] == null
            ? []
            : List<String>.from(json["courier_id"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "product_cost": productCost,
        "product_cost_in_usd": product_cost_in_usd,
        "shipping_req_token": shippingReqToken == null
            ? []
            : List<dynamic>.from(shippingReqToken!.map((x) => x)),
        "service_code": serviceCode == null
            ? []
            : List<dynamic>.from(serviceCode!.map((x) => x)),
        "total_shipping_cost": totalShippingCost,
        "total_shipping_cost_in_usd": total_shipping_cost_in_usd,
        "courier_id": courierId == null
            ? []
            : List<dynamic>.from(courierId!.map((x) => x)),
      };
}
