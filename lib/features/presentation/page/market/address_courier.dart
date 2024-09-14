import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/cart/cart_controller.dart';
import 'package:gonana/features/presentation/page/market/product_checkout.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import 'package:gonana/consts.dart';

import 'cart_page.dart';

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
  // bool isiTemSelected = false;
  bool isLoading = false;
  String selectedCourier = " ";
  var courierItem;
  bool isiTemSelected = false;
  var selectedValue = '';

  @override
  void initState() {
    super.initState();
    cartController.fetchActiveCourier();
  }

  @override
  void dispose() {
    orderList.clear();
    super.dispose();
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
                orderList.clear();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: EnterText(
                      label: 'Delivery Address',
                      hint: 'eg: no 4 Jedo estate, Abuja , Nigeria',
                      controller: _address),
                ),
                ShortGradientButton(
                    title: 'Validate',
                    onPressed: () async {
                      var isSuccess = await cartController.validateAddress(
                          address, context);
                      if (isSuccess == true) {
                        log('isSUccess: $isSuccess');
                        SuccessSnackbar.show(
                            context, 'Address succesfully validated');
                        setState(() {
                          isValidated = true;
                        });
                      } else {
                        // ErrorSnackbar.show(context, 'Address not validated');
                      }
                    }),
                const Divider(),
                const SizedBox(
                  width: double.infinity,
                  child: Text('Courier Service',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.left),
                ),
                // sizeVer(10),
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
                                            'These are the logistics companies that we recommend',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.left),
                                      ),
                                      // const SizedBox(height: 20),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          child: cartController.courierModel !=
                                                  null
                                              ? ListView.builder(
                                                  itemCount: cartController
                                                          .courierModel
                                                          ?.couriers
                                                          ?.length ??
                                                      0,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final courierModel =
                                                        cartController
                                                            .courierModel;
                                                    if (courierModel == null ||
                                                        courierModel.couriers ==
                                                            null) {
                                                      // Handle null values as needed, e.g., return a placeholder widget.
                                                      return SizedBox(
                                                          child: Container());
                                                    }
                                                    if (index >=
                                                        courierModel
                                                            .couriers!.length) {
                                                      // Handle the case where the index is out of bounds.
                                                      return const SizedBox(); // Or any other appropriate handling.
                                                    }
                                                    courierItem = courierModel
                                                        .couriers![index];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7)),
                                                          child: RadioListTile<
                                                              String>(
                                                            activeColor:
                                                                greenColor,
                                                            controlAffinity:
                                                                ListTileControlAffinity
                                                                    .trailing,
                                                            toggleable: true,
                                                            value: courierItem
                                                                .serviceCode,
                                                            groupValue:
                                                                selectedValue,
                                                            title: Text(
                                                              courierItem.name,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            secondary:
                                                                Image.network(
                                                                    courierItem
                                                                        .pinImage,
                                                                    height: 38,
                                                                    width: 38,
                                                                    fit: BoxFit
                                                                        .contain),
                                                            onChanged: (value) {
                                                              log("tapped");
                                                              setState(() {
                                                                if (value ==
                                                                    null) {
                                                                  selectedValue !=
                                                                      value;
                                                                } else {
                                                                  selectedValue =
                                                                      value;
                                                                }
                                                                //selectedValue = widget.value;
                                                                isiTemSelected =
                                                                    true;
                                                                log("selectedValue: $selectedValue");
                                                              });
                                                            },
                                                          )),
                                                    );
                                                  },
                                                )
                                              : SizedBox(child: Container())),
                                      // sizeVer(20),
                                    ]),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
                // sizeVer(45),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: LongGradientButton(
                        isLoading: isLoading,
                        title: 'Proceed to pay',
                        onPressed: () async {
                          // cartController.checkOut(order, serviceCode)
                          // Get.to(() => const AddressCourier());
                          // Passes the value here
                          print(courierItem.serviceCode);
                          // bool isSuccess = await cartController.getRates(
                          //     orderList, courierItem.serviceCode, context);
                          // if (isSuccess) {
                          //   Get.to(() => const ProductCheckout(), arguments: {
                          //     "courier": courierItem.serviceCode
                          //   });
                          // }
                          // setState(() {
                          //   isLoading = false;
                          // });
                          if (isValidated && isiTemSelected) {
                            setState(() {
                              isLoading = true;
                            });
                            if (isiTemSelected) {
                              setState(() {
                                isLoading = true;
                              });
                              bool isSuccess = await cartController.getRates(
                                  orderList, courierItem.serviceCode, context);
                              if (isSuccess) {
                                Get.to(() => const ProductCheckout(),
                                    arguments: {
                                      "courier": courierItem.serviceCode
                                    });
                              }
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              ErrorSnackbar.show(context,
                                  "Validate your address and select your Courier service");
                            }
                          }
                        }))
              ],
            ),
          ),
        )));
  }
}

// bool isiTemSelected = false;
String? selectedValue = 'test';

class CourierWidget extends StatefulWidget {
  final String title;
  final String value;
  final String imageUrl;
  final int index;

  const CourierWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.imageUrl,
    required this.index,
  }) : super(key: key);

  @override
  State<CourierWidget> createState() => _CourierWidgetState();
}

class _CourierWidgetState extends State<CourierWidget> {
  bool isSelected = false; // Local isSelected state for each widget

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(7)),
          child: RadioListTile<String>(
            controlAffinity: ListTileControlAffinity.trailing,
            toggleable: true,
            value: widget.value,
            groupValue: selectedValue,
            title: Text(
              widget.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            secondary: Image.network(widget.imageUrl,
                height: 38, width: 38, fit: BoxFit.contain),
            onChanged: (value) {
              log("tapped");
              setState(() {
                if (value == null) {
                  selectedValue = null;
                } else {
                  selectedValue = value;
                }
                //selectedValue = widget.value;
                log("selectedValue: $selectedValue");
              });
            },
          )),
    );
  }
}
