// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
  bool? success;
  List<Datum>? data;

  BankModel({
    this.success,
    this.data,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
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
  String? bankCode;
  String? bankName;
  String? bankShortName;
  String? bankIdentifyCode;
  String? bankCode2;

  Datum({
    this.bankCode,
    this.bankName,
    this.bankShortName,
    this.bankIdentifyCode,
    this.bankCode2,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bankCode: json["bankCode"],
        bankName: json["bankName"],
        bankShortName: json["bankShortName"],
        bankIdentifyCode: json["bankIdentifyCode"],
        bankCode2: json["bankCode2"],
      );

  Map<String, dynamic> toJson() => {
        "bankCode": bankCode,
        "bankName": bankName,
        "bankShortName": bankShortName,
        "bankIdentifyCode": bankIdentifyCode,
        "bankCode2": bankCode2,
      };
}
