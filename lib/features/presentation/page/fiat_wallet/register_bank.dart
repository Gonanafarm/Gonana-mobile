import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/controllers/fiat_wallet/transaction_controller.dart';
import 'package:gonana/features/presentation/page/market/cart_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../services/local_auth_service.dart';
import '../../../controllers/auth/passcode_controller.dart';
import '../../../controllers/fiat_wallet/bank_controller.dart';
import '../../../controllers/user/user_controller.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/numpad.dart';
import '../../widgets/widgets.dart';
import '../home.dart';
import '../profile_photo/add_profile_photo1.dart';
import '../store/store_confirm_screen.dart';

class RegisterBank extends StatefulWidget {
  const RegisterBank({Key? key}) : super(key: key);

  @override
  State<RegisterBank> createState() => _RegisterBankState();
}

class _RegisterBankState extends State<RegisterBank> {
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _narration = TextEditingController();
  BankController bankController = Get.put(BankController());
  final userController = Get.find<UserController>();
  String selectedBank = "";
  bool isLoading = false;
  final _sendBankKey = GlobalKey<FormState>();
  String dropDownError = "";

  @override
  void initState() {
    super.initState();
    bankController.fetchBank();
  }

  Future<List<String>> fetchData() async {
    // Simulate asynchronous data fetching (replace with your actual data fetching logic)
    await Future.delayed(Duration(seconds: 2));
    return bankController.banks; // Replace with your data
  }

  Future fetchAccountDetails() async {
    return bankController.resolveBankModel!.data!.data!.accountName;
  }

  final transactionController = Get.find<TransactionController>();
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
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Send to bank',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Text(
                      'Enter the amount and account you want to withdraw to ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    sizeVer(10),
                    const Text(
                      'Note: You would be charged NGN 15  for your withdrawal ',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    sizeVer(20),
                    Form(
                      key: _sendBankKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bank',
                            style: TextStyle(
                              color: Color(0xFF444444),
                              fontSize: 16,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          FutureBuilder(
                              future: fetchData(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Return a loading indicator while data is being fetched
                                  return Container(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  // Handle error
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  // Handle the case where data is empty
                                  return Text('No data available');
                                } else {
                                  return CustomDropDown(
                                    labelText: "Bank",
                                    options: bankController.banks,
                                    onChanged: (option) {
                                      setState(() {
                                        selectedBank = option;
                                      });
                                    },
                                    hintText: 'Select your bank',
                                    fillColor: Colors.transparent,
                                    elevation: 2,
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        12, 10, 15, 4),
                                    hidesUnderline: true,
                                    initialOption: selectedBank,
                                  );
                                }
                              }),
                          Text(
                            dropDownError,
                            style: const TextStyle(color: Colors.red),
                          ),
                          sizeVer(15),
                          EnterFormText(
                            onChanged: (value) async {
                              _accountNumber.text = value;
                              if (_accountNumber.text.length == 10 &&
                                  selectedBank.isNotEmpty) {
                                try {
                                  String? bankName =
                                      await bankController.fetchAccountName(
                                    selectedBank,
                                    _accountNumber.text.trim(),
                                  );

                                  setState(() {
                                    bankController.resolveBankModel!.data!.data!
                                        .accountName = bankName;
                                  });
                                } catch (error) {
                                  // Handle any errors that occur during the async operation.
                                }
                              }
                            },
                            controller: _accountNumber,
                            keyboardType: TextInputType.number,
                            label: 'Account number',
                            hint: 'Enter your account number',
                            validator: inputValidator,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Account Name: ',
                                  style: TextStyle(
                                    color: Color(0xFF29844B),
                                    fontSize: 10,
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (bankController.resolveBankModel != null &&
                                    bankController.resolveBankModel!.data !=
                                        null &&
                                    bankController
                                            .resolveBankModel!.data!.data !=
                                        null &&
                                    bankController.resolveBankModel!.data!.data!
                                            .accountName !=
                                        null &&
                                    bankController.resolveBankModel!.data!.data!
                                        .accountName!.isNotEmpty) ...[
                                  FutureBuilder<String?>(
                                    future: bankController.fetchAccountName(
                                        selectedBank,
                                        _accountNumber.text.trim()),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else if (!snapshot.hasData ||
                                          snapshot.data == null) {
                                        return Text('No data available');
                                      } else {
                                        return Text(
                                          snapshot.data!,
                                          style: TextStyle(
                                            color: Color(0xFF29844B),
                                            fontSize: 10,
                                            fontFamily: 'Proxima Nova',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        );
                                      }
                                    },
                                  )
                                ],
                              ],
                            ),
                          ),
                          sizeVer(5),
                          EnterFormText(
                            controller: _amount,
                            keyboardType: TextInputType.number,
                            label: 'Amount',
                            hint: 'Enter the amount you want to transfer',
                            validator: inputValidator,
                          ),
                          sizeVer(10),
                          EnterFormText(
                            controller: _narration,
                            keyboardType: TextInputType.number,
                            label: 'Narration (optional)',
                            hint: 'Enter your narration',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              LongGradientButton(
                  isLoading: isLoading,
                  title: "Proceed",
                  onPressed: () async {
                    selectedBank.isEmpty
                        ? setState(() {
                            dropDownError = "Select a bank";
                          })
                        : setState(() {
                            dropDownError = "";
                          });
                    String balance =
                        transactionController.balanceModel!.value.balance ?? '';
                    if (int.parse(_amount.text) < 0) {
                      ErrorSnackbar.show(
                          context, "You can't withdraw this amount");
                    } else if (_amount.text.compareTo(balance) > 0) {
                      ErrorSnackbar.show(context, "Insufficient fund");
                    } else {
                      bool isValid = _sendBankKey.currentState!.validate();
                      if (bankController.resolveBankModel != null &&
                          bankController.resolveBankModel!.data != null &&
                          bankController.resolveBankModel!.data!.data != null &&
                          bankController
                                  .resolveBankModel!.data!.data!.accountName !=
                              null &&
                          bankController.resolveBankModel!.data!.data!
                              .accountName!.isNotEmpty) {
                        if (isValid! &&
                            bankController.resolveBankModel!.data!.data!
                                .accountName!.isNotEmpty &&
                            selectedBank.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });
                          Get.to(() => SendPasscode(), arguments: {
                            "bankName": selectedBank,
                            "accountNumber": _accountNumber.text,
                            "amount": _amount.text,
                            "narration": _narration.text
                          });
                        }
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class SendPasscode extends StatefulWidget {
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

  late String bankName = argument['bankName'];

  late String accountNumber = argument['accountNumber'];

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
                                      'Enter you four digit password to withdraw from your account',
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
                                    //                     onPressed: () async {},
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
                    bool isPasscode = await passcodeController.verifyPasscode(
                        _passCodeController.text, context);
                    if (isPasscode == true) {
                      log("Correct passcode");
                      bool transactionSucces =
                          await transactionController.transferFunds(
                              double.parse(amount),
                              accountNumber,
                              bankName,
                              narration);
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
                                          print("Proceeded");
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
