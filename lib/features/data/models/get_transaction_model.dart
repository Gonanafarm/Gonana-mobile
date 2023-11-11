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
  String? id;
  String? userId;
  Transactions? transactions;
  DateTime? createdAt;
  DateTime? updatedAt;

  Transaction({
    this.id,
    this.userId,
    this.transactions,
    this.createdAt,
    this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["_id"],
        userId: json["userId"],
        transactions: json["transactions"] == null
            ? null
            : Transactions.fromJson(json["transactions"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "transactions": transactions?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Transactions {
  String? sessionId;
  String? type;
  int? amountSent;
  int? amountSettled;
  DateTime? time;
  String? id;
  String? narration;

  Transactions({
    this.sessionId,
    this.type,
    this.amountSent,
    this.amountSettled,
    this.time,
    this.id,
    this.narration,
  });

  factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        sessionId: json["Session_id"],
        type: json["Type"],
        amountSent: json["AmountSent"],
        amountSettled: json["AmountSettled"],
        time: json["Time"] == null ? null : DateTime.parse(json["Time"]),
        id: json["_id"],
        narration: json["narration"],
      );

  Map<String, dynamic> toJson() => {
        "Session_id": sessionId,
        "Type": type,
        "AmountSent": amountSent,
        "AmountSettled": amountSettled,
        "Time": time?.toIso8601String(),
        "_id": id,
        "narration": narration,
      };
}
