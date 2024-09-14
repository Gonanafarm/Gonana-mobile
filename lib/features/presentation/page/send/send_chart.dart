import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/page/home.dart';
import 'package:gonana/features/presentation/page/send/send_page.dart';
import 'package:gonana/features/presentation/page/send/send_receive.dart';
import 'package:gonana/features/presentation/page/wallet/wallet_page.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import 'package:intl/intl.dart';

import '../../../controllers/fiat_wallet/transaction_controller.dart';

class SendChart extends StatefulWidget {
  Coin coin;
  SendChart({super.key, required this.coin});

  @override
  State<SendChart> createState() => _SendChartState();
}

class _SendChartState extends State<SendChart> {
  TransactionController transactionController =
      Get.put(TransactionController());

  static String formatAmount(dynamic amount) {
    final value = NumberFormat('#,##0.0000', 'en_US');
    if (amount is! num) {
      final format = double.tryParse(amount);
      if (format == null) return '0.00';
      return value.format(format);
    }
    // final format = amount as double?;
    // if (format == null) return '0.00';
    return value.format(amount);
  }

  void initState() {
    super.initState();
    getDollarValue();
  }

  double converted = 0.0;
  getDollarValue() async {
    converted = await transactionController.tokenToDolls(
        "1", widget.coin == Coin.ETH ? Coin.ETH : Coin.CCD);
    if (converted != 0.0) {
      setState(() {
        converted = converted;
      });
    }
    return converted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF1F1F1),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: double.infinity,
                    // height: MediaQuery.of(context).size.height * 0.3,
                    height: 300,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Color(0xff29844B), Color(0xff003633)])),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Column(
                        children: [
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          widget.coin == Coin.ETH
                              ? Text(
                                  'ETH ${formatAmount(transactionController.ethBalanceModel.cryptoWalletBalanceInEth ?? 0)}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w600))
                              : Text(
                                  'CCD ${formatAmount(transactionController.ccdBalanceModel.cryptoWalletBalanceInCcd ?? 0)}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w600)),

                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, right: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    spacing:
                                        10.0, // Space between items horizontally
                                    runSpacing:
                                        10.0, // Space between items vertically when wrapped
                                    alignment: WrapAlignment.spaceBetween,
                                    children: [
                                      ShortWhiteButton(
                                          title: 'Transfer',
                                          onPressed: () {
                                            Get.to(() => SendPage(
                                                  coin: widget.coin == Coin.ETH
                                                      ? Coin.ETH
                                                      : Coin.CCD,
                                                  withdraw: false,
                                                ));
                                          }),
                                      widget.coin == Coin.CCD
                                          ? ShortWhiteButton(
                                              title: 'Withdraw',
                                              onPressed: () {
                                                Get.to(() => SendPage(
                                                      coin: widget.coin ==
                                                              Coin.ETH
                                                          ? Coin.ETH
                                                          : Coin.CCD,
                                                      withdraw: true,
                                                    ));
                                              })
                                          : Container(),
                                      // ShortWhiteButton(
                                      //     title: 'Stake',
                                      //     onPressed: () {
                                      //       SuccessSnackbar.show(context,
                                      //           "Not available now. Coming soon...");
                                      //     }),
                                      ShortWhiteButton(
                                          title: 'Receive',
                                          onPressed: () {
                                            Get.to(() => SendReceiveQR(
                                                  coin: widget.coin == Coin.ETH
                                                      ? Coin.ETH
                                                      : Coin.CCD,
                                                ));
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width * 0.8,
                          //   height: MediaQuery.of(context).size.height * 0.3,
                          //   child: LineChart(LineChartData(
                          //       lineBarsData: [
                          //         LineChartBarData(
                          //             spots: const [
                          //               FlSpot(0, 2),
                          //               FlSpot(2.5, 2.1),
                          //               FlSpot(4.9, 2.3),
                          //               FlSpot(6.8, 2.5),
                          //               FlSpot(8, 3),
                          //               FlSpot(9.5, 3),
                          //               FlSpot(10, 3.5),
                          //             ],
                          //             isCurved: true,
                          //             dotData: const FlDotData(show: false),
                          //             color: Colors.white,
                          //             barWidth: 2,
                          //             belowBarData: BarAreaData(
                          //                 show: true,
                          //                 color: Colors.white.withOpacity(0.3)))
                          //       ],
                          //       minX: 0,
                          //       maxX: 10,
                          //       minY: 2,
                          //       maxY: 5,
                          //       titlesData: FlTitlesData(
                          //           show: true,
                          //           bottomTitles: AxisTitles(
                          //               axisNameWidget: const Text("Date Axis"),
                          //               sideTitles: SideTitles(
                          //                 showTitles: false,
                          //               ))))),
                          // ),
                        ],
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.04),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Staking",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                SuccessSnackbar.show(context,
                                    "Not available now. Coming soon...");
                              },
                              child: Container(
                                // height: 70,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xff29844B),
                                          Color(0xff003633)
                                        ])),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.show_chart,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                widget.coin == Coin.ETH
                                                    ? const Text(
                                                        "Start earning  ETH",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : const Text(
                                                        "Start earning  CCD",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                const Text(
                                                  "Stake tokens and earn rewards",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            sizeVer(30),
                            const Text(
                              "Price Details",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Container(
                              // height: 70,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color(0xff29844B),
                                        Color(0xff003633)
                                      ])),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.01),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Container(
                                          //   decoration: const BoxDecoration(
                                          //       shape: BoxShape.circle,
                                          //       color: Colors.white),
                                          //   child: const Padding(
                                          //     padding: EdgeInsets.all(8.0),
                                          //     child: Icon(
                                          //       Icons.show_chart,
                                          //       color: Colors.green,
                                          //     ),
                                          //   ),
                                          // ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.025,
                                                ),
                                                child: widget.coin == Coin.ETH
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SvgPicture.asset(
                                                            height: 55,
                                                            width: 30,
                                                            "assets/svgs/eth.svg"),
                                                      )
                                                    : SvgPicture.asset(
                                                        "assets/svgs/ccd.svg"),
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01),
                                              child: widget.coin == Coin.ETH
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 9.0),
                                                      child: Text(
                                                        "Etherium",
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.045,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )
                                                  : Text(
                                                      "Concordium",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.045,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white),
                                                    ),
                                            ),
                                          ),
                                          sizeHor(MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.18),
                                          Text(
                                            "24h Price",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        height: 5,
                                        color: Colors.grey,
                                      ),
                                      sizeVer(10),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              "\$${formatAmount(converted)}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                            // Text(
                                            //   "+\$${15.2}",
                                            //   style: TextStyle(
                                            //       fontSize: 15,
                                            //       fontWeight: FontWeight.w600,
                                            //       color: Colors.green),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            // Row(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       SvgPicture.asset(
                            //           height: 50,
                            //           width: 30,
                            //           'assets/svgs/ccd.svg'),
                            //       sizeHor(20),
                            //       Expanded(
                            //         child: Column(children: [
                            //           Text(
                            //               'CCD ${transactionController.cryptoBalanceModel.cryptoWalletBalanceInEth ?? 0}',
                            //               style: const TextStyle(
                            //                   fontSize: 24,
                            //                   fontWeight: FontWeight.w600)),
                            //         ]),
                            //       )
                            //     ]),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 6.0),
                            //   child: ListTile(
                            //       leading:
                            //           SvgPicture.asset('assets/svgs/Arrow.svg'),
                            //       title: const Text(
                            //         'Gona Bought',
                            //         style: TextStyle(
                            //           color: greenColor,
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //       ),
                            //       subtitle: const Text(
                            //         '500,000 GNX bought with NGN 500,000',
                            //         style: TextStyle(
                            //           fontSize: 10,
                            //           fontWeight: FontWeight.w400,
                            //         ),
                            //       ),
                            //       trailing: const Text('Jan 25')),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 6.0),
                            //   child: ListTile(
                            //       leading:
                            //           SvgPicture.asset('assets/svgs/Arrow2.svg'),
                            //       title: const Text(
                            //         'Gona Sold',
                            //         style: TextStyle(
                            //           color: redColor,
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.w600,
                            //         ),
                            //       ),
                            //       subtitle: const Text(
                            //         '100,000 GNX worth NGN 100,000',
                            //         style: TextStyle(
                            //           fontSize: 10,
                            //           fontWeight: FontWeight.w400,
                            //         ),
                            //       ),
                            //       trailing: const Text('Jan 25')),
                            // ),
                          ]),
                    )),
              ],
            ),
          ),
        ));
  }
}
