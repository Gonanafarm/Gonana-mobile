// To parse this JSON data, do
//
//     final getTransactionModel = getTransactionModelFromJson(jsonString);

import 'dart:convert';

GetTransactionModel getTransactionModelFromJson(String str) =>
    GetTransactionModel.fromJson(json.decode(str));

String getTransactionModelToJson(GetTransactionModel data) =>
    json.encode(data.toJson());

class GetTransactionModel {
  bool? success;
  List<Transaction>? transactions;

  GetTransactionModel({
    this.success,
    this.transactions,
  });

  factory GetTransactionModel.fromJson(Map<String, dynamic> json) =>
      GetTransactionModel(
        success: json["success"],
        transactions: json["transactions"] == null
            ? []
            : List<Transaction>.from(
                json["transactions"]!.map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x.toJson())),
      };
}

class Transaction {
  String? sessionId;
  String? type;
  int? amountSettled;
  DateTime? time;
  String? id;

  Transaction({
    this.sessionId,
    this.type,
    this.amountSettled,
    this.time,
    this.id,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        sessionId: json["Session_id"],
        type: json["Type"],
        amountSettled: json["AmountSettled"],
        time: json["Time"] == null ? null : DateTime.parse(json["Time"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "Session_id": sessionId,
        "Type": type,
        "AmountSettled": amountSettled,
        "Time": time?.toIso8601String(),
        "_id": id,
      };
}
