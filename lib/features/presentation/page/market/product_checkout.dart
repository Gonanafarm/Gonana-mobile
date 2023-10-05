import 'dart:ui';

import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/controllers/cart/cart_controller.dart';
import 'package:gonana/features/presentation/page/home.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../settings/settiings_profile.dart';

class ProductCheckout extends StatefulWidget {
  const ProductCheckout({super.key});

  @override
  State<ProductCheckout> createState() => _ProductCheckoutState();
}

final cartController = Get.find<CartController>();

class _ProductCheckoutState extends State<ProductCheckout> {
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
                        child: Text("The Product",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600))),
                    const SizedBox(
                        width: double.infinity,
                        child: Text(
                            "Use the details below to pay for your goods ",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400))),
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
                                  "Accout Details",
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
                                cartController
                                        .succesfullTransactionModel!.bankName ??
                                    "",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff444444))),
                            sizeVer(10),
                            const Text("Account Name",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff444444))),
                            Text(
                                cartController.succesfullTransactionModel!
                                        .accountName ??
                                    "",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff444444))),
                            sizeVer(10),
                            const Text("Account Number",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff444444))),
                            Text(
                                cartController.succesfullTransactionModel!
                                        .accountNumber ??
                                    "",
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
                                    textAlign: TextAlign.center,
                                    "Once you've made payment and your order has been confirmed you would get and email",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            )
                            // sizeVer(10),
                            // Center(
                            //   child: Container(
                            //     height: 40,
                            //     width: 114,
                            //     decoration: BoxDecoration(
                            //         gradient: const LinearGradient(colors: [
                            //           Color(0xff29844B),
                            //           Color(0xff072C27)
                            //         ]),
                            //         borderRadius: BorderRadius.circular(5)),
                            //     child: ElevatedButton(
                            //         onPressed: () {},
                            //         style: ElevatedButton.styleFrom(
                            //           backgroundColor: Colors.transparent,
                            //           shadowColor: Colors.transparent,
                            //           shape: RoundedRectangleBorder(
                            //             borderRadius:
                            //                 BorderRadius.circular(5.0),
                            //           ),
                            //           minimumSize: const Size(185, 60),
                            //         ),
                            //         child: const Row(
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: [
                            //             Flexible(child: Text('Share')),
                            //             const SizedBox(width: 10.0),
                            //             const Icon(Icons.content_copy_outlined),
                            //           ],
                            //         )),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                    sizeVer(20),
                    Container(
                        // height: 136,
                        decoration: BoxDecoration(
                          color: const Color(0xffC8E5D3),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Price of product",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff444444))),
                                      Text(
                                          "NGN ${cartController.succesfullTransactionModel!.productCost ?? ""}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff444444)))
                                    ]),
                                sizeVer(30),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Price of delivery",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff444444))),
                                      Text(
                                          "NGN ${cartController.succesfullTransactionModel!.totalShippingCost ?? ""}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff444444)))
                                    ]),
                                sizeVer(30),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Total Price",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff444444))),
                                      Text(
                                          "NGN ${cartController.succesfullTransactionModel!.totalShippingCost! + cartController.succesfullTransactionModel!.productCost! ?? ""}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff444444)))
                                    ])
                              ]),
                        )),
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

class ConfirmChoice extends StatelessWidget {
  const ConfirmChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Container(
          width: 220,
          height: 366,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/Checkbox.svg',
                      height: 72,
                      width: 72,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'You\'ve order\nhas been placed',
                        style: TextStyle(
                            color: Color(0xff444444),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Product would be shipped\nout once your payment is\nconfirmed',
                        style: TextStyle(
                            color: Color(0xff444444),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ShortGradientButton(
                          title: 'Confirmed',
                          onPressed: () {
                            //Take the user back to the market page
                          }),
                    ),
                  ]))),
    );
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
                    height: 230,
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
                                    'Your order\nhas been placed',
                                    style: TextStyle(
                                        color: Color(0xff444444),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'Product would be shipped\nout once your payment is\nconfirmed',
                                  style: TextStyle(
                                      color: Color(0xff444444),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ])))),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: DialogGradientButton(
                  title: 'Proceed',
                  onPressed: () {
                    Get.to(() => HomePage(navIndex: 0));
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
