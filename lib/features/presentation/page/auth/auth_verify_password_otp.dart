// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/controllers/auth/password_controller.dart';
import 'package:gonana/features/presentation/page/auth/auth_set_new_password.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AuthVerifyPasswordOtp extends StatefulWidget {
  const AuthVerifyPasswordOtp({super.key});

  @override
  State<AuthVerifyPasswordOtp> createState() => _AuthVerifyPasswordOtpState();
}

class _AuthVerifyPasswordOtpState extends State<AuthVerifyPasswordOtp> {
  Timer? _timer;
  int _start = 50;
  bool isTimerDone = false;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          isTimerDone = !isTimerDone;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  late String otp;


  @override
  Widget build(BuildContext context) {
    ForgotPassWordController forgotPassWordController = Get.put(ForgotPassWordController());
    return  Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Color(0xff292D32),
          )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verification',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const Text('Enter the code that was sent to your email'),
            SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.88,
                child: PinCodeTextField(
                  keyboardType:  TextInputType.number,
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
                      otp = value.toString();
                      log(" $otp");
                    },
                )
              ),
            ),
            sizeVer(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isTimerDone) ...[
                  Text(
                    'Resend email OTP in $_start',
                    textAlign: TextAlign.center,
                  ),
                ],
                if (isTimerDone) ...[
                  Material(
                    // margin:EdgeInsets.only(top:15),
                    color: Colors.white,
                    child: InkWell(
                      onTap: () async {
                        // bool created = false;
                        // created = await forgotPassWordController.verifyotp(
                        //   otp
                        // );
                        // if (created) {
                        //   setState(() {
                        //     isTimerDone = false;
                        //     _start = 50;
                        //     startTimer();
                        //   });
                        // }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Not receiving OTP? click to request token again",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const Spacer(),
            LongGradientButton(
              title: 'Proceed', 
              onPressed: () async{
                bool isSuccess = await forgotPassWordController.verifyOtp(
                  otp
                );
                if(isSuccess){
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
                        child: SizedBox(
                          height: 100,
                          child: AlertDialog(
                            title: const Center(
                              child: Icon(
                                size: 60,
                                Icons.check_circle_outlined,
                              ),
                            ),
                            content: const Padding(
                              padding: EdgeInsets.only(left: 60.0),
                              child: Text('Otp Verified, Proceed to set new password'),
                            ),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: DialogGradientButton(
                                  title: 'Proceed',
                                  onPressed: () async {
                                    Get.to(() => const SetNewPassword());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }
            )
          ]
        ),
      ),
    );
  }
}