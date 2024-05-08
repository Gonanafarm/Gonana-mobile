import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/auth/passcode_controller.dart';
import 'package:gonana/features/controllers/auth/sign_in_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../services/local_auth_service.dart';
import '../../../controllers/user/user_controller.dart';
import '../../widgets/bottomsheets.dart';
import '/features/presentation/page/home.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../widgets/numpad.dart';
import '../../widgets/widgets.dart';

class SetPasscode extends StatefulWidget {
  const SetPasscode({super.key});

  @override
  State<SetPasscode> createState() => _SetPasscodeState();
}

class _SetPasscodeState extends State<SetPasscode> {
  final TextEditingController _passCodeController = TextEditingController();
  PasscodeController passcodeController = Get.put(PasscodeController());
  SignInController signInController = Get.put(SignInController());
  final userController = Get.find<UserController>();
  String get passCode => _passCodeController.text;
  @override
  void initState() {
    super.initState();
    setStage();
  }

  setStage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('registrationStage', 4);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 20,
              color: Color(0x00ff0000),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 8, 30, 30),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Four Digit Passcode',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.left),
                          Text(
                              'Enter your four digit pin and strengthen your security\n or use the finger print verification',
                              textAlign: TextAlign.left)
                        ]),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    // width: 300,
                    child: Center(
                      child: PinCodeTextField(
                        controller: _passCodeController,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          borderWidth: 1,
                          fieldHeight: 60.0,
                          fieldWidth: 64.0,
                          activeColor: const Color(0xff444444),
                          disabledColor: const Color(0xff444444),
                          inactiveColor: const Color(0xff444444),
                        ),
                        appContext: context,
                        length: 4,
                        onChanged: (String value) {
                          print(value);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: SizedBox(
                      child: NumPad(
                        controller: _passCodeController,
                        delete: () {},
                        // faceIdFunction: () async {
                        //   final bool authenticate =
                        //       await LocalAuth.authenticate();
                        //   if (authenticate) {
                        //     print("Face is authenticated");
                        //     showModalBottomSheet(
                        //         context: context,
                        //         isScrollControlled: true,
                        //         builder: (context) =>
                        //             completeVerificationBottomSheet());
                        //   }
                        // },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            LongGradientButton(
                title: 'Proceed',
                isLoading: isLoading,
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  bool created = false;
                  print("passcode: $passCode");
                  created = await passcodeController.createPasscode(passCode);
                  if (created) {
                    setState(() {
                      isLoading = false;
                    });
                    showDialog(
                      context: context,
                      barrierDismissible:
                          true, // Set to true if you want to allow dismissing the dialog by tapping outside it
                      builder: (BuildContext context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 20,
                              sigmaY:
                                  20), // Adjust the blur intensity as needed
                          child: Container(
                            height: 100,
                            child: AlertDialog(
                              title: Center(
                                child: Icon(
                                  size: 60,
                                  Icons.check_circle_outlined,
                                ),
                              ),
                              content: const Padding(
                                padding: EdgeInsets.only(left: 60.0),
                                child: Text('Four digits pin set'),
                              ),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 30.0),
                                  child: DialogGradientButton(
                                    title: 'Proceed',
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      Get.offAll(() => HomePage(navIndex: 0));
                                      signInController
                                          .startLogoutTimer(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    ErrorSnackbar.show(context, "Unsuccessful");
                    setState(() {
                      isLoading = true;
                    });
                  }
                })
          ],
        ),
      ),
    );
  }
}
