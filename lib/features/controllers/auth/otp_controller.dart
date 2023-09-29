import 'dart:convert';
import 'dart:developer';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/widgets/widgets.dart';
import '../../utilities/api_routes.dart';
import '../../utilities/network.dart';

class OTPController extends GetxController {
  Future<bool> otpVerification(String otp, var context) async {
    var data = {
      'otp': otp,
    };
    try {
      var responseBody =
          await NetworkApi().postData(data, ApiRoute.otpVerification);
      final response = jsonDecode(responseBody.body);
      log("otp response || $response");
      print(responseBody.statusCode);
      if (responseBody.statusCode == 200) {
        SuccessSnackbar.show(context, response['message']);
        return true;
      } else {
        ErrorSnackbar.show(context, response['message']);
        return false;
      }
    } catch (e) {
      log("Resend Error=> $e");
      return false;
    }
  }

  Future<bool> resendOtp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(token);
    var data = {
      'Bearer': token,
    };
    try {
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.resendOtp);
      final response = jsonDecode(responseBody.body);
      log("otp response || $response");
      print(responseBody.statusCode);
      return true;
    } catch (e) {
      log("Resend Error=> $e");
      return false;
    }
  }
}