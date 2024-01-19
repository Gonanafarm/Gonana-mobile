import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/page/send/send_page.dart';
import 'package:gonana/features/presentation/page/send/send_receive.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../controllers/fiat_wallet/transaction_controller.dart';

class SendChart extends StatefulWidget {
  const SendChart({super.key});

  @override
  State<SendChart> createState() => _SendChartState();
}

class _SendChartState extends State<SendChart> {
  TransactionController transactionController =
      Get.put(TransactionController());
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
                    height: MediaQuery.of(context).size.height * 0.45,
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: LineChart(LineChartData(
                                lineBarsData: [
                                  LineChartBarData(
                                      spots: const [
                                        FlSpot(0, 2),
                                        FlSpot(2.5, 2.1),
                                        FlSpot(4.9, 2.3),
                                        FlSpot(6.8, 2.5),
                                        FlSpot(8, 3),
                                        FlSpot(9.5, 3),
                                        FlSpot(10, 3.5),
                                      ],
                                      isCurved: true,
                                      dotData: const FlDotData(show: false),
                                      color: Colors.white,
                                      barWidth: 2,
                                      belowBarData: BarAreaData(
                                          show: true,
                                          color: Colors.white.withOpacity(0.3)))
                                ],
                                minX: 0,
                                maxX: 10,
                                minY: 2,
                                maxY: 5,
                                titlesData: FlTitlesData(
                                    show: true,
                                    bottomTitles: AxisTitles(
                                        axisNameWidget: const Text("Date Axis"),
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ))))),
                          ),
                        ],
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                    height: 50,
                                    width: 30,
                                    'assets/images/ethereum_logo.png'),
                                sizeHor(20),
                                Column(children: [
                                  Text(
                                      'ETH ${transactionController.cryptoBalanceModel.cryptoWalletBalanceInEth ?? 0}',
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600)),
                                ])
                              ]),
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
                          Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ShortGradientButton(
                                        title: 'Send',
                                        onPressed: () {
                                          Get.to(() => const SendPage());
                                        }),
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => const SendReceiveQR());
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          side: const BorderSide(
                                            color: greenColor,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          minimumSize: const Size(125, 60),
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent),
                                      child: const Row(
                                        children: [
                                          Text(
                                            "Recieve",
                                            style: TextStyle(color: greenColor),
                                          ),
                                          SizedBox(width: 10.0),
                                          Icon(
                                            Icons.arrow_back,
                                            color: greenColor,
                                          ),
                                        ],
                                      ),
                                    )
                                  ]))
                        ])),
              ],
            ),
          ),
        ));
  }
}
