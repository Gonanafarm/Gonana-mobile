// To parse this JSON data, do
//
//     final resolveBankModel = resolveBankModelFromJson(jsonString);

import 'dart:convert';

ResolveBankModel resolveBankModelFromJson(String str) => ResolveBankModel.fromJson(json.decode(str));

String resolveBankModelToJson(ResolveBankModel data) => json.encode(data.toJson());

class ResolveBankModel {
  bool? success;
  ResolveBankModelData? data;
  String? bankCode;

  ResolveBankModel({
    this.success,
    this.data,
    this.bankCode,
  });

  factory ResolveBankModel.fromJson(Map<String, dynamic> json) => ResolveBankModel(
    success: json["success"],
    data: json["data"] == null ? null : ResolveBankModelData.fromJson(json["data"]),
    bankCode: json["bankCode"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "bankCode": bankCode,
  };
}

class ResolveBankModelData {
  bool? result;
  DataData? data;

  ResolveBankModelData({
    this.result,
    this.data,
  });

  factory ResolveBankModelData.fromJson(Map<String, dynamic> json) => ResolveBankModelData(
    result: json["result"],
    data: json["data"] == null ? null : DataData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data": data?.toJson(),
  };
}

class DataData {
  String? sessionId;
  String? destinationInstitutionCode;
  String? channelCode;
  String? accountNumber;
  String? accountName;
  String? bankVerificationNumber;
  String? kycLevel;
  String? responseCode;

  DataData({
    this.sessionId,
    this.destinationInstitutionCode,
    this.channelCode,
    this.accountNumber,
    this.accountName,
    this.bankVerificationNumber,
    this.kycLevel,
    this.responseCode,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    sessionId: json["sessionID"],
    destinationInstitutionCode: json["destinationInstitutionCode"],
    channelCode: json["channelCode"],
    accountNumber: json["accountNumber"],
    accountName: json["accountName"],
    bankVerificationNumber: json["bankVerificationNumber"],
    kycLevel: json["kycLevel"],
    responseCode: json["responseCode"],
  );

  Map<String, dynamic> toJson() => {
    "sessionID": sessionId,
    "destinationInstitutionCode": destinationInstitutionCode,
    "channelCode": channelCode,
    "accountNumber": accountNumber,
    "accountName": accountName,
    "bankVerificationNumber": bankVerificationNumber,
    "kycLevel": kycLevel,
    "responseCode": responseCode,
  };
}
