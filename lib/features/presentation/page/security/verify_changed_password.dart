import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/security/security.dart';
import 'package:gonana/features/presentation/widgets/pinWidget.dart';
import '/features/presentation/widgets/widgets.dart';

class ResetPasswordVerification extends StatefulWidget {
  const ResetPasswordVerification({super.key});

  @override
  State<ResetPasswordVerification> createState() =>
      _ResetPasswordVerificationState();
}

class _ResetPasswordVerificationState extends State<ResetPasswordVerification> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xff1E1E1E),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 10.0),
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verification',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Enter the code that was sent to Johndavid@gmail.com',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: PinWidget(
                  textEditingController: textController,
                ),
              ),
              const Spacer(),
              LongGradientButton(
                  title: 'Proceed',
                  onPressed: () {
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
                          child: Container(
                            height: 100,
                            child: AlertDialog(
                              title: Center(
                                child: Icon(
                                  size: 60,
                                  Icons.check_circle_outlined,
                                ),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Text('Password changes succesful'),
                              ),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 30.0),
                                  child: DialogGradientButton(
                                    title: 'Proceed',
                                    onPressed: () {
                                      Get.to(() => Security());
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
