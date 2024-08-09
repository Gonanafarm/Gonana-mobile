// To parse this JSON data, do
//
//     final getCryptoBalance = getCryptoBalanceFromJson(jsonString);

import 'dart:convert';

GetCryptoBalance getCryptoBalanceFromJson(String str) =>
    GetCryptoBalance.fromJson(json.decode(str));

String getCryptoBalanceToJson(GetCryptoBalance data) =>
    json.encode(data.toJson());

class GetCryptoBalance {
  bool? success;
  String? cryptoWalletBalanceInNgn;
  String? cryptoWalletBalanceInEth;

  GetCryptoBalance({
    this.success,
    this.cryptoWalletBalanceInNgn,
    this.cryptoWalletBalanceInEth,
  });

  factory GetCryptoBalance.fromJson(Map<String, dynamic> json) =>
      GetCryptoBalance(
        success: json["success"],
        cryptoWalletBalanceInNgn: json["cryptoWalletBalanceInNgn"],
        cryptoWalletBalanceInEth: json["cryptoWalletBalanceInCcd"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "cryptoWalletBalanceInNgn": cryptoWalletBalanceInNgn,
        "cryptoWalletBalanceInCcd": cryptoWalletBalanceInEth,
      };
}
