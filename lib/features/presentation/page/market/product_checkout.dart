import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/controllers/cart/cart_controller.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

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
                      height: 235,
                      decoration: BoxDecoration(
                          color: const Color(0xffC8E5D3),
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
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
                            Center(
                              child: Container(
                                height: 40,
                                width: 114,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      Color(0xff29844B),
                                      Color(0xff072C27)
                                    ]),
                                    borderRadius: BorderRadius.circular(5)),
                                child: ElevatedButton(
                                    onPressed: () {},
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
                                        Flexible(child: Text('Share')),
                                        const SizedBox(width: 10.0),
                                        const Icon(Icons.content_copy_outlined),
                                      ],
                                    )),
                              ),
                            )
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
                                          "#${cartController.succesfullTransactionModel!.productCost ?? ""}",
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
                                          "#${cartController.succesfullTransactionModel!.totalShippingCost ?? ""}",
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
                                          "#${cartController.succesfullTransactionModel!.totalShippingCost! + cartController.succesfullTransactionModel!.productCost! ?? ""}",
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
                  child: LongGradientButton(title: 'Proceed', onPressed: () {}))
            ],
          ),
        )));
  }
}
