import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../presentation/widgets/widgets.dart';
import '../../utilities/api_routes.dart';
import '../../utilities/network.dart';

class ForgotPassWordController extends GetxController {
  forgotPassword(String email) async {
    try {
      var data = {
        'email': email,
      };
      var res = await NetworkApi().postData(data, ApiRoute.forgottenPassword);
      final result = jsonDecode(res.body);
      String mssg = result['message'];
      log(result.toString());
      log(mssg);
      if (res.statusCode == 200) {
        log("Success ${res.statusCode}");
        return [true, mssg];
      } else {
        log("Failed ${res.statusCode}");
        return [false, mssg];
      }
    } catch (e, s) {
      log("forgotpassword Error=> $e");
      log("forgotpassword Stack=> $s");
      return false;
    }
  }

  Future<bool> resetPassword(String email, String password) async {
    try {
      var data = {'email': email, 'password': password};
      var res = await NetworkApi().postData(data, ApiRoute.resetPassword);
      final result = jsonDecode(res.body);
      if (res.statusCode == 200) {
        log('$result');
        log("Success ${res.statusCode}");
        return true;
      } else {
        log("Failed ${res.statusCode}");
        return false;
      }
    } catch (e, s) {
      log("resetPassword Error=> $e");
      log("resetpasswordStak: $s");
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    try {
      var data = {'otp': otp};
      var res = await NetworkApi().postData(data, ApiRoute.verifyPasswordotp);
      final result = jsonDecode(res.body);
      if (res.statusCode == 200) {
        log("Success ${res.body}");
        log("$result");
        return true;
      } else {
        log("Failed ${res.body}");
        //log(result);
        return false;
      }
    } catch (e, s) {
      log('error: $e');
      log('stack: $s');
      return false;
    }
  }

  Future<bool> initPasswordReset(var context) async {
    try {
      var res = await NetworkApi().authGetData(ApiRoute.resetPassword);
      final result = jsonDecode(res.body);
      if (res.statusCode == 200) {
        log("result: $result");
        SuccessSnackbar.show(
            context, res['message'] ?? "Successful: Check your mail for otp");
        return true;
      } else {
        ErrorSnackbar.show(context,
            res['message'] ?? "Failed: couldn't initiate password reset");
        return false;
      }
    } catch (e, s) {
      log("initpasser: $e");
      log("initpassStack: $s");
      return false;
    }
  }

  Future<bool> completePasswordReset(
      String? otp, String? password, var context) async {
    var data = {
      "otp": otp,
      "password": password,
    };
    try {
      var res =
          await NetworkApi().authPostData(data, ApiRoute.verifyPasswordotp);
      final result = jsonDecode(res.body);
      if (res.statusCode == 200) {
        log("result: $result");
        SuccessSnackbar.show(context, res['message']);
        return true;
      } else {
        ErrorSnackbar.show(context, res['message']);
        return false;
      }
      return false;
    } catch (e, s) {
      log("initpasser: $e");
      log("initpassStack: $s");
      return false;
    }
  }
}
