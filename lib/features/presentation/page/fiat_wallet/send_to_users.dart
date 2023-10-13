import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/controllers/fiat_wallet/transaction_controller.dart';
import 'package:gonana/features/presentation/page/home.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../services/local_auth_service.dart';
import '../../../controllers/auth/passcode_controller.dart';
import '../../../controllers/fiat_wallet/bank_controller.dart';
import '../../widgets/numpad.dart';
import '../../widgets/widgets.dart';

class SendToUsers extends StatefulWidget {
  const SendToUsers({Key? key}) : super(key: key);

  @override
  State<SendToUsers> createState() => _SendToUsersState();
}

class _SendToUsersState extends State<SendToUsers> {
  TransactionController transactionController =
      Get.put(TransactionController());
  BankController bankController = Get.put(BankController());
  final TextEditingController _email = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _narration = TextEditingController();
  final _sendKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                Navigator.pop(context);
              })),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Send to gonana user',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                        const Text(
                          'Enter the amount you want to send',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.left,
                        ),
                        sizeVer(10),
                        const Text(
                          'Note: You would be charged NGN 15  for your transfer ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Form(
                          key: _sendKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 8.0),
                                child: SizedBox(
                                  child: EnterFormText(
                                      controller: _email,
                                      validator: emailValidator,
                                      keyboardType: TextInputType.emailAddress,
                                      label: 'Email',
                                      hint:
                                          'Enter the email of the account you want to transfer to'),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 8.0),
                                child: SizedBox(
                                  child: EnterFormText(
                                      controller: _amount,
                                      validator: inputValidator,
                                      keyboardType: TextInputType.number,
                                      label: 'Amount',
                                      hint:
                                          'Enter the amount you want to send'),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 8.0),
                                child: SizedBox(
                                  child: EnterFormText(
                                      controller: _narration,
                                      keyboardType: TextInputType.text,
                                      label: 'Narration(optional)',
                                      hint: 'Enter your narration'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  LongGradientButton(
                      isLoading: isLoading,
                      title: 'Proceed',
                      onPressed: () async {
                        String balance =
                            transactionController.balanceModel!.value.balance ??
                                '';
                        if (int.parse(_amount.text) < 0) {
                          ErrorSnackbar.show(
                              context, "You can't withdraw this amount");
                        } else if (_amount.text.compareTo(balance) > 0) {
                          ErrorSnackbar.show(context, "Insufficient fund");
                        } else {
                          bool isValid = _sendKey.currentState!.validate();
                          if (isValid!) {
                            setState(() {
                              isLoading = true;
                            });
                            Get.to(() => SendPasscode(), arguments: {
                              "email": _email.text,
                              "amount": _amount.text,
                              "narration": _narration.text
                            });
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      })
                ])),
      ),
    );
  }
}

class SendPasscode extends StatefulWidget {
  SendPasscode({super.key});

  @override
  State<SendPasscode> createState() => _SendPasscodeState();
}

class _SendPasscodeState extends State<SendPasscode> {
  bool isLoading = false;

  PasscodeController passcodeController = Get.put(PasscodeController());

  TransactionController transactionController =
      Get.put(TransactionController());

  final TextEditingController _passCodeController = TextEditingController();

  dynamic argument = Get.arguments;

  late String email = argument['email'];

  late String amount = argument['amount'];

  late String narration = argument['narration'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF1F1F1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 20,
                color: Color(0xff292D32),
              )),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Four Digit Passcode',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600)),
                                  const Text(
                                      'Enter you four digit password to verify your transaction',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0, vertical: 50.0),
                                    child: PinCodeTextField(
                                      controller: _passCodeController,
                                      obscureText: true,
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        borderRadius: BorderRadius.circular(5),
                                        borderWidth: 1,
                                        fieldHeight: 60.0,
                                        fieldWidth: 52.0,
                                        activeColor: const Color(0xff444444),
                                        disabledColor: const Color(0xff444444),
                                        inactiveColor: const Color(0xff444444),
                                      ),
                                      appContext: context,
                                      length: 4,
                                      onChanged: (String value) {
                                        print(value);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                      // height: 400,
                                      // width: 310,
                                      child: NumPad(
                                    controller: _passCodeController,
                                    delete: () {},
                                    // faceIdFunction: () async {
                                    //   final bool authenticate =
                                    //       await LocalAuth.authenticate();
                                    //   if (authenticate) {
                                    //     print("Face is authenticated");
                                    //     showDialog(
                                    //       context: context,
                                    //       barrierDismissible:
                                    //           true, // Set to true if you want to allow dismissing the dialog by tapping outside it
                                    //       builder: (BuildContext context) {
                                    //         return BackdropFilter(
                                    //           filter: ImageFilter.blur(
                                    //               sigmaX: 20,
                                    //               sigmaY:
                                    //                   20), // Adjust the blur intensity as needed
                                    //           child: Container(
                                    //             height: 100,
                                    //             child: AlertDialog(
                                    //               title: Center(
                                    //                 child: Icon(
                                    //                   size: 60,
                                    //                   Icons
                                    //                       .check_circle_outlined,
                                    //                 ),
                                    //               ),
                                    //               content: Padding(
                                    //                 padding:
                                    //                     const EdgeInsets.only(
                                    //                         left: 60.0),
                                    //                 child: Text(
                                    //                     'Transaction Successful'),
                                    //               ),
                                    //               actions: [
                                    //                 Padding(
                                    //                   padding:
                                    //                       const EdgeInsets.only(
                                    //                           right: 30.0),
                                    //                   child:
                                    //                       DialogGradientButton(
                                    //                     title: 'Proceed',
                                    //                     onPressed: () async {
                                    //                       Get.to(() => HomePage(
                                    //                           navIndex: 1));
                                    //                     },
                                    //                   ),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         );
                                    //       },
                                    //     );
                                    //   }
                                    // },
                                  )),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: LongGradientButton(
                  isLoading: isLoading,
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    bool isPasscode = await passcodeController
                        .verifyPasscode(_passCodeController.text);
                    if (isPasscode == true) {
                      log("Correct passcode");
                      bool transactionSucces = await transactionController
                          .gonanaTransfer(email, int.parse(amount), narration);
                      if (transactionSucces == true) {
                        setState(() {
                          isLoading = false;
                        });
                        log("Successfull Transaction");
                        SuccessSnackbar.show(context, 'Succesfull Transaction');
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Set to true if you want to allow dismissing the dialog by tapping outside it
                          builder: (BuildContext context) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: 20,
                                  sigmaY:
                                      20), // Adjust the blur intensity as needed
                              child: Container(
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
                                    child: Text('Transaction Successful'),
                                  ),
                                  actions: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 30.0),
                                      child: DialogGradientButton(
                                        title: 'Finish',
                                        onPressed: () async {
                                          print("here");
                                          Get.to(() => HomePage(navIndex: 1));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        log("Failed Transaction");
                        ErrorSnackbar.show(context, 'Transaction Failed');
                      }
                    } else {}
                  },
                  title: 'Proceed',
                ),
              )
            ],
          ),
        ));
  }
}
