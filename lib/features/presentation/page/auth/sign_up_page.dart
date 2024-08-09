import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/page/auth/emailverification.dart';
import 'package:gonana/features/presentation/page/auth/sign_in_page.dart';
import 'package:gonana/features/presentation/page/market/cart_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controllers/auth/get_details.dart';
import '../../../controllers/auth/sign_up_controller.dart';
import '../../../controllers/user/user_controller.dart';
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
  final userController = Get.find<UserController>();
  bool visibility = false;
  GetDetailsController detailsController = Get.put(GetDetailsController());
  @override
  void initState() {
    super.initState();
    setStage();
  }

  setStage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('registrationStage', 1);
  }

  String countryValue = '';
  bool countryValueError = false;
  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());
    return Scaffold(
        backgroundColor: const Color(0xffF1F1F1),
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   leading: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: const Icon(
        //       Icons.arrow_back,
        //       color: Colors.black,
        //     ),
        //     color: const Color(0x0F000000),
        //   ),
        // ),
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
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                        sizeVer(20),
                                        const Text(
                                          "  Password",
                                          textAlign: TextAlign.left,
                                        ),
                                        TextFormField(
                                          controller: _password,
                                          obscureText: visibility,
                                          validator: passwordValidator,
                                          decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: greenColor)),
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
                                                        Icons
                                                            .visibility_outlined,
                                                      )
                                                    : const Icon(
                                                        Icons
                                                            .visibility_off_outlined,
                                                      ),
                                              ),
                                              border:
                                                  const OutlineInputBorder(),
                                              hintText: 'Enter your password'),
                                        ),
                                        const SizedBox(height: 10),
                                        CSCPicker(
                                          showCities: false,
                                          showStates: false,
                                          dropdownDecoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: countryValueError
                                                      ? Colors.red
                                                      : Colors.grey,
                                                  width: 1)),
                                          onCountryChanged: (value) {
                                            setState(() {
                                              countryValue = value;
                                              countryValueError = false;
                                            });
                                          },
                                          onStateChanged: (state) {
                                            if (state != null) {
                                              setState(() {
                                                var selectedState = state!;
                                              });
                                            }
                                          },
                                          onCityChanged: (city) {
                                            if (city != null) {
                                              setState(() {
                                                var selectedCity = city!;
                                              });
                                            }
                                          },
                                        ),
                                        countryValueError == true
                                            ? const Text(
                                                "Select a country",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )
                                            : const Text("")
                                        // EnterFormText(
                                        //     controller: _bvn,
                                        //     validator: bvnValidator,
                                        //     label: 'BVN',
                                        //     hint:
                                        //         'Enter your Bank Verification Number'),
                                        // const SizedBox(
                                        //   width: double.infinity,
                                        //   child: Text(
                                        //     'Dial the USSD code *565*0# to check your BVN',
                                        //     style: TextStyle(
                                        //         fontSize: 10,
                                        //         fontWeight: FontWeight.w600),
                                        //   ),
                                        // )
                                      ]),
                                ),
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    Get.offAll(() => const Login());
                                  },
                                  child: const Text(
                                      'Already have an account? Login',
                                      style: TextStyle(color: Colors.blue)),
                                ),
                              ),
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
                        bool isValid = _signInkey.currentState!.validate();
                        if (isValid && !countryValueError) {
                          setState(() {
                            isLoading = true;
                          });
                          bool isSuccess = await signUpController.signUp(
                            firstName,
                            lastName,
                            phoneNumber,
                            email,
                            password,
                            countryValue,
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
                          // setState(() {
                          //   countryValueError = true;
                          // });
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
