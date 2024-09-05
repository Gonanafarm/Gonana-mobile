// To parse this JSON data, do
//
//     final getCryptoBalance = getCryptoBalanceFromJson(jsonString);

import 'dart:convert';

GetCcdBalance getCcdBalanceFromJson(String str) =>
    GetCcdBalance.fromJson(json.decode(str));

String getCcdBalanceToJson(GetCcdBalance data) =>
    json.encode(data.toJson());

class GetCcdBalance {
  bool? success;
  String? cryptoWalletBalanceInNgn;
  String? cryptoWalletBalanceInCcd;

  GetCcdBalance({
    this.success,
    this.cryptoWalletBalanceInNgn,
    this.cryptoWalletBalanceInCcd,
  });

  factory GetCcdBalance.fromJson(Map<String, dynamic> json) =>
      GetCcdBalance(
        success: json["success"],
        cryptoWalletBalanceInNgn: json["cryptoWalletBalanceInNgn"],
        cryptoWalletBalanceInCcd: json["cryptoWalletBalanceInCcd"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "cryptoWalletBalanceInNgn": cryptoWalletBalanceInNgn,
        "cryptoWalletBalanceInCcd": cryptoWalletBalanceInCcd,
      };
}


GetEthBalance getEthBalanceFromJson(String str) =>
    GetEthBalance.fromJson(json.decode(str));

String getEthBalanceToJson(GetCcdBalance data) =>
    json.encode(data.toJson());

class GetEthBalance {
  bool? success;
  String? cryptoWalletBalanceInNgn;
  String? cryptoWalletBalanceInEth;

  GetEthBalance({
    this.success,
    this.cryptoWalletBalanceInNgn,
    this.cryptoWalletBalanceInEth,
  });

  factory GetEthBalance.fromJson(Map<String, dynamic> json) =>
      GetEthBalance(
        success: json["success"],
        cryptoWalletBalanceInNgn: json["cryptoWalletBalanceInNgn"],
        cryptoWalletBalanceInEth: json["cryptoWalletBalanceInEth"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "cryptoWalletBalanceInNgn": cryptoWalletBalanceInNgn,
    "cryptoWalletBalanceInEth": cryptoWalletBalanceInEth,
  };
}
