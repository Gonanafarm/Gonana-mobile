import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/page/auth/register_bank.dart';
import 'package:gonana/features/presentation/page/market/cart_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controllers/auth/otp_controller.dart';
import '../../../controllers/user/user_controller.dart';
import '/features/presentation/widgets/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'facial_recognition.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});
  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  var email;
  late String otpPin;
  Timer? _timer;
  int _start = 50;
  bool isTimerDone = false;
  final userController = Get.find<UserController>();

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) {
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
    setStage();
  }

  setStage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('registrationStage', 2);
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OTPController otpController = Get.put(OTPController());
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 20,
              color: Color(0xff292D32),
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 20, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verification',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Text('Enter the code that was sent to email')
                    ]),
              ),
              SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: PinCodeTextField(
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
                      otpPin = value.toString();
                      print(" $otpPin");
                    },
                  ),
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
                          bool created = false;
                          created = await otpController.resendOtp();
                          if (created) {
                            setState(() {
                              isTimerDone = false;
                              _start = 50;
                              startTimer();
                            });
                          }
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
                  onPressed: () async {
                    print("otp: $otpPin");
                    bool created = false;
                    created =
                        await otpController.otpVerification(otpPin, context);
                    if (created) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // Set to true if you want to allow dismissing the dialog by tapping outside it
                        builder: (BuildContext context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 20,
                                sigmaY:
                                    20), // Adjust the blur intensity as needed
                            child: SizedBox(
                              height: 100,
                              child: AlertDialog(
                                title: Center(
                                  child: Icon(
                                    size: 60,
                                    Icons.check_circle_outlined,
                                  ),
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.only(left: 60.0),
                                  child: Text('Email Verified'),
                                ),
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: DialogGradientButton(
                                      title: 'Proceed',
                                      onPressed: () async {
                                        Get.to(() => const RegisterBank());
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
                  })
            ],
          ),
        ),
      ),
    );
  }
}