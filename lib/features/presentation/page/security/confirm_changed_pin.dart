import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/security/security.dart';
import '/features/presentation/widgets/widgets.dart';

class ConfirmPin extends StatefulWidget {
  const ConfirmPin({super.key});

  @override
  State<ConfirmPin> createState() => _ConfirmPinState();
}

class _ConfirmPinState extends State<ConfirmPin> {
  bool visibility = false;

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
                          'Enter your password to confirm new Pin',
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Password'),
                        TextField(
                          obscureText: visibility,
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
                    )),
                const Spacer(),
                LongGradientButton(
                    title: 'Confirm',
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
                                  child: Text('Pin changed succesful'),
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
              ]),
        ),
      ),
    );
  }
}
