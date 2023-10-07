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
  int? amountSent;
  int? amountSettled;
  DateTime? time;

  Transaction({
    this.sessionId,
    this.type,
    this.amountSent,
    this.amountSettled,
    this.time,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        sessionId: json["sessionId"], // Change this line
        type: json["type"],
        amountSent: json["amountSent"],
        amountSettled: json["amountSettled"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "session_id": sessionId,
        "type": type,
        "amountSent": amountSent,
        "amountSettled": amountSettled,
        "time": time?.toIso8601String(),
      };
}
