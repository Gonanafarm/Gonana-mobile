import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/security/security.dart';
import '../savings/view_savings.dart';
import '/features/presentation/widgets/widgets.dart';
import 'confirm_changed_pin.dart';

class ResetPin extends StatelessWidget {
  ResetPin({super.key});

  final TextEditingController _newPin = TextEditingController();
  final TextEditingController _confirmPin = TextEditingController();

  String get setPin => _newPin.text;
  String get confirmPin => _confirmPin.text;

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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
        child: Column(children: [
          const SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Enter your new password',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          EnterText(
              controller: _newPin, label: 'New Pin', hint: 'Enter New Pin'),
          EnterText(
            controller: _confirmPin,
            label: 'Confirm New Pin',
            hint: 'Confirm Pin',
          ),
          const Spacer(),
          LongGradientButton(
              title: 'Confirm',
              onPressed: () {
                Get.to(() => const ConfirmPin());
              })
        ]),
      ),
    );
  }
}
