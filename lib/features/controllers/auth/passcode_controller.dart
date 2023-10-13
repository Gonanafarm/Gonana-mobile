import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/widgets/widgets.dart';
import '../../utilities/api_routes.dart';
import '../../utilities/network.dart';

class PasscodeController extends GetxController {
  Future<bool> createPasscode(String? passcode) async {
    var data = {
      "passcode": passcode,
    };
    try {
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.createPasscode);
      final response = jsonDecode(responseBody.body);
      log("passcode response || $responseBody");
      print(responseBody.statusCode);
      if (responseBody.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("create passcode Error=> $e");
      return false;
    }
  }

  Future<bool> verifyPasscode(String? passcode) async {
    var data = {
      "passcode": passcode,
    };
    try {
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.verifyPasscode);
      final response = jsonDecode(responseBody.body);
      log("passcode response || ${responseBody.body}");
      print(responseBody.statusCode);
      if (responseBody.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("verify passcode Error=> $e");
      return false;
    }
  }

  Future<bool> deletePasscode(String? passcode, var context) async {
    var data = {
      "passcode": passcode,
    };
    try {
      var responseBody =
          await NetworkApi().deleteData(data, ApiRoute.deleteAccount);
      final response = jsonDecode(responseBody.body);
      log("passcode response || ${responseBody.body}");
      print(responseBody.statusCode);
      if (responseBody.statusCode == 200) {
        SuccessSnackbar.show(context, response['message']);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        return true;
      } else {
        ErrorSnackbar.show(context, response['message']);
        return false;
      }
    } catch (e) {
      log("verify passcode Error=> $e");
      ErrorSnackbar.show(context, "Unknown error");
      return false;
    }
  }
}
