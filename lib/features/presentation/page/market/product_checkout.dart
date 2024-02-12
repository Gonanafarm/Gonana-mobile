import 'dart:developer';
import 'dart:ui';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/controllers/cart/cart_controller.dart';
import 'package:gonana/features/presentation/page/home.dart';
import 'package:gonana/features/presentation/widgets/bottomsheets.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../controllers/auth/passcode_controller.dart';
import '../../widgets/numpad.dart';
import '../settings/settiings_profile.dart';
import 'cart_page.dart';

class ProductCheckout extends StatefulWidget {
  const ProductCheckout({super.key});

  @override
  State<ProductCheckout> createState() => _ProductCheckoutState();
}

class _ProductCheckoutState extends State<ProductCheckout> {
  final cartController = Get.find<CartController>();
  dynamic argument = Get.arguments;
  late String courier = argument['courier'];

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
                print(orderList);
                orderList.clear();
                Navigator.pop(context);
                print(orderList);
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
                        child: Text("This is the total cost you're to pay",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400))),
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          cartController
                                                      .succesfullTransactionModel !=
                                                  null
                                              ? Text(
                                                  "NGN ${cartController.succesfullTransactionModel!.productCost ?? "0"}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff444444)))
                                              : Text(""),
                                          sizeVer(5),
                                          cartController
                                                      .succesfullTransactionModel !=
                                                  null
                                              ? Text(
                                                  "\$ ${cartController.succesfullTransactionModel!.product_cost_in_usd ?? "0"}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff444444)))
                                              : Text(""),
                                        ],
                                      )
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          cartController
                                                      .succesfullTransactionModel !=
                                                  null
                                              ? Text(
                                                  "NGN ${cartController.succesfullTransactionModel!.totalShippingCost ?? "0"}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff444444)))
                                              : Text(""),
                                          cartController
                                                      .succesfullTransactionModel !=
                                                  null
                                              ? Text(
                                                  "\$ ${cartController.succesfullTransactionModel!.total_shipping_cost_in_usd ?? "0"}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff444444)))
                                              : Text(""),
                                        ],
                                      )
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
                                      cartController
                                                  .succesfullTransactionModel !=
                                              null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                    "NGN ${cartController.succesfullTransactionModel!.totalShippingCost != null ? (double.parse(cartController.succesfullTransactionModel!.totalShippingCost.toString()) + cartController.succesfullTransactionModel!.productCost!) : cartController.succesfullTransactionModel!.productCost!}",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff444444))),
                                                sizeVer(5),
                                                Text(
                                                    "\$ ${cartController.succesfullTransactionModel!.total_shipping_cost_in_usd != null ? (double.parse(cartController.succesfullTransactionModel!.total_shipping_cost_in_usd.toString()) + double.parse(cartController.succesfullTransactionModel!.product_cost_in_usd!)) : cartController.succesfullTransactionModel!.product_cost_in_usd!}",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff444444))),
                                              ],
                                            )
                                          : Text(""),
                                    ])
                              ]),
                        )),
                    sizeVer(20),
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
                                  "NOTE:  ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Flexible(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "Once payment is made processing of package will begin",
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
                                // height: 40,
                                // width: 114,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      Color(0xff29844B),
                                      Color(0xff072C27)
                                    ]),
                                    borderRadius: BorderRadius.circular(5)),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      // Get.to(
                                      //     () => const PayWithWalletPasscode(),
                                      //     arguments: {"courier": courier});
                                      checkout(context, courier);
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
                                            child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Pay'),
                                        )),
                                        const SizedBox(width: 10.0),
                                        // const Icon(Icons.content_copy_outlined),
                                      ],
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}

class PayWithWalletPasscode extends StatefulWidget {
  const PayWithWalletPasscode({super.key});

  @override
  State<PayWithWalletPasscode> createState() => _SendPasscodeState();
}

class _SendPasscodeState extends State<PayWithWalletPasscode> {
  bool isLoading = false;

  PasscodeController passcodeController = Get.put(PasscodeController());
  final cartController = Get.find<CartController>();

  final TextEditingController _passCodeController = TextEditingController();

  dynamic argument = Get.arguments;

  late String courier = argument['courier'];

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
                      bool isSuccess = await cartController.placeOrder(
                          orderList, courier, context);
                      if (isSuccess) {
                        setState(() {
                          isLoading = false;
                        });
                        log("Successfull Transaction");
                        cartController.totalPrice.value = 0;
                        orderList.clear();
                        SuccessSnackbar.show(
                            context, 'Order placed successfully');
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
                                    child: Text('Your order has been placed'),
                                  ),
                                  actions: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 30.0),
                                      child: Center(
                                        child: DialogGradientButton(
                                          title: 'Finish',
                                          onPressed: () async {
                                            print("here");
                                            Get.to(() => HomePage(navIndex: 0));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    } else {
                      log("Passcode Invalid");
                      ErrorSnackbar.show(context, 'Passcode Invalid');
                      setState(() {
                        isLoading = false;
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
                        'Your order has been placed',
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
