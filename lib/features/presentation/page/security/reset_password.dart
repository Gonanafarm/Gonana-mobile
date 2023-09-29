import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/features/presentation/page/security/verify_changed_password.dart';
import '/features/presentation/widgets/widgets.dart';
import 'confirm_changed_password.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool visibility1 = true;
  bool visibility2 = true;
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
                                      ? Icon(
                                          Icons.visibility_outlined,
                                        )
                                      : Icon(
                                          Icons.visibility_off_outlined,
                                        ),
                                ),
                                border: OutlineInputBorder(),
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
                                ? Icon(
                                    Icons.visibility_outlined,
                                  )
                                : Icon(
                                    Icons.visibility_off_outlined,
                                  ),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Confirm password'),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              LongGradientButton(
                  title: 'Finish',
                  onPressed: () {
                    Get.to(() => ConfirmPassword());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
