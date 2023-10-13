import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/features/presentation/page/auth/auth_verify_password_otp.dart';
import '../../../controllers/auth/password_controller.dart';
import '/features/presentation/widgets/widgets.dart';
import 'sign_up_page.dart';

class ForgotPasswordEmail extends GetxController {
  final TextEditingController _email = TextEditingController();
  String get email => _email.text;
}

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final _forgotPasswordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ForgotPasswordEmail forgotPasswordEmail = Get.put(ForgotPasswordEmail());
    ForgotPassWordController passwordController =
        Get.put(ForgotPassWordController());
    emailValidator(value) {
      RegExp emailRegex =
          RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');
      if (!emailRegex.hasMatch(value)) {
        return 'Enter a valid email';
      } else {
        return null;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Forgot Password',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          const Text(
              'Enter your email address and we would send you an OTP code'),
          const SizedBox(height: 10),
          Form(
            key: _forgotPasswordKey,
            child: EnterFormText(
                controller: forgotPasswordEmail._email,
                validator: emailValidator,
                label: 'Email',
                hint: 'eg. email@example.com'),
          ),
          const Spacer(),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => const SignUp());
                  },
                  child: const Text(
                    'Create an account',
                    style: TextStyle(
                      color: Color(0xff29844B),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                LongGradientButton(
                  title: 'Proceed',
                  onPressed: () async {
                    bool isValid = _forgotPasswordKey.currentState!.validate();
                    if (isValid) {
                      var isSuccess = await passwordController.forgotPassword(forgotPasswordEmail.email);
                      if (isSuccess[0] == true) {
                        log("isSuccess:$isSuccess");
                        Get.to(() => const AuthVerifyPasswordOtp());
                      } else {
                        // ignore: use_build_context_synchronously
                        ErrorSnackbar.show(context, isSuccess[1]);
                      }
                    }
                  }
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
