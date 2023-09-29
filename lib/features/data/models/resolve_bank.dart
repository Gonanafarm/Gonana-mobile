// To parse this JSON data, do
//
//     final resolveBankModel = resolveBankModelFromJson(jsonString);

import 'dart:convert';

ResolveBankModel resolveBankModelFromJson(String str) =>
    ResolveBankModel.fromJson(json.decode(str));

String resolveBankModelToJson(ResolveBankModel data) =>
    json.encode(data.toJson());

class ResolveBankModel {
  ResolveBankModelData? data;
  String? bankCode;

  ResolveBankModel({
    this.data,
    this.bankCode,
  });

  factory ResolveBankModel.fromJson(Map<String, dynamic> json) =>
      ResolveBankModel(
        data: json["data"] == null
            ? null
            : ResolveBankModelData.fromJson(json["data"]),
        bankCode: json["bankCode"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "bankCode": bankCode,
      };
}

class ResolveBankModelData {
  String? responseCode;
  String? responseMessage;
  DataData? data;

  ResolveBankModelData({
    this.responseCode,
    this.responseMessage,
    this.data,
  });

  factory ResolveBankModelData.fromJson(Map<String, dynamic> json) =>
      ResolveBankModelData(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "data": data?.toJson(),
      };
}

class DataData {
  String? accountNumber;
  String? accountName;
  String? sessionId;

  DataData({
    this.accountNumber,
    this.accountName,
    this.sessionId,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
        sessionId: json["sessionId"],
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "accountName": accountName,
        "sessionId": sessionId,
      };
}
