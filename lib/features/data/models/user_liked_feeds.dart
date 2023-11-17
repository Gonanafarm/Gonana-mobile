// To parse this JSON data, do
//
//     final userLikedFeeds = userLikedFeedsFromJson(jsonString);

import 'dart:convert';

UserLikedFeeds userLikedFeedsFromJson(String str) =>
    UserLikedFeeds.fromJson(json.decode(str));

String userLikedFeedsToJson(UserLikedFeeds data) => json.encode(data.toJson());

class UserLikedFeeds {
  bool? success;
  List<Datum>? data;

  UserLikedFeeds({
    this.success,
    this.data,
  });

  factory UserLikedFeeds.fromJson(Map<String, dynamic> json) => UserLikedFeeds(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
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
  String? virtualAccountName;
  List<Address>? address;

  Datum({
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
    this.virtualAccountName,
    this.address,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        virtualAccountName: json["virtual_account_name"],
        address: json["address"] == null
            ? []
            : List<Address>.from(
                json["address"]!.map((x) => Address.fromJson(x))),
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
        "virtual_account_name": virtualAccountName,
        "address": address == null
            ? []
            : List<dynamic>.from(address!.map((x) => x.toJson())),
      };
}

class Address {
  String? address;
  int? code;

  Address({
    this.address,
    this.code,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "code": code,
      };
}
