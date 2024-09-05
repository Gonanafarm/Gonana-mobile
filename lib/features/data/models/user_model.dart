import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? profilePhoto;
  String? coverPhoto;
  String? accountType;
  String? accountStatus;
  String? bio;
  String? phone;
  bool? emailActivated;
  String? virtualAccountNumber;
  String? virtualAccountBankName;
  String? virtual_account_name;
  List<dynamic>? address;
  String? ccdWallet;
  String? arbitrumWallet;
  String? arbitrumWalletBalanceInNgn;
  String? arbitrumWalletAddress;
  String? ccdWalletAddress;
  String? ccdWalletBalanceInNgn;
  String? country;

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
    this.ccdWallet,
    this.arbitrumWallet,
    this.arbitrumWalletBalanceInNgn,
    this.arbitrumWalletAddress,
    this.ccdWalletAddress,
    this.ccdWalletBalanceInNgn,
    this.country,
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
        ccdWallet: json["ccd_wallet"],
        arbitrumWallet: json["arbitrum_wallet"],
        arbitrumWalletBalanceInNgn: json["arbitrumWalletBalanceInNgn"],
        arbitrumWalletAddress: json["arbitrum_wallet_address"],
        ccdWalletAddress: json["ccd_wallet_address"],
        ccdWalletBalanceInNgn: json["ccdWalletBalanceInNgn"],
        country: json["country"],
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
        "ccd_wallet": ccdWallet,
        "arbitrum_wallet": arbitrumWallet,
        "arbitrumWalletBalanceInNgn": arbitrumWalletBalanceInNgn,
        "arbitrum_wallet_address": arbitrumWalletAddress,
        "ccd_wallet_address": ccdWalletAddress,
        "ccdWalletBalanceInNgn": ccdWalletBalanceInNgn,
        "country": country,
      };
}
