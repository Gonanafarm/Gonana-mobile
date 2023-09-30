import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/cart/cart_controller.dart';
import 'package:gonana/features/presentation/page/market/hot_deals.dart';
import 'package:gonana/features/presentation/page/market/product_checkout.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import 'package:gonana/consts.dart';

class AddressCourier extends StatefulWidget {
  const AddressCourier({super.key});

  @override
  State<AddressCourier> createState() => _AddressCourierState();
}

class _AddressCourierState extends State<AddressCourier> {
  CartController cartController = Get.put(CartController());
  final TextEditingController _address = TextEditingController();
  String get address => _address.text;
  bool isValidated = false;
  @override
  void initState() {
    super.initState();
    cartController.fetchActiveCourier();
  }

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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                      //width: double.infinity,
                      child: isValidated
                          ? Image.asset('assets/images/check.png',
                              height: 30, width: 30, fit: BoxFit.fill)
                          : Image.asset('assets/images/checked.png',
                              height: 30, width: 30, fit: BoxFit.fill)),
                  sizeHor(10),
                  const Text('Delivery Address',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: EnterText(
                    label: 'Address',
                    hint: 'Enter delivery address',
                    controller: _address),
              ),
              ShortGradientButton(
                  title: 'Validate',
                  onPressed: () async {
                    var isSuccess =
                        await cartController.validateAddress(address);
                    if (isSuccess == true) {
                      log('isSUccess: $isSuccess');
                      SuccessSnackbar.show(
                          context, 'Address succesfully validated');
                      setState(() {
                        isValidated = true;
                      });
                    } else {
                      ErrorSnackbar.show(context, 'Address not validated');
                    }
                  }),
              const Divider(),
              const SizedBox(
                width: double.infinity,
                child: Text('Courier Service',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.left),
              ),
              sizeVer(10),
              Container(
                //height: MediaQuery.of(context).size.height * 0.75,
                child: SingleChildScrollView(
                  child: Container(
                    //height: MediaQuery.of(context).size.height * 0.85,
                    color: const Color(0xffF1F1F1),
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            sizeVer(10),
                            SizedBox(
                              // height: 60,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      // width: double.infinity,
                                      child: Text(
                                          'These are logistics companies that we recommend',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.left),
                                    ),
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          productController
                                              .updateLogisticsMerchants(
                                                  "Red Star Logistics");
                                        },
                                        child: Container(
                                            height: 56,
                                            // width: 342,
                                            color: Colors.white,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                      'assets/images/redstarLogo.png',
                                                      height: 38,
                                                      width: 38,
                                                      fit: BoxFit.contain),
                                                  const Text(
                                                    'Red Star Logistics',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(Icons
                                                          .arrow_forward_ios)),
                                                ])),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          productController
                                              .updateLogisticsMerchants(
                                                  "DHL Logistics");
                                        },
                                        child: Container(
                                            height: 56,
                                            // width: 342,
                                            color: Colors.white,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                      'assets/images/dhllogo.png',
                                                      height: 38,
                                                      width: 38,
                                                      fit: BoxFit.contain),
                                                  const Text(
                                                    'DHL Logistics',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(Icons
                                                          .arrow_forward_ios)),
                                                ])),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          productController
                                              .updateLogisticsMerchants(
                                                  "DHL Logistics");
                                        },
                                        child: Container(
                                            height: 56,
                                            // width: 342,
                                            color: Colors.white,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Image.asset(
                                                      'assets/images/dhllogo.png',
                                                      height: 38,
                                                      width: 38,
                                                      fit: BoxFit.contain),
                                                  const Text(
                                                    'DHL Logistics',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(Icons
                                                          .arrow_forward_ios)),
                                                ])),
                                      ),
                                    ),
                                  ]),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
              sizeVer(45),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: LongGradientButton(
                      title: 'Proceed to pay',
                      onPressed: () {
                        Get.to(() => ProductCheckout());
                        // cartController.checkOut(order, serviceCode)
                      })),
            ],
          ),
        )));
  }
}
