import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

class BankP2P extends StatefulWidget {
  const BankP2P({super.key});

  @override
  State<BankP2P> createState() => _BankP2P();
}

class _BankP2P extends State<BankP2P> {
  List<String> str = [
    "Go to your bank app'",
    "Copy the Merchant details accurately",
    "Copy the narration above accurately",
    "The bank account must have the same name as yours else transaction would be reversed "
  ];

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
                ))),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView(children: [
              const SizedBox(
                // height: 55,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Peer-to-peer merchant',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Use the details below to perform this transaction',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              sizeVer(15),
              Container(
                  width: 342,
                  height: 475,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 166,
                              height: 34,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/svgs/user_icon.svg'),
                                    const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Hollando',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                        Text('Verified Marchant',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400))
                                      ],
                                    ),
                                    SvgPicture.asset(
                                        'assets/svgs/content_edit.svg')
                                  ])),
                          sizeVer(20),
                          SizedBox(
                            // height: 34,
                            width: 232,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Transfer Narration',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                      Text('xMhHjynyZY7uGPAUjY0M',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600))
                                    ],
                                  ),
                                  SvgPicture.asset(
                                      'assets/svgs/content_edit.svg')
                                ]),
                          ),
                          sizeVer(20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: redColor),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: str.map((textList) {
                                    return Row(children: [
                                      const Text(
                                        "\u2022",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          textList,
                                          style: const TextStyle(fontSize: 14),
                                        ), //text
                                      )
                                    ]);
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          sizeVer(20),
                          SizedBox(
                              width: 196,
                              // height: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Bank in use',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text('Union Bank',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      sizeHor(10),
                                      Image.asset(
                                          'assets/images/union-bank-icon.png')
                                    ],
                                  ),
                                  const Text('Transaction Limits',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  const Text('NGN 500 - NGN 5,000,000',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  const Text('Amount you\'re receiving',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  const Text('20,000',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                ],
                              )),
                        ]),
                  )),
              sizeVer(15),
              LongGradientButton(title: 'Done', onPressed: () {})
            ])));
  }
}
