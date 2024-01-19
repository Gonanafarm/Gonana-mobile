import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/page/security/security.dart';
import '../../../controllers/auth/passcode_controller.dart';
import '../savings/view_savings.dart';
import '/features/presentation/widgets/widgets.dart';
import 'confirm_changed_pin.dart';

class ChangePin extends StatefulWidget {
  ChangePin({super.key});

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  final TextEditingController _newPin = TextEditingController();

  final TextEditingController _oldPin = TextEditingController();

  String get setPin => _newPin.text;

  String get oldPin => _oldPin.text;

  bool isLoading = false;

  final _pinKey = GlobalKey<FormState>();

  PasscodeController passcodeController = Get.put(PasscodeController());

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
                  'Change pin',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          sizeVer(20),
          Form(
            key: _pinKey,
            child: Column(
              children: [
                EnterFormText(
                    validator: inputValidator,
                    controller: _oldPin,
                    label: 'Old Pin',
                    hint: 'Enter your old Pin'),
                EnterFormText(
                  validator: inputValidator,
                  controller: _newPin,
                  label: 'New Pin',
                  hint: 'Enter your new Pin',
                ),
              ],
            ),
          ),
          const Spacer(),
          LongGradientButton(
              isLoading: isLoading,
              title: 'Confirm',
              onPressed: () async {
                bool isValidated = _pinKey.currentState!.validate();
                if (isValidated) {
                  setState(() {
                    isLoading = true;
                  });
                  bool isPasscode = await passcodeController.verifyPasscode(
                      _oldPin.text, context);
                  if (isPasscode) {
                    setState(() {
                      isLoading = false;
                    });
                    if (_oldPin.text != _newPin.text) {
                      Get.to(() => const ConfirmPin(),
                          arguments: {"newPin": _newPin.text});
                    } else {
                      ErrorSnackbar.show(
                          context, "Old pin cannot be the same as new pin");
                    }
                  } else {
                    ErrorSnackbar.show(context, "Old pin is incorrect");
                  }
                }
              })
        ]),
      ),
    );
  }
}
