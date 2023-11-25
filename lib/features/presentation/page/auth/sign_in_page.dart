import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gonana/consts.dart';
import '../../../controllers/auth/get_details.dart';
import '../../../controllers/auth/password_controller.dart';
import '../../../controllers/auth/sign_in_controller.dart';
import '../home.dart';
import '../market/market_page.dart';
import '/features/presentation/widgets/widgets.dart';
import 'package:get/get.dart';

import 'forgotpassword.dart';
import 'sign_up_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String get email => _email.text;
  String get password => _password.text;
  final _signInkey = GlobalKey<FormState>();

  bool visibility = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    SignInController signInController = Get.put(SignInController());
    return Scaffold(
        backgroundColor: const Color(0xffF1F1F1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
              child: ListView(children: [
                Container(
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Hey There,',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'The Gonana universe is here.',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 65),
                SizedBox(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Form(
                            key: _signInkey,
                            //autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const Text(
                                //   'Email',
                                //   textAlign: TextAlign.left,
                                // ),
                                EnterFormText(
                                    controller: _email,
                                    validator: emailValidator,
                                    label: 'Email',
                                    hint: 'Enter your email address'),
                                const SizedBox(height: 12),
                                const Text('Password'),
                                TextFormField(
                                  controller: _password,
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
                                            ? const Icon(
                                                Icons.visibility_outlined,
                                              )
                                            : const Icon(
                                                Icons.visibility_off_outlined,
                                              ),
                                      ),
                                      border: const OutlineInputBorder(),
                                      hintText: 'Enter your password'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => ForgotPassword());
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text('Forgot Password?',
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: LongGradientButton(
                              isLoading: isLoading,
                              title: 'Login',
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                bool isValid =
                                    _signInkey.currentState!.validate();
                                if (isValid) {
                                  bool isSuccess = await signInController
                                      .signIn(email, password, context);
                                  log('isSuccess: $isSuccess');
                                  if (isSuccess == true) {
                                    // Get.to(() => HomePage(navIndex: 0));
                                  } else {
                                    setState(() {
                                      isLoading =
                                          false; // Set isLoading to false on failure
                                    });
                                  }
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              })),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Get.to(() => const SignUp());
                            },
                            child: const Text('signup as new user',
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                      ]),
                )
              ]),
            ),
          ),
        ));
  }
}
