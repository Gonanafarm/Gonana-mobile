import 'dart:convert';
import 'dart:developer';
import 'package:gonana/features/controllers/user/user_controller.dart';
import 'package:gonana/features/data/models/user_model.dart';
import 'package:gonana/features/utilities/network.dart';
import 'package:get/get.dart';
import 'package:gonana/features/utilities/api_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/page/home.dart';
import '../../presentation/widgets/widgets.dart';

class SignInController extends GetxController {
  String token = '';
  String userEmail = '';
  UserController userController = Get.put(UserController());
  UserModel userModel = UserModel();

  Future<bool> signIn(String email, String password, var context
      //String accountType,
      ) async {
    try {
      var data = {
        'email': email,
        'password': password,
        'account_type': "FARMER"
      };
      var res = await NetworkApi().postData(data, ApiRoute.login);
      final result = jsonDecode(res.body);
      print(data);
      if (res.statusCode == 201) {
        token = result["token"];
        userEmail = email;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", token);
        userController.updateEmail(email);
        prefs.setString('userEmail', userEmail);
        print("Success $token");
        print("Email: $userEmail");
        await userController.fetchUserByEmail();
        print("email: ${userController.userEmail}");
        SuccessSnackbar.show(context, result['message']);
        await Get.to(() => HomePage(navIndex: 0));
        return true;
      } else {
        ErrorSnackbar.show(context, result['message']);
        log(result.toString());
        log("Failed ${res.statusCode}");
        return false;
      }
    } catch (e) {
      log("SignIn Error=> $e");
      return false;
    }
  }
}
