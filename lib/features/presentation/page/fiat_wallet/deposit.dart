import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/controllers/user/user_controller.dart';

import '../../../../consts.dart';
import '../../widgets/widgets.dart';
import '../home.dart';

class Deposit extends StatefulWidget {
  const Deposit({Key? key}) : super(key: key);

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(
                        width: double.infinity,
                        child: Text("Deposit",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600))),
                    const SizedBox(
                        width: double.infinity,
                        child: Text(
                            "Transfer the funds into this account details",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400))),
                    sizeVer(10),
                    const Text(
                      'Note: You would be charged NGN 10 from your virtual account wallet ',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    sizeVer(50),
                    Container(
                      // height: 235,
                      decoration: BoxDecoration(
                          color: const Color(0xffC8E5D3),
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Account Details",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const Text("Bank Name",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff444444))),
                            Text(
                                "${userController.userModel.value.virtualAccountBankName}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff444444))),
                            sizeVer(10),
                            // const Text("Account Name",
                            //     style: TextStyle(
                            //         fontSize: 10,
                            //         fontWeight: FontWeight.w400,
                            //         color: Color(0xff444444))),
                            // const Text("User account",
                            //     style: TextStyle(
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.w600,
                            //         color: Color(0xff444444))),
                            // sizeVer(10),
                            const Text("Account Number",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff444444))),
                            Text(
                                "${userController.userModel.value.virtualAccountNumber}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff444444))),
                            sizeVer(10),
                            const Text("Account name",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff444444))),
                            Text(
                                "${userController.userModel.value.virtual_account_name}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff444444))),
                            sizeVer(10),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "NOTE:  ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Flexible(
                                  child: Text(
                                    textAlign: TextAlign.left,
                                    "Once you've made the transfer you would get an email ",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            sizeVer(20),
                            Center(
                              child: Container(
                                height: 40,
                                // width: 114,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      Color(0xff29844B),
                                      Color(0xff072C27)
                                    ]),
                                    borderRadius: BorderRadius.circular(5)),
                                child: ElevatedButton(
                                    onPressed: () {
                                      String textToCopy =
                                          "${userController.userModel.value.virtualAccountNumber}";

                                      // Use the Clipboard.setData method to copy text to the clipboard.
                                      Clipboard.setData(
                                          ClipboardData(text: textToCopy));

                                      // Show a message indicating that the text was copied.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Account number copied to clipboard"),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      minimumSize: const Size(185, 60),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                            child: Text(
                                          'Copy',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                        const SizedBox(width: 10.0),
                                        const Icon(Icons.content_copy_outlined,
                                            color: Colors.white),
                                      ],
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    sizeVer(20),
                    // Container(
                    //   // height: 136,
                    //     decoration: BoxDecoration(
                    //       color: const Color(0xffC8E5D3),
                    //       borderRadius: BorderRadius.circular(7),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(10.0),
                    //       child: Column(
                    //         //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: [
                    //             Row(
                    //                 mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   const Text("Price of product",
                    //                       style: TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w400,
                    //                           color: Color(0xff444444))),
                    //                   Text(
                    //                       "NGN ${cartController.succesfullTransactionModel!.productCost ?? ""}",
                    //                       style: const TextStyle(
                    //                           fontSize: 16,
                    //                           fontWeight: FontWeight.w600,
                    //                           color: Color(0xff444444)))
                    //                 ]),
                    //             sizeVer(30),
                    //             Row(
                    //                 mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   const Text("Price of delivery",
                    //                       style: TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w400,
                    //                           color: Color(0xff444444))),
                    //                   Text(
                    //                       "NGN ${cartController.succesfullTransactionModel!.totalShippingCost ?? ""}",
                    //                       style: const TextStyle(
                    //                           fontSize: 16,
                    //                           fontWeight: FontWeight.w600,
                    //                           color: Color(0xff444444)))
                    //                 ]),
                    //             sizeVer(30),
                    //             Row(
                    //                 mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   const Text("Total Price",
                    //                       style: TextStyle(
                    //                           fontSize: 14,
                    //                           fontWeight: FontWeight.w400,
                    //                           color: Color(0xff444444))),
                    //                   Text(
                    //                       "NGN ${cartController.succesfullTransactionModel!.totalShippingCost! + cartController.succesfullTransactionModel!.productCost! ?? ""}",
                    //                       style: const TextStyle(
                    //                           fontSize: 16,
                    //                           fontWeight: FontWeight.w600,
                    //                           color: Color(0xff444444)))
                    //                 ])
                    //           ]),
                    //     )),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: LongGradientButton(
                      title: 'Finish',
                      onPressed: () {
                        successDialog(context);
                      }))
            ],
          ),
        )));
  }
}

Future<dynamic> successDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible:
        true, // Set to true if you want to allow dismissing the dialog by tapping outside it
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 20, sigmaY: 20), // Adjust the blur intensity as needed
        child: Container(
          // height: 100,
          child: AlertDialog(
            content: Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Container(
                    // width: 220,
                    height: 180,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/Checkbox.svg',
                                height: 72,
                                width: 72,
                              ),
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    'Continue to wallet',
                                    style: TextStyle(
                                        color: Color(0xff444444),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ])))),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: DialogGradientButton(
                  title: 'Proceed',
                  onPressed: () {
                    Navigator.pop(context);
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
}
