// To parse this JSON data, do
//
//     final getBalanceModel = getBalanceModelFromJson(jsonString);

import 'dart:convert';

GetBalanceModel getBalanceModelFromJson(String str) =>
    GetBalanceModel.fromJson(json.decode(str));

String getBalanceModelToJson(GetBalanceModel data) =>
    json.encode(data.toJson());

class GetBalanceModel {
  bool? success;
  String? balance;

  GetBalanceModel({
    this.success,
    this.balance,
  });

  factory GetBalanceModel.fromJson(Map<String, dynamic> json) =>
      GetBalanceModel(
        success: json["success"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "balance": balance,
      };
}
