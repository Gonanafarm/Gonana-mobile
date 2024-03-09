import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/controllers/user/user_controller.dart';
import 'package:gonana/features/data/models/user_model.dart';
import 'package:gonana/features/utilities/network.dart';
import 'package:get/get.dart';
import 'package:gonana/features/utilities/api_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/page/auth/auth_splash4.dart';
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
      print("Result = $result");
      if (res.statusCode == 201) {
        token = result["token"];
        userEmail = email;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", token);
        userController.updateEmail(email);
        prefs.setString('userEmail', userEmail);
        //print("Success $token");
        print("Email: $userEmail");
        await userController.fetchUserByEmail();
        print("model email: ${userController.userModel.value.email}");
        // SuccessSnackbar.show(context, result['message']);
        startLogoutTimer(context);
        await Get.to(() => HomePage(navIndex: 0));
        // log(jsonDecode(res.body));
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

  Future<bool> signInWithBiometrics(String email, var context
      //String accountType,
      ) async {
    var result;
    try {
      var data = {'email': email, 'account_type': "FARMER"};
      var res = await NetworkApi().getData("api/user/generate-token/$email");
      result = jsonDecode(res.body);
      print("Result = $result");
      if (res.statusCode == 200) {
        token = result["token"];
        userEmail = email;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", token);
        userController.updateEmail(email);
        prefs.setString('userEmail', userEmail);
        //print("Success $token");
        print("Email: $userEmail");
        await userController.fetchUserByEmail();
        print("model email: ${userController.userModel.value.email}");
        // SuccessSnackbar.show(context, result['message']);
        startLogoutTimer(context);
        await Get.to(() => HomePage(navIndex: 0));
        // log(jsonDecode(res.body));
        return true;
      } else {
        ErrorSnackbar.show(context, "User not found");
        log(result.toString());
        log("Failed ${res.statusCode}");
        return false;
      }
    } catch (e) {
      log("SignIn Error=> $e");
      return false;
    }
  }

  Timer? _timer;
  static const int _minutesRemaining = 5;

  // Method to start the logout timer
  void startLogoutTimer(var context) {
    // Cancel the previous timer if it exists
    // Start a new timer for logout
    _timer = Timer(const Duration(minutes: _minutesRemaining), () {
      // Automatically log out the user after timer expiry
      logout(context);
    });
  }

  // Method to handle user logout
  void logout(var context) {
    // Cancel the timer when the user logs out
    _timer!.cancel();
    showDialog(
      context: context,
      barrierDismissible:
          false, // Set to true if you want to allow dismissing the dialog by tapping outside it
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 20, sigmaY: 20), // Adjust the blur intensity as needed
          child: Container(
            height: 100,
            child: AlertDialog(
              title: const Center(
                child: Icon(
                  size: 60,
                  Icons.logout_outlined,
                  color: greenColor,
                ),
              ),
              content: Padding(
                padding: EdgeInsets.only(left: 0.0),
                child: Container(
                  height: 50,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Login again to continue using Gonana',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Center(
                  child: DialogGradientButton(
                    title: 'Logout',
                    onPressed: () async {
                      bool cleared = false;
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      cleared = await preferences.remove("token");
                      if (cleared) {
                        print("cleared");
                        Get.to(() => const Splash4());
                      }
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 10, top: 20),
                //   child: Center(
                //     child: DialogWhiteButton(
                //       title: 'No, go back',
                //       onPressed: () {
                //         Get.back();
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
    // Other logout logic
  }
}
