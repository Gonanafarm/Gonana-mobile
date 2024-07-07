import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:gonana/features/data/models/bank_model.dart';
import 'package:gonana/features/data/models/resolve_bank.dart';

import '../../presentation/widgets/widgets.dart';
import '../../utilities/api_routes.dart';
import '../../utilities/network.dart';

class BankController extends GetxController {
  BankModel? bankModel;

  Future<bool> fetchBank() async {
    try {
      var responseBody = await NetworkApi().authGetData(ApiRoute.fetchBanks);
      final response = jsonDecode(responseBody.body);
      print("Banks");
      bankModel = await bankModelFromJson(responseBody.body);
      sortBanks();
      log("All banks || $response");
      log("All banks || $banks");
      if (response['statusCode'] == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  List<String> banks = [];

  sortBanks() {
    // this will clear the list to prevent multiple occurrence of courses
    banks.clear();
    // this will get each course and add it to the courses list i declared above
    for (var i = 0; i < bankModel!.data!.length; i++) {
      banks.insert(0, bankModel!.data!.elementAt(i).bankName!);
    }
  }

  ResolveBankModel? resolveBankModel;
  Future<String?> fetchAccountName(
      String bankName, String accountNumber) async {
    try {
      String inputString = bankName;
      String finalBankName = inputString.replaceAll(' ', '+');
      print(finalBankName);

      var responseBody = await NetworkApi().authGetData(
          "api/transaction/resolve-account-number?account_number=$accountNumber&bank=$finalBankName");
      final response = jsonDecode(responseBody.body);
      resolveBankModel = resolveBankModelFromJson(responseBody.body);
      log("Account name || $response");
      if (responseBody.statusCode == 200) {
        return resolveBankModel!.data!.data!.accountName;
      } else {
        return "";
      }
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<bool> updateBankDetails(
      String accountNumber, String bank, context) async {
    try {
      var data = {
        'account_number': accountNumber,
        'bank': bank,
      };
      print(data);
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.updateBankDetail);
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("bank added|| $response");
      if (responseBody.statusCode == 201) {
        SuccessSnackbar.show(context, "${response['message']}");
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
