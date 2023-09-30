// To parse this JSON data, do
//
//     final courierModel = courierModelFromJson(jsonString);

import 'dart:convert';

CourierModel courierModelFromJson(String str) =>
    CourierModel.fromJson(json.decode(str));

String courierModelToJson(CourierModel data) => json.encode(data.toJson());

class CourierModel {
  bool? success;
  List<Courier>? couriers;

  CourierModel({
    this.success,
    this.couriers,
  });

  factory CourierModel.fromJson(Map<String, dynamic> json) => CourierModel(
        success: json["success"],
        couriers: json["couriers"] == null
            ? []
            : List<Courier>.from(
                json["couriers"]!.map((x) => Courier.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "couriers": couriers == null
            ? []
            : List<dynamic>.from(couriers!.map((x) => x.toJson())),
      };
}

class Courier {
  String? name;
  String? pinImage;
  String? serviceCode;

  Courier({
    this.name,
    this.pinImage,
    this.serviceCode,
  });

  factory Courier.fromJson(Map<String, dynamic> json) => Courier(
        name: json["name"],
        pinImage: json["pin_image"],
        serviceCode: json["service_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "pin_image": pinImage,
        "service_code": serviceCode,
      };
}
