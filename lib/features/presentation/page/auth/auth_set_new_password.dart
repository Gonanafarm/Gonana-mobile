import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/controllers/auth/password_controller.dart';
import 'package:gonana/features/presentation/page/auth/forgotpassword.dart';
import 'package:gonana/features/presentation/page/auth/sign_in_page.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _newPassword1 = TextEditingController();
  String get newPassword => _newPassword.text;
  String get newPassword1 => _newPassword1.text;

  List<String> str = [
    "At least one lowercase letter",
    "At least one uppercase letter",
    "At least one number",
    "At least 8 charecters long"
  ];

  bool visibility1 = false;
  bool visibility2 = false;

  @override
  Widget build(BuildContext context) {
    ForgotPasswordEmail forgotPasswordEmail = Get.put(ForgotPasswordEmail());
    ForgotPassWordController forgotPassWordController = Get.put(ForgotPassWordController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const Text('Fill in these details'),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Password'),
                    TextField(
                      controller: _newPassword,
                      obscureText: visibility1,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            visibility1 == true
                                ? setState(() {
                                    visibility1 = false;
                                  })
                                : setState(() {
                                    visibility1 = true;
                                  });
                          },
                          icon: visibility1 == true
                              ? const Icon(
                                  Icons.visibility_outlined,
                                )
                              : const Icon(
                                  Icons.visibility_off_outlined,
                                ),
                        ),
                        border: const OutlineInputBorder(),
                        hintText: 'Enter your password'
                      ),
                    ),
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: str.map((textList) {
                    return Row(children: [
                      const Text(
                        "\u2022",
                        style: TextStyle(fontSize: 14),
                      ), //bullet text
                      const SizedBox(
                        width: 10,
                      ), //space between bullet and text
                      Expanded(
                        child: Text(
                          textList,
                          style: const TextStyle(fontSize: 14),
                        ), //text
                      )
                    ]);
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Confirm password'),
                    TextField(
                      controller: _newPassword1,
                      obscureText: visibility2,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            visibility2 == true
                              ? setState(() {
                                  visibility2 = false;
                                })
                              :setState(() {
                              visibility2 = true;
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
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: LongGradientButton(
                    title: 'Finish', 
                    onPressed: () async{
                      if(newPassword == newPassword1){
                        bool isSuccess = await forgotPassWordController.resetPassword(
                          forgotPasswordEmail.email, 
                          newPassword
                        );
                        if(isSuccess == true){
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            barrierDismissible: true, // Set to true if you want to allow dismissing the dialog by tapping outside it
                            builder: (BuildContext context) {
                              return BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 20,
                                    sigmaY:
                                      20), // Adjust the blur intensity as needed
                                child: SizedBox(
                                  height: 100,
                                  child: AlertDialog(
                                    title: const Center(
                                      child: Icon(
                                        size: 60,
                                        Icons.check_circle_outlined,
                                      ),
                                    ),
                                    content: const Padding(
                                      padding: EdgeInsets.only(left: 60.0),
                                      child: Text('Otp Verified, Proceed to set new password'),
                                    ),
                                    actions: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 30.0),
                                        child: DialogGradientButton(
                                          title: 'Proceed',
                                          onPressed: () async {
                                            Get.to(()=> Login());
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }else{
                          ErrorSnackbar.show(context, 'Email not succesfully set');
                        }
                      }
                    }
                  ),
                ),
                // const ProgressIndicatorBar(),
              ),
            ]
          ),
        ),
      ),
    );
  }
}