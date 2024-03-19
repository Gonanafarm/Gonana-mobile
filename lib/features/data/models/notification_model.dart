// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  bool? success;
  List<Datum>? data;

  NotificationModel({
    this.success,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    success: json["success"],
    data: json["success"] == null ?[]:
    List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? []: List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? body;
  String? id;

  Datum({
    this.body,
    this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    body: json["body"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "body": body,
    "_id": id,
  };
}
