import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/controllers/auth/passcode_controller.dart';
import 'package:gonana/features/presentation/page/security/security.dart';
import '/features/presentation/widgets/widgets.dart';

class ConfirmPin extends StatefulWidget {
  const ConfirmPin({super.key});

  @override
  State<ConfirmPin> createState() => _ConfirmPinState();
}

class _ConfirmPinState extends State<ConfirmPin> {
  bool visibility = false;
  dynamic argument = Get.arguments;

  late String newPin = argument['newPin'];
  final _confirmPinChange = GlobalKey<FormState>();
  TextEditingController confirmPinController = TextEditingController();
  final passcodeController = Get.find<PasscodeController>();
  bool isLoading = false;
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
                Get.back();
              })),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  // width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Confirmation',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Enter your new pin to confirm correctness',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _confirmPinChange,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Password'),
                          TextFormField(
                            controller: confirmPinController,
                            obscureText: visibility,
                            validator: inputValidator,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    visibility == true
                                        ? setState(() {
                                            visibility = false;
                                          })
                                        : setState(() {
                                            visibility = true;
                                          });
                                  },
                                  icon: visibility == true
                                      ? Icon(
                                          Icons.visibility_outlined,
                                        )
                                      : Icon(
                                          Icons.visibility_off_outlined,
                                        ),
                                ),
                                border: OutlineInputBorder(),
                                hintText: 'Enter your password'),
                          ),
                        ],
                      ),
                    )),
                const Spacer(),
                LongGradientButton(
                    isLoading: isLoading,
                    title: 'Confirm',
                    onPressed: () async {
                      bool isValidated =
                          _confirmPinChange.currentState!.validate();
                      if (isValidated) {
                        if (newPin == confirmPinController.text) {
                          setState(() {
                            isLoading = true;
                          });
                          bool isPasscode = await passcodeController
                              .createPasscode(confirmPinController.text);
                          if (isPasscode) {
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
                                        padding:
                                            const EdgeInsets.only(left: 30.0),
                                        child: Text('Pin changed succesful'),
                                      ),
                                      actions: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30.0),
                                          child: DialogGradientButton(
                                            title: 'Proceed',
                                            onPressed: () {
                                              Get.offAll(() => Security());
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
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          ErrorSnackbar.show(
                              context, "Passcode does not match");
                        }
                      }
                    })
              ]),
        ),
      ),
    );
  }
}
