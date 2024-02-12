import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/controllers/cart/cart_controller.dart';
import 'package:gonana/features/controllers/crypto/cryptoController.dart';
import 'package:gonana/features/presentation/page/auth/emailverification.dart';
import 'package:gonana/features/presentation/page/crypto_pay/crypto_pay.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../consts.dart';
import '../../controllers/fiat_wallet/transaction_controller.dart';
import '../../controllers/swap/swap_controller.dart';
import '../../controllers/user/user_controller.dart';
import '../page/home.dart';
import '../page/market/product_checkout.dart';
import '../page/swap/swap_page.dart';
import '../page/verification/verification.dart';
import 'CheckoutButton.dart';
import 'DeliveryCard.dart';
import 'PaymentCard.dart';

tokenBottomSheet1(BuildContext context) {
  List<String> tokenNames = [
    'BTC 0',
    'Gona',
    'CCDT 0',
    'USDT 0',
    'BNB 0',
    'MATIC 0'
  ];
  List<String> tokenLogo = [
    'btc_logo',
    'gona_logo',
    'ccd_logo',
    'usdt_logo',
    'bnb_logo',
    'matic_logo'
  ];
  List<String> tokenValue = ['0', '500,000', '', '0', '0', '0'];
  SwapController swapController = Get.put(SwapController());
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close)),
                      ],
                    ),
                  ),
                  const Text(
                    'Select a token',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                      'Complete your verification and unlock amazing features on gonana.'),
                  // const EnterText(label: '', hint: 'Search a token name'),
                  SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: tokenNames.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () async {
                                swapController.updateTokensFrom(
                                    tokenNames[index], tokenLogo[index]);
                                Get.back();
                              },
                              child: Container(
                                color: Color(0xffFFFFFF),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: SvgPicture.asset(
                                                "assets/svgs/${tokenLogo[index]}.svg")),
                                        Text(
                                          '${tokenNames[index]}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${tokenValue[index]}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Icon(Icons.arrow_forward_ios)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ));
      });
}

tokenBottomSheet2(BuildContext context) {
  List<String> tokenNames = [
    'BTC 0',
    'Gona',
    'CCDT 0',
    'USDT 0',
    'BNB 0',
    'MATIC 0'
  ];
  List<String> tokenLogo = [
    'btc_logo',
    'gona_logo',
    'ccd_logo',
    'usdt_logo',
    'bnb_logo',
    'matic_logo'
  ];
  List<String> tokenValue = ['0', '500,000', '', '0', '0', '0'];
  SwapController swapController = Get.put(SwapController());
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close)),
                      ],
                    ),
                  ),
                  const Text(
                    'Select a token',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                      'Complete your verification and unlock amazing features on gonana.'),
                  // const EnterText(label: '', hint: 'Search a token name'),
                  SizedBox(height: 10),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: tokenNames.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () async {
                                  swapController.updateTokensTo(
                                      tokenNames[index], tokenLogo[index]);
                                  Get.back();
                                },
                                child: Container(
                                  color: Color(0xffFFFFFF),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: SvgPicture.asset(
                                                  "assets/svgs/${tokenLogo[index]}.svg")),
                                          Text(
                                            '${tokenNames[index]}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${tokenValue[index]}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Icon(Icons.arrow_forward_ios)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ))
                ],
              ),
            ));
      });
}

checkout(BuildContext context, var courier) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      String selectedRadioValue = '';
      UserController userController = Get.put(UserController());
      TransactionController transactionController =
          Get.put(TransactionController());
      final cartController = Get.find<CartController>();
      var totalPrice =
          "${cartController.succesfullTransactionModel!.totalShippingCost != null ? (double.parse(cartController.succesfullTransactionModel!.totalShippingCost.toString()) + cartController.succesfullTransactionModel!.productCost!) : cartController.succesfullTransactionModel!.productCost!}";

      var totalPriceInDollar =
          "${cartController.succesfullTransactionModel!.total_shipping_cost_in_usd != null ? (double.parse(cartController.succesfullTransactionModel!.total_shipping_cost_in_usd.toString()) + double.parse(cartController.succesfullTransactionModel!.product_cost_in_usd!)) : cartController.succesfullTransactionModel!.product_cost_in_usd!}";

      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.55,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: greyColor,
                        size: 29,
                      ),
                      onPressed: () {
                        Future.delayed(Duration.zero, () {
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                  // sizeVer(15.0),
                  // Center(
                  //   child: Text(
                  //     "NGN ${cartController.totalPrice}",
                  //     style: GoogleFonts.montserrat(
                  //         fontSize: 24,
                  //         color: greenColor,
                  //         fontWeight: FontWeight.w600),
                  //   ),
                  // ),
                  cartController.succesfullTransactionModel != null
                      ? Center(
                          child: Text(
                            "NGN ${cartController.succesfullTransactionModel!.totalShippingCost != null ? (double.parse(cartController.succesfullTransactionModel!.totalShippingCost.toString()) + cartController.succesfullTransactionModel!.productCost!) : cartController.succesfullTransactionModel!.productCost!}",
                            style: GoogleFonts.montserrat(
                                fontSize: 24,
                                color: greenColor,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      : Text(""),
                  sizeVer(15),
                  myDivider(),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: primaryColor),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment Type",
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: darkColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          sizeVer(10),
                          ListTile(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            contentPadding:
                                EdgeInsets.only(left: 0.0, right: 0.0),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pay with crypto",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: darkColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                sizeVer(10),
                                Row(
                                  children: [
                                    // Image.asset(
                                    //   "assets/images/image 7.png",
                                    //   width: 32,
                                    //   height: 20,
                                    // ),
                                    // sizeHor(10),
                                    Text(
                                      "Crypto balance: ${userController.userModel.value.walletBalance ?? 20}",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        color: darkColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            trailing: Icon(
                              Icons.chevron_right_outlined,
                              color: greyColor,
                            ),
                            leading: Radio(
                              activeColor: Color(0xff29844B),
                              value: 'Option 1',
                              groupValue: selectedRadioValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedRadioValue = value.toString();
                                });
                              },
                            ),
                          ),
                          sizeVer(15),
                          ListTile(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            contentPadding:
                                EdgeInsets.only(left: 0.0, right: 0.0),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pay with Gonnana Wallet",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: darkColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                sizeVer(8),
                                Text(
                                  "Available balance: NGN ${transactionController.balanceModel.value.balance ?? 0}",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    color: darkColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                // Text(
                                //   "Estimation: NGN 500,000",
                                //   style: GoogleFonts.montserrat(
                                //     fontSize: 10,
                                //     color: darkColor,
                                //     fontWeight: FontWeight.w400,
                                //   ),
                                // ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.chevron_right_outlined,
                              color: greyColor,
                            ),
                            leading: Radio(
                              activeColor: Color(0xff29844B),
                              value: 'Option 2',
                              groupValue: selectedRadioValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedRadioValue = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  myDivider(),
                  sizeVer(15),
                  GestureDetector(
                      onTap: () {
                        if (selectedRadioValue == "Option 1") {
                          Get.to(() => CryptoPay(), arguments: {
                            "courier": courier,
                            "productPrice": totalPrice,
                            "totalPriceInDollar": totalPriceInDollar
                          });
                        }

                        if (selectedRadioValue == "Option 2") {
                          Get.to(() => const PayWithWalletPasscode(),
                              arguments: {"courier": courier});
                        }

                        if (selectedRadioValue.isEmpty) {
                          ErrorSnackbar.show(
                              context, "Select a means of payment");
                        }
                      },
                      child: const CheckoutButton()),
                  sizeVer(15)
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}

cryptoPayBottomSheet(BuildContext context) {
  TransactionController transactionController =
      Get.put(TransactionController());
  List<String> tokenNames = [
    'ETH ',
    // 'BTC 0',
    // 'Gona',
    // 'CCDT 0',
    // 'USDT 0',
    // 'BNB 0',
    // 'MATIC 0'
  ];
  List<String> tokenLogo = [
    'eth',
    // 'btc_logo',
    // 'gona_logo',
    // 'ccd_logo',
    // 'usdt_logo',
    // 'bnb_logo',
    // 'matic_logo'
  ];
  var stringValue =
      transactionController.cryptoBalanceModel.cryptoWalletBalanceInEth;
  var doubleValue = double.tryParse(stringValue!);
  var tokenValueInDec;
  if (doubleValue != null) {
    tokenValueInDec = doubleValue.toStringAsFixed(5);
    // Rest of your code...
  } else {
    // Handle the case where the conversion to double fails
    print('Invalid numeric value');
  }
  List<String> tokenValue = [
    'ETH ${tokenValueInDec ?? 0}',
    // '0', '500,000', '', '0', '0', '0'
  ];
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        CryptoPayController cryptoPayController =
            Get.put(CryptoPayController());
        return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close)),
                      ],
                    ),
                  ),
                  const Text(
                    'Payment Option',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const Text('Select a payment option.'),
                  // const EnterText(label: '', hint: 'Search a token name'),
                  SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: tokenNames.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () async {
                                cryptoPayController.updateTokens(
                                    tokenNames[index], tokenLogo[index]);
                                Get.back();
                              },
                              child: Container(
                                color: Color(0xffFFFFFF),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                            padding: tokenLogo[index]
                                                    .contains("ethereum_logo")
                                                ? const EdgeInsets.only(
                                                    top: 15.0, left: 10)
                                                : const EdgeInsets.only(
                                                    top: 15.0),
                                            child: Container(
                                                width: tokenLogo[index]
                                                        .contains("eth")
                                                    ? 30
                                                    : 60,
                                                height: tokenLogo[index]
                                                        .contains("eth")
                                                    ? 60
                                                    : 60,
                                                child: SvgPicture.asset(
                                                    "assets/svgs/${tokenLogo[index]}.svg"))),
                                        tokenLogo[index].contains("eth")
                                            ? Text(
                                                '   ${tokenNames[index]}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            : Text(
                                                '${tokenNames[index]}',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${tokenValue[index]}',
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Icon(Icons.arrow_forward_ios)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ));
      });
}

class completeVerificationBottomSheet extends StatelessWidget {
  const completeVerificationBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> verifications = [
      "BVN",
      " National ID(e.g NIN or VIN Number)",
      " Drivers license",
      " Add credit card",
      " Add your address",
      " Your personal logistics company(For farmers)",
      " Add bank account",
    ];
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.62,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Your almost done!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w600,
                        height: 0.58,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Complete your verification and unlock  amazing\nfeatures on gonana.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w400,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(height: 2, thickness: 2),
                    SizedBox(height: 10),
                    Container(
                      width: 334,
                      height: 280,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Complete these to enjoy Gonana',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w600,
                              height: 0.78,
                            ),
                          ),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: verifications.map((str) {
                              return Row(children: [
                                const Text(
                                  "\u2022",
                                  style: TextStyle(fontSize: 30),
                                ), //bullet text//space between bullet and text
                                Expanded(
                                  child: Text(
                                    str,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Proxima Nova',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ]);
                            }).toList(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              LongGradientButton(
                  title: "Proceed",
                  onPressed: () {
                    Get.to(() => UserVerificationPage());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
