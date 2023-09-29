import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/page/auth/emailverification.dart';
import '../../../controllers/auth/sign_up_controller.dart';
import '/features/presentation/widgets/widgets.dart';
import 'number_verification_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _bvn = TextEditingController();
  String get firstName => _firstName.text;
  String get lastName => _lastName.text;
  String get phoneNumber => _phoneNumber.text;
  String get email => _email.text;
  String get password => _password.text;
  String get bvn => _bvn.text;
  final _signInkey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());
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
            ),
            color: const Color(0x0F000000),
          ),
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Signup',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text('Fill in these details to get started')
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                child: Form(
                                  key: _signInkey,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: Column(children: [
                                    EnterFormText(
                                        controller: _firstName,
                                        validator: inputValidator,
                                        label: 'First Name',
                                        hint: 'Click Here'),
                                    const SizedBox(height: 10),
                                    EnterFormText(
                                        controller: _lastName,
                                        validator: inputValidator,
                                        label: 'Surname',
                                        hint: 'Click Here'),
                                    const SizedBox(height: 10),
                                    EnterFormText(
                                        controller: _phoneNumber,
                                        validator: phoneValidator,
                                        keyboardType: TextInputType.number,
                                        label: 'Phone number',
                                        hint: 'Click Here'),
                                    const SizedBox(height: 10),
                                    EnterFormText(
                                        controller: _email,
                                        validator: emailValidator,
                                        label: 'Email',
                                        hint: 'Click Here'),
                                    EnterFormText(
                                        controller: _password,
                                        validator: passwordValidator,
                                        label: 'Password',
                                        hint: 'Click Here'),
                                    const SizedBox(height: 10),
                                    EnterFormText(
                                        controller: _bvn,
                                        validator: bvnValidator,
                                        label: 'BVN',
                                        hint:
                                            'Enter your Bank Verification Number'),
                                    const SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        'Dial the USSD code *565*0# to check your BVN',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ]),
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                  sizeVer(10),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: LongGradientButton(
                      isLoading: isLoading,
                      title: 'Proceed',
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        bool isValid = _signInkey.currentState!.validate();
                        if (isValid) {
                          bool isSuccess = await signUpController.signUp(
                            firstName,
                            lastName,
                            phoneNumber,
                            email,
                            password,
                            bvn,
                            context,
                          );
                          if (isSuccess) {
                            Get.to(() => const Verification());
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
                      },
                    ),
                  )
                ],
              )),
        ));
  }
}
