// To parse this JSON data, do
//
//     final resetPin = resetPinFromJson(jsonString);

import 'dart:convert';

ResetPin resetPinFromJson(String str) => ResetPin.fromJson(json.decode(str));

String resetPinToJson(ResetPin data) => json.encode(data.toJson());

class ResetPin {
  bool? success;
  String? message;

  ResetPin({
    this.success,
    this.message,
  });

  factory ResetPin.fromJson(Map<String, dynamic> json) => ResetPin(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
