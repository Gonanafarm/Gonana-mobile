// To parse this JSON data, do
//
//     final virtualAccountModel = virtualAccountModelFromJson(jsonString);

import 'dart:convert';

VirtualAccountModel virtualAccountModelFromJson(String str) =>
    VirtualAccountModel.fromJson(json.decode(str));

String virtualAccountModelToJson(VirtualAccountModel data) =>
    json.encode(data.toJson());

class VirtualAccountModel {
  String? token;
  User? user;

  VirtualAccountModel({
    this.token,
    this.user,
  });

  factory VirtualAccountModel.fromJson(Map<String, dynamic> json) =>
      VirtualAccountModel(
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
      };
}

class User {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? accountType;
  String? profilePhoto;
  String? coverPhoto;
  String? accountStatus;
  String? bio;
  String? phone;
  bool? emailActivated;
  String? virtualAccountNumber;
  String? virtualAccountBankName;
  List<dynamic>? address;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.accountType,
    this.profilePhoto,
    this.coverPhoto,
    this.accountStatus,
    this.bio,
    this.phone,
    this.emailActivated,
    this.virtualAccountNumber,
    this.virtualAccountBankName,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        accountType: json["account_type"],
        profilePhoto: json["profile_photo"],
        coverPhoto: json["cover_photo"],
        accountStatus: json["account_status"],
        bio: json["bio"],
        phone: json["phone"],
        emailActivated: json["email_activated"],
        virtualAccountNumber: json["virtual_account_number"],
        virtualAccountBankName: json["virtual_account_bank_name"],
        address: json["address"] == null
            ? []
            : List<dynamic>.from(json["address"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "account_type": accountType,
        "profile_photo": profilePhoto,
        "cover_photo": coverPhoto,
        "account_status": accountStatus,
        "bio": bio,
        "phone": phone,
        "email_activated": emailActivated,
        "virtual_account_number": virtualAccountNumber,
        "virtual_account_bank_name": virtualAccountBankName,
        "address":
            address == null ? [] : List<dynamic>.from(address!.map((x) => x)),
      };
}
