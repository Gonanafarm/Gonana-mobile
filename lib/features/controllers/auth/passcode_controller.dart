import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:gonana/features/data/models/reset_pin_model.dart';
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
      log("passcode response || $response");
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

  Future<bool> verifyPasscode(String? passcode, var context) async {
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
        SuccessSnackbar.show(context, response["message"]);
        return true;
      } else {
        ErrorSnackbar.show(context, response["message"]);
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

  ResetPin? resetPinModel;
  Future<bool> resetPin(var context) async {
    try {
      var responseBody = await NetworkApi().authGetData(ApiRoute.resetPasscode);
      final response = jsonDecode(responseBody.body);
      if (responseBody.statusCode == 200) {
        resetPinModel = resetPinFromJson(responseBody.body);
        log("$response");
        SuccessSnackbar.show(context, response['message']);
        return true;
      } else {
        ErrorSnackbar.show(context, response['message']);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> resetPassword(
      var context, String? email, String? password) async {
    var data = {"email": email, "password": password};
    try {
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.resetPassword);
      final response = jsonDecode(responseBody.body);
      if (responseBody.statusCode == 200) {
        log("$response");
        SuccessSnackbar.show(context, response['message']);
        return true;
      } else {
        ErrorSnackbar.show(context, response['message']);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> resetPasscodeOtp(String? otp, String? pin, var context) async {
    var data = {"otp": otp, "passcode": pin};
    try {
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.verifyResetOtp);
      final response = jsonDecode(responseBody.body);
      log("passcode response || ${responseBody.body}");
      print(responseBody.statusCode);
      if (responseBody.statusCode == 200) {
        print(response);
        SuccessSnackbar.show(context, "${response['message']}");
        return true;
      } else {
        ErrorSnackbar.show(context, "${response['message']}");
        return false;
      }
    } catch (e) {
      log("verify passcode Error=> $e");
      return false;
    }
  }
}
