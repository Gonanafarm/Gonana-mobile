import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gonana/features/data/models/get_balance_model.dart';
import 'package:gonana/features/data/models/get_transaction_model.dart'
    as Transaction;

import '../../data/models/CryptoBalanceModel.dart';
import '../../presentation/page/wallet/wallet_page.dart';
import '../../presentation/widgets/widgets.dart';
import '../../utilities/api_routes.dart';
import '../../utilities/network.dart';

class TransactionController extends GetxController {
  Future<bool> verifyKYC(String dob, String bvn, var context) async {
    try {
      var data = {
        'dob': dob,
        'bvn': bvn,
      };
      print(data);
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.verifyKyc);
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("BVN verification|| $response");
      if (responseBody.statusCode == 201) {
        print(responseBody.statusCode);
        await verifyBVN(bvn, context);
        SuccessSnackbar.show(context, "KYC verified successfully");
        // SuccessSnackbar.show(context, "${response['responseMessage']}");
        return true;
      } else {
        print('res');
        ErrorSnackbar.show(context, "${response['message']}");
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> verifyBVN(String bvn, var context) async {
    try {
      var data = {
        'bvn': bvn,
      };
      print(data);
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.verifyBVN);
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("BVN verification|| $response");
      if (responseBody.statusCode == 201) {
        print(responseBody.statusCode);
        SuccessSnackbar.show(context, "BVN verified successfully");
        // SuccessSnackbar.show(context, "${response['responseMessage']}");
        return true;
      } else {
        print('res');
        ErrorSnackbar.show(context, "${response['message']}");
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> recoverBvn(String bvn, var context) async {
    try {
      var data = {
        'bvn': bvn,
      };
      print(data);
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.recoverBvn);
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("BVN verification|| $response");
      if (responseBody.statusCode == 201) {
        print(responseBody.statusCode);
        SuccessSnackbar.show(context, "Virtual account recovered");
        // SuccessSnackbar.show(context, "${response['responseMessage']}");
        return true;
      } else {
        ErrorSnackbar.show(context, "${response['message']}");
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future tokenToDolls(String token, Coin tokenType) async {
    try {
      var data = {
        tokenType == Coin.ETH ? 'eth' : "ccd": token,
      };
      print(data);
      var responseBody = await NetworkApi().authPostData(data,
          tokenType == Coin.ETH ? ApiRoute.ethToDolls : ApiRoute.ccdToDolls);
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("Conversion verification|| $response");
      if (responseBody.statusCode == 201) {
        print(responseBody.statusCode);
        // SuccessSnackbar.show(context, "${response['responseMessage']}");
        return response;
      } else {
        return 0.0;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future ngnToToken(String ngn, Coin coin) async {
    try {
      var data = {
        'ngn': coin == Coin.CCD ? ngn : int.tryParse(ngn),
      };
      print(data);
      var responseBody = await NetworkApi().authPostData(
          data, coin == Coin.CCD ? ApiRoute.ngnToCCD : ApiRoute.ngnToETH);
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("Conversion verification|| ${response}");
      if (responseBody.statusCode == 201) {
        print(responseBody.statusCode);
        // SuccessSnackbar.show(context, "${response['responseMessage']}");
        return response;
      } else {
        return 0.0;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  var balanceModel = GetBalanceModel().obs;
  Future<bool> fetchBalance() async {
    try {
      var responseBody =
          await NetworkApi().authGetData(ApiRoute.getWalletBalance);
      final response = jsonDecode(responseBody.body);
      print("wallet balance got here");
      if (responseBody.statusCode == 200) {
        balanceModel.value = getBalanceModelFromJson(responseBody.body);
        log("Wallet balance || $response");
        log("Wallet balance || ${balanceModel.value.balance}");
        return true;
      } else {
        log(response);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  var ccdBalanceModel = GetCcdBalance();
  var ethBalanceModel = GetEthBalance();
  Future<bool> fetchCryptoBalance() async {
    try {
      var responseBody1 =
          await NetworkApi().authGetData(ApiRoute.getCcdWalletBalance);
      var responseBody2 =
          await NetworkApi().authGetData(ApiRoute.getEthWalletBalance);
      final response1 = jsonDecode(responseBody1.body);
      final response2 = jsonDecode(responseBody1.body);
      print("crypto wallet balance");
      if (responseBody1.statusCode == 200 && responseBody2.statusCode == 200) {
        ccdBalanceModel = getCcdBalanceFromJson(responseBody1.body);
        ethBalanceModel = getEthBalanceFromJson(responseBody2.body);
        log("Crypto wallet balance || $response1");
        log("Crypto wallet balance || $response2");
        log("Crypto wallet balance || ${ccdBalanceModel.cryptoWalletBalanceInNgn}");
        log("Crypto wallet balance || ${ethBalanceModel.cryptoWalletBalanceInNgn}");
        return true;
      } else {
        log(response1);
        log(response2);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Rx<Transaction.GetTransactionModel> transactionModel =
      Rx<Transaction.GetTransactionModel>(Transaction.GetTransactionModel());
  int transactionLimit = 15;
  int transactionPage = 1;
  Future<bool> fetchTransactions() async {
    transactionPage = 1;
    try {
      var responseBody = await NetworkApi().authGetData(
          "api/transaction/user-transactions?limit=$transactionLimit&page=$transactionPage");
      final response = jsonDecode(responseBody.body);
      print("Wallet transactions got here");
      if (responseBody.statusCode == 200) {
        transactionModel.value =
            Transaction.getTransactionModelFromJson(responseBody.body);
        print("Wallet transactions || $response");
        print(
            "Wallet transactions | || ${transactionModel!.value.transactions![0].transactions!.amountSettled}");
        return true;
      } else {
        print("Wallet transactions got here again (error)");
        print(response);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future fetchMoreTransactions() async {
    await transactionPage++;
    try {
      print("page test 1 $transactionPage");
      var responseBody = await NetworkApi().authGetData(
          "api/transaction/user-transactions?limit=$transactionLimit&page=$transactionPage");
      var response = jsonDecode(responseBody.body);
      if (response != null &&
          transactionModel.value != null &&
          transactionModel.value!.transactions != null &&
          transactionModel.value!.transactions!.isNotEmpty) {
        final dataToAdd =
            (response["transactions"] as List<dynamic>?)?.map((item) {
                  return Transaction.Transaction.fromJson(item);
                })?.toList() ??
                [];
        // if (dataToAdd.length < limit) {
        //   updateHasMore(false);
        // }
        if (dataToAdd.isNotEmpty) {
          transactionModel.value.transactions!.addAll(dataToAdd);
          update();
          print("pagination got here $transactionPage");
          print(
              "New data body: ${transactionModel.value.transactions!.length}");
          print(
              "New data body: ${transactionModel.value.transactions![0].transactions!.amountSettled}");
        }
        print(response);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<bool> transferFunds(double amount, String accountNumber,
      String bankName, String narration, String accountName) async {
    try {
      var data = {
        'amount': amount,
        'accountNumber': accountNumber,
        'bankName': bankName,
        'narration': narration,
        "accountName": accountName
      };
      print(data);
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.transferFunds);
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("funds transfer || $response");
      if (responseBody.statusCode == 201) {
        print(responseBody.statusCode);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> sendToken(
    String amount,
    String walletAddress,
    bool withdraw,
    Coin coin,
    BuildContext context,
  ) async {
    try {
      var data = withdraw
          ? {
              'amount': amount,
              'recipient': walletAddress,
            }
          : {
              'amount': amount,
              'recipientId': walletAddress,
            };
      print(data);
      var responseBody = await NetworkApi().authPostData(
          data,
          withdraw && coin == Coin.CCD
              ? ApiRoute.withdrawCCD
              : coin == Coin.ETH
                  ? ApiRoute.transferETH
                  : ApiRoute.transferCCD);
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("crypto transfer || $response");
      if (responseBody.statusCode == 201 || responseBody.statusCode == 200) {
        print(responseBody.statusCode);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> gonanaTransfer(
      String email, int amount, String narration) async {
    try {
      var data = {"email": email, "amount": amount, "narration": narration};
      var res = await NetworkApi().authPostData(data, ApiRoute.gonanaTransfer);
      var response = jsonDecode(res.body);
      log("data: $data || response: $response");
      if (res.statusCode == 200) {
        print("success");
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      log('gonanatransfererror: $e');
      log('gonanatransfestack: $s');
      return false;
    }
  }
}
