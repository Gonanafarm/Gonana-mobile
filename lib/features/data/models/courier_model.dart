import 'dart:convert';

List<CourierModel> courierModelFromJson(String str) => 
  List<CourierModel>.from(json.decode(str).map((x) => 
    CourierModel.fromJson(x)));

String courierModelToJson(List<CourierModel> data) => 
  json.encode(List<dynamic>.from(data.map((x) => 
    x.toJson())));

class CourierModel{
  String? name;
  String? pin_image;
  String? service_code;

  CourierModel({
    this.name,
    this.pin_image,
    this.service_code,
  });

  factory CourierModel.fromJson(Map<String, dynamic>json) => CourierModel(
    name: json["name"],
    pin_image: json["pin_image"],
    service_code: json["service_code"]
  );

  Map<String, dynamic> toJson() => {
    "name" : name,
    "Pin_image" : pin_image,
    "service_code" : service_code
  };
}
