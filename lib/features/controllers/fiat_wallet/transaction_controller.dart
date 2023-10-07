import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:gonana/features/data/models/get_balance_model.dart';
import 'package:gonana/features/data/models/get_transaction_model.dart';

import '../../presentation/widgets/widgets.dart';
import '../../utilities/api_routes.dart';
import '../../utilities/network.dart';

class TransactionController extends GetxController {
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
        SuccessSnackbar.show(context,
            "BVN submitted successfully,\nyou would get a an email concerning your email verification");
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

  GetBalanceModel? balanceModel;
  Future<bool> fetchBalance() async {
    try {
      var responseBody =
          await NetworkApi().authGetData(ApiRoute.getWalletBalance);
      final response = jsonDecode(responseBody.body);
      print("wallet balance got here");
      if (responseBody.statusCode == 200) {
        balanceModel = getBalanceModelFromJson(responseBody.body);
        log("Wallet balance || $response");
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

  GetTransactionModel? transactionModel;
  Future<bool> fetchTransactions() async {
    try {
      var responseBody =
          await NetworkApi().authGetData(ApiRoute.getWalletTransactions);
      final response = jsonDecode(responseBody.body);
      print("Wallet transactions got here");
      if (responseBody.statusCode == 200) {
        transactionModel = getTransactionModelFromJson(responseBody.body);
        print("Wallet transactions || $response");
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

  Future<bool> transferFunds(int amount, String accountNumber, String bankName,
      String narration, var context) async {
    try {
      var data = {
        'amount': amount,
        'accountNumber': accountNumber,
        'bankName': bankName,
        'narration': narration,
      };
      print(data);
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.transferFunds);
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("funds transfer || $response");
      if (responseBody.statusCode == 201) {
        print(responseBody.statusCode);
        SuccessSnackbar.show(context, response['message']);
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
}
