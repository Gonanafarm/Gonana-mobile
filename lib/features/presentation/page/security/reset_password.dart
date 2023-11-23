import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/features/presentation/page/security/verify_changed_password.dart';
import '/features/presentation/widgets/widgets.dart';
import 'confirm_changed_password.dart';
import '../../../controllers/auth/password_controller.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();

  bool visibility1 = true;
  bool visibility2 = true;
  ForgotPassWordController passwordController =
      Get.put(ForgotPassWordController());
  @override
  void initState() {
    passwordController.initPasswordReset(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 33.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reset Password',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Text('Enter your new password')
                      ]),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('New password'),
                          TextField(
                            controller: newPassword,
                            obscureText: visibility1,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    visibility1 == false
                                        ? setState(() {
                                            visibility1 = true;
                                          })
                                        : setState(() {
                                            visibility1 = false;
                                          });
                                  },
                                  icon: visibility1 == true
                                      ? const Icon(Icons.visibility_outlined)
                                      : const Icon(
                                          Icons.visibility_off_outlined),
                                ),
                                border: const OutlineInputBorder(),
                                hintText: 'Enter your new  password'),
                          ),
                        ],
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Confirm new password'),
                    TextField(
                      controller: confirmNewPassword,
                      obscureText: visibility2,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              visibility2 == false
                                  ? setState(() {
                                      visibility2 = true;
                                    })
                                  : setState(() {
                                      visibility2 = false;
                                    });
                            },
                            icon: visibility2 == true
                                ? const Icon(
                                    Icons.visibility_outlined,
                                  )
                                : const Icon(
                                    Icons.visibility_off_outlined,
                                  ),
                          ),
                          border: const OutlineInputBorder(),
                          hintText: 'Confirm password'),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              LongGradientButton(
                  title: 'Finish',
                  onPressed: () async {
                    if (newPassword.text == confirmNewPassword.text) {
                      Get.to(() => const ConfirmPassword());
                    } else {
                      ErrorSnackbar.show(
                          context, "Please make sure your passwords match");
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
