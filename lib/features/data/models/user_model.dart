// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? passcode;
  String? technicalSkill;
  String? bio;
  String? coverPhoto;
  String? profilePhoto;
  String? activationExpires;
  String? activationToken;
  String? password;
  String? accountStatus;
  String? accountType;
  String? lastName;
  String? firstName;
  String? phone;
  bool? emailActivated;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? userModelId;

  UserModel({
    this.id,
    this.passcode,
    this.technicalSkill,
    this.bio,
    this.coverPhoto,
    this.profilePhoto,
    this.activationExpires,
    this.activationToken,
    this.password,
    this.accountStatus,
    this.accountType,
    this.lastName,
    this.firstName,
    this.phone,
    this.emailActivated,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.userModelId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"],
    passcode: json["passcode"],
    technicalSkill: json["technical_skill"],
    bio: json["bio"],
    coverPhoto: json["cover_photo"],
    profilePhoto: json["profile_photo"],
    activationExpires: json["activationExpires"],
    activationToken: json["activationToken"],
    password: json["password"],
    accountStatus: json["account_status"],
    accountType: json["account_type"],
    lastName: json["last_name"],
    firstName: json["first_name"],
    phone: json["phone"],
    emailActivated: json["email_activated"],
    email: json["email"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    v: json["__v"],
    userModelId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "passcode": passcode,
    "technical_skill": technicalSkill,
    "bio": bio,
    "cover_photo": coverPhoto,
    "profile_photo": profilePhoto,
    "activationExpires": activationExpires,
    "activationToken": activationToken,
    "password": password,
    "account_status": accountStatus,
    "account_type": accountType,
    "last_name": lastName,
    "first_name": firstName,
    "phone": phone,
    "email_activated": emailActivated,
    "email": email,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "__v": v,
    "id": userModelId,
  };
}
