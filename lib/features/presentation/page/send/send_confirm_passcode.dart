import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/features/presentation/page/home.dart';
import 'package:gonana/features/presentation/widgets/numpad.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../controllers/auth/passcode_controller.dart';
import '../../../controllers/fiat_wallet/transaction_controller.dart';
import '../wallet/wallet_page.dart';

class SendCryptoPasscode extends StatefulWidget {
  final bool withdraw;
  const SendCryptoPasscode({super.key, required this.withdraw});

  @override
  State<SendCryptoPasscode> createState() => _SendPasscodeState();
}

class _SendPasscodeState extends State<SendCryptoPasscode> {
  PasscodeController passcodeController = Get.put(PasscodeController());

  TextEditingController _passCodeController = TextEditingController();

  String get passCode => _passCodeController.text;
  TransactionController transactionController =
      Get.put(TransactionController());
  bool isLoading = false;

  dynamic argument = Get.arguments;

  late String amount = argument['amount'];

  late String walletAddress = argument['walletAddress'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back,
                    size: 20, color: Color(0xff292D32)))),
        body: Padding(
          padding: EdgeInsets.all(24.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      'Four Digit Passcode',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                        'Enter you four digit password to confirm this\n transaction',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400))
                  ],
                ),
              ),
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: NumPad(
                  controller: _passCodeController,
                  delete: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: LongGradientButton(
                  isLoading: isLoading,
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    print("passcode: $passCode");
                    bool created = await passcodeController.verifyPasscode(
                        passCode, context);
                    if (created) {
                      bool isSuccess = await transactionController.sendToken(
                          amount, walletAddress, widget.withdraw, context);
                      print(amount);
                      print(walletAddress);
                      if (isSuccess) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          // Set to true if you want to allow dismissing the dialog by tapping outside it
                          builder: (BuildContext context) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: 20,
                                  sigmaY:
                                      20), // Adjust the blur intensity as needed
                              child: Container(
                                height: 100,
                                child: AlertDialog(
                                  title: Center(
                                    child: Icon(
                                      size: 60,
                                      Icons.check_circle_outlined,
                                    ),
                                  ),
                                  content: Padding(
                                    padding: const EdgeInsets.only(left: 60.0),
                                    child: Text('Transaction Succesful'),
                                  ),
                                  actions: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 30.0),
                                      child: DialogGradientButton(
                                        title: 'Proceed',
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            Get.offAll(
                                                () => HomePage(navIndex: 1));
                                          });
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
                        setState(() {
                          isLoading =
                              false; // Set isLoading to false on failure
                        });
                      }
                    } else {
                      setState(() {
                        isLoading = false; // Set isLoading to false on failure
                      });
                    }
                  },
                  title: 'Proceed',
                ),
              )
            ],
          ),
        ));
  }
}
