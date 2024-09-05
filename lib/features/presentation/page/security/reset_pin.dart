import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/security/security.dart';

import '../../../../consts.dart';
import '../../../controllers/auth/passcode_controller.dart';
import '../../widgets/widgets.dart';

class ResetPin extends StatefulWidget {
  const ResetPin({Key? key}) : super(key: key);

  @override
  State<ResetPin> createState() => _ResetPinState();
}

class _ResetPinState extends State<ResetPin> {
  bool isLoading = false;

  final _resetPinKey = GlobalKey<FormState>();
  final TextEditingController _newPin = TextEditingController();

  final TextEditingController _otp = TextEditingController();

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
            key: _resetPinKey,
            child: Column(
              children: [
                EnterFormText(
                    validator: inputValidator,
                    controller: _otp,
                    label: 'OTP',
                    hint: 'Enter the otp sent to your email'),
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
                bool isValidated = _resetPinKey.currentState!.validate();
                if (isValidated) {
                  setState(() {
                    isLoading = true;
                  });
                  bool isPasscode = await passcodeController.resetPasscodeOtp(
                      _otp.text, _newPin.text, context);
                  if (isPasscode) {
                    setState(() {
                      isLoading = false;
                    });
                    Get.offAll(() => const Security());
                    // Navigator.pop(context);
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                  }
                }
              })
        ]),
      ),
    );
  }
}
