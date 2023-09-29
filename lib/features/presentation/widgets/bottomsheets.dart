import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/controllers/cart/cart_controller.dart';
import 'package:gonana/features/presentation/page/auth/emailverification.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../consts.dart';
import '../../controllers/swap/swap_controller.dart';
import '../page/home.dart';
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

final cartController = Get.find<CartController>();
checkout(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.85,
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
                sizeVer(15.0),
                Center(
                  child: Text(
                    "NGN ${cartController.totalPrice}",
                    style: GoogleFonts.montserrat(
                        fontSize: 24,
                        color: greenColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                sizeVer(15),
                myDivider(),
                sizeVer(15),
                sizeVer(15),
                const DeliveryCard(),
                sizeVer(15),
                myDivider(),
                const PaymentCard(),
                sizeVer(15),
                myDivider(),
                sizeVer(15),
                const CheckoutButton(),
                sizeVer(15)
              ],
            ),
          ),
        ),
      );
    },
  );
}

cryptoPayBottomSheet(BuildContext context) {
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
