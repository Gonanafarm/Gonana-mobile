import 'dart:convert';
import 'dart:developer';
import 'package:gonana/features/utilities/network.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/page/auth/emailverification.dart';
import '../../presentation/page/auth/number_verification_screen.dart';
import '../../presentation/widgets/widgets.dart';
import '../user/user_controller.dart';

class SignUpController extends GetxController {
  String token = '';
  String userEmail = '';
  UserController userController = Get.put(UserController());
  signUp(
      String firstName,
      String lastName,
      String phone,
      String email,
      //String accountType,
      String password,
      String bvn,
      var context) async {
    //print(countryId.runtimeType);
    try {
      var data = {
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'email': email,
        'account_type': "FARMER",
        'password': password,
        'bvn': bvn
      };
      var res = await NetworkApi().postData(data, 'api/auth/signup');
      final result = jsonDecode(res.body);
      if (res.statusCode == 201) {
        token = result["token"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        print(token);
        userController.updateEmail(email);
        prefs.setString('userEmail', userEmail);
        print("Success $token");
        print("Email $userEmail");
        await userController.fetchUserByEmail();
        await Get.to(() => const Verification());
        log("$result");
        SuccessSnackbar.show(context, "${result['message']}");
        return true;
      } else {
        ErrorSnackbar.show(context, "${result['message']}");
        log('FAILED!!!');
        log('Why: $result');
        log(res.statusCode.toString());
        return false;
      }
      print(result);
      print(token);
    } catch (e) {
      log('Error => $e');
      return false;
    }
  }
}
