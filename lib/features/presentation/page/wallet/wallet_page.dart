import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/page/wallet/wallet_deposit.dart';
import 'package:gonana/features/presentation/page/wallet/wallet_withdrawal.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/fiat_wallet/transaction_controller.dart';
import '../../../controllers/user/user_controller.dart';
import '../../widgets/warning_widget.dart';
import '../fiat_wallet/wallet_home.dart';
import '../savings/savings_splash.dart';
import '../send/send_chart.dart';
import '../staking/staking_splash.dart';
import '../swap/swap_page.dart';

enum Coin { CCD, ETH }

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  UserController userController = Get.put(UserController());
  TransactionController transactionController =
      Get.put(TransactionController());

  bool? BVNisSubmited = false;
  getBVNStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BVNisSubmited = prefs.getBool('bvnSubmission');
  }

  double totalAmountNgn = 0.0;
  getBalance() async {
    await transactionController.fetchBalance();
    // Get the raw string values
    String? cryptoBalanceStr =
        "${(double.tryParse(transactionController.ccdBalanceModel.cryptoWalletBalanceInNgn ?? '0') ?? 0) + (double.tryParse(transactionController.ethBalanceModel.cryptoWalletBalanceInNgn ?? '0') ?? 0)}";
    String? nairaBalanceStr = transactionController.balanceModel.value.balance;

// Print raw values for debugging
    print('Crypto Balance String: $cryptoBalanceStr');
    print('Naira Balance String: $nairaBalanceStr');

// Trim and attempt to parse the first string to an integer, defaulting to 0 if parsing fails
    double cryptoAmount =
        double.tryParse(cryptoBalanceStr?.trim() ?? '0.0') ?? 0.0;

// Trim and attempt to parse the second string to an integer, defaulting to 0 if parsing fails
    double nairaAmount =
        double.tryParse(nairaBalanceStr?.trim() ?? '0.0') ?? 0.0;

// Add the parsed integer values together
    double calculatedAmount = (cryptoAmount + nairaAmount);

    setState(() {
      totalAmountNgn = calculatedAmount;
    });

// Print the total amount in Naira
    print('Total Amount in NGN: $totalAmountNgn');

    print("This: $totalAmountNgn");
    await transactionController.fetchCryptoBalance();
    await transactionController.fetchTransactions();
  }

  @override
  void initState() {
    super.initState();
    getBalance();
    getBVNStatus();
  }

  List icons = ["ccd", "eth", "gona_logo"];
  List text = ["CCD", "ETH", "Gonana wallet"];
  List<Widget> nextPage = [
    SendChart(coin: Coin.CCD),
    SendChart(coin: Coin.ETH),
    const FiatWalletHome()
  ];

  double roundToDecimalPlaces(double value, int decimalPlaces) {
    double multiplier = pow(10, decimalPlaces).toDouble();
    return (value * multiplier).round() / multiplier;
  }

  static String formatAmount(dynamic amount) {
    final value = NumberFormat('#,##0.0000', 'en_US');

    // Handle null values early
    if (amount == null) {
      return '0.00';
    }

    // Try parsing the amount if it's not a num
    if (amount is! num) {
      final format = double.tryParse(amount.toString());
      if (format == null) return '0.00';
      return value.format(format);
    }

    // If it's already a number, format it directly
    return value.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    List amountInNaira = [
      "NGN ${formatAmount(transactionController.ccdBalanceModel.cryptoWalletBalanceInNgn) ?? 0}",
      "NGN ${formatAmount(transactionController.ethBalanceModel.cryptoWalletBalanceInNgn) ?? 0}",
      "NGN ${formatAmount(transactionController.balanceModel.value.balance) ?? 0}"
    ];
    List amountInCrypto = [
      "CCD ${formatAmount(transactionController.ccdBalanceModel.cryptoWalletBalanceInCcd ?? 0)}",
      "ETH ${formatAmount(transactionController.ethBalanceModel.cryptoWalletBalanceInEth ?? 0)}",
      ""
    ];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xffF1F1F1),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              width: double.infinity,
              height: size.height * 0.3,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xff29844B), Color(0xff003633)])),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: size.height * 0.06, bottom: 10),
                      child: const Text('Total balance',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text('NGN ${formatAmount(totalAmountNgn)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600)),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                    //   child: Center(
                    //     child: SizedBox(
                    //       width: 180,
                    //       child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             GestureDetector(
                    //               onTap: () {
                    //                 Get.to(() => WalletWithdrawal());
                    //               },
                    //               child: SizedBox(
                    //                 height: 50,
                    //                 child: Column(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceEvenly,
                    //                   children: [
                    //                     SvgPicture.asset(
                    //                       'assets/svgs/money1.svg',
                    //                       colorFilter: const ColorFilter.mode(
                    //                           Colors.white, BlendMode.srcIn),
                    //                     ),
                    //                     const Text(
                    //                       'Withdraw',
                    //                       style: TextStyle(
                    //                           color: primaryColor,
                    //                           fontSize: 12,
                    //                           fontWeight: FontWeight.w400),
                    //                     )
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //             GestureDetector(
                    //               onTap: () {
                    //                 Get.to(() => WalletDeposit());
                    //               },
                    //               child: SizedBox(
                    //                 height: 50,
                    //                 child: Column(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceEvenly,
                    //                   children: [
                    //                     SvgPicture.asset(
                    //                       'assets/svgs/money1.svg',
                    //                       colorFilter: const ColorFilter.mode(
                    //                           Colors.white, BlendMode.srcIn),
                    //                     ),
                    //                     const Text(
                    //                       'Deposit',
                    //                       style: TextStyle(
                    //                           color: primaryColor,
                    //                           fontSize: 12,
                    //                           fontWeight: FontWeight.w400),
                    //                     )
                    //                   ],
                    //                 ),
                    //               ),
                    //             )
                    //           ]),
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                    //   child: Container(
                    //       // height: 32,
                    //       width: 254,
                    //       decoration: BoxDecoration(
                    //           color: primaryColor,
                    //           borderRadius: BorderRadius.circular(5)),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(10.0),
                    //         child: Center(
                    //             child: Text(
                    //           'Portfolio Value : NGN ${userController.userModel.value.cryptoWalletBalanceInNgn ?? 0}',
                    //           textAlign: TextAlign.center,
                    //         )),
                    //       )),
                    // )
                  ])),
            ),
            Container(
              //color: Color(0xff1E1E1E),
              height: size.height * 0.68,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20),
                    // child: Container(
                    //   height: 72,
                    //   width: 342,
                    //   decoration: BoxDecoration(
                    //       color: primaryColor,
                    //       borderRadius: BorderRadius.circular(5)),
                    //   child: Row(
                    //       mainAxisAlignment:
                    //           MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         Padding(
                    //             padding: const EdgeInsets.all(8),
                    //             child: GestureDetector(
                    //                 onTap: () {
                    //                   Get.to(() =>
                    //                       const SavingsSplashScreen());
                    //                 },
                    //                 child: Column(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceEvenly,
                    //                     children: [
                    //                       SvgPicture.asset(
                    //                           'assets/svgs/savings.svg'),
                    //                       const Text('Savings',
                    //                           style: TextStyle(
                    //                               fontSize: 10,
                    //                               fontWeight:
                    //                                   FontWeight.w400))
                    //                     ]))),
                    //         Padding(
                    //             padding: const EdgeInsets.all(8),
                    //             child: GestureDetector(
                    //                 onTap: () {
                    //                   // Get.to(() => const SwapScreen());
                    //                 },
                    //                 child: Column(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceEvenly,
                    //                     children: [
                    //                       SvgPicture.asset(
                    //                           'assets/svgs/swap.svg'),
                    //                       const Text('Swap',
                    //                           style: TextStyle(
                    //                               fontSize: 10,
                    //                               fontWeight:
                    //                                   FontWeight.w400))
                    //                     ]))),
                    //         Padding(
                    //             padding: const EdgeInsets.all(8),
                    //             child: GestureDetector(
                    //                 onTap: () {},
                    //                 child: Column(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceEvenly,
                    //                     children: [
                    //                       SvgPicture.asset(
                    //                           'assets/svgs/token.svg'),
                    //                       const Text('Buy token',
                    //                           style: TextStyle(
                    //                               fontSize: 10,
                    //                               fontWeight:
                    //                                   FontWeight.w400))
                    //                     ]))),
                    //         Padding(
                    //             padding: const EdgeInsets.all(8),
                    //             child: GestureDetector(
                    //                 onTap: () {},
                    //                 child: Column(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceEvenly,
                    //                     children: [
                    //                       SvgPicture.asset(
                    //                           'assets/svgs/sell_token.svg'),
                    //                       const Text('Sell token',
                    //                           style: TextStyle(
                    //                               fontSize: 10,
                    //                               fontWeight:
                    //                                   FontWeight.w400))
                    //                     ]))),
                    //         Padding(
                    //             padding: const EdgeInsets.all(8),
                    //             child: GestureDetector(
                    //                 onTap: () {
                    //                   Get.to(() =>
                    //                       const StakingSplashScreen());
                    //                 },
                    //                 child: Column(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceEvenly,
                    //                     children: [
                    //                       SvgPicture.asset(
                    //                           'assets/svgs/stake.svg'),
                    //                       const Text('Stake',
                    //                           style: TextStyle(
                    //                               fontSize: 10,
                    //                               fontWeight:
                    //                                   FontWeight.w400))
                    //                     ]))),
                    //       ]),
                    // ),
                  ),
                  ((BVNisSubmited != null && BVNisSubmited!) ||
                              (userController.userModel != null &&
                                  userController.userModel.value
                                          .virtualAccountNumber !=
                                      null &&
                                  userController.userModel.value
                                      .virtualAccountNumber!.isNotEmpty &&
                                  userController.userModel.value.country !=
                                      null)) ||
                          (userController.userModel != null &&
                              userController.userModel.value.country != null &&
                              !userController.userModel.value.country!
                                  .contains("Nigeria"))
                      ? sizeVer(0)
                      : sizeVer(0),
                  ((BVNisSubmited != null && BVNisSubmited!) ||
                              (userController.userModel != null &&
                                  userController.userModel.value
                                          .virtualAccountNumber !=
                                      null &&
                                  userController.userModel.value
                                      .virtualAccountNumber!.isNotEmpty)) ||
                          (userController.userModel != null &&
                              userController.userModel.value.country != null &&
                              !userController.userModel.value.country!
                                  .contains("Nigeria"))
                      ? Container(height: 1)
                      : WarningWidget(),
                  ((BVNisSubmited != null && BVNisSubmited!) ||
                              (userController.userModel != null &&
                                  userController.userModel.value
                                          .virtualAccountNumber !=
                                      null &&
                                  userController.userModel.value
                                      .virtualAccountNumber!.isNotEmpty)) ||
                          (userController.userModel != null &&
                              userController.userModel.value.country != null &&
                              !userController.userModel.value.country!
                                  .contains("Nigeria"))
                      ? sizeVer(1)
                      : sizeVer(0),
                  SizedBox(
                    height: size.height * 0.68,
                    child: ListView.builder(
                        itemCount: text.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => nextPage[index]);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                  // width: 342,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: primaryColor),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SvgPicture.asset(
                                            height: 55,
                                            width: 30,
                                            'assets/svgs/${icons[index]}.svg'),
                                        const SizedBox(width: 20),
                                        !text[index].contains("Gonana wallet")
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(amountInCrypto[index],
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Text(amountInNaira[index],
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(text[index],
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Text(amountInNaira[index],
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ],
                                              ),
                                        const SizedBox(width: 20),
                                        const SizedBox(
                                          width: 60,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Text('-1.23%',
                                                //     style: TextStyle(
                                                //         color: redColor,
                                                //         fontSize: 10,
                                                //         fontWeight:
                                                //             FontWeight.w400)),
                                                Icon(Icons.arrow_forward_ios)
                                              ]),
                                        ),
                                      ])),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
