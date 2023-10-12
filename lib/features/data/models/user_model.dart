// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
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
  String? virtual_account_name;
  List<dynamic>? address;

  UserModel({
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
    this.virtual_account_name,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
    virtual_account_name: json["virtual_account_name"],
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
        "virtual_account_name": virtualAccountBankName,
        "address":
            address == null ? [] : List<dynamic>.from(address!.map((x) => x)),
      };
}
