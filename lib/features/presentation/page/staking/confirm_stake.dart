import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/staking/staking_earnings.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

class ConfirmStake extends StatefulWidget {
  const ConfirmStake({Key? key}) : super(key: key);

  @override
  State<ConfirmStake> createState() => _ConfirmStakeState();
}

class _ConfirmStakeState extends State<ConfirmStake> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back, color: Colors.black))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Stake',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600)),
                    Text('Enter the amount you want to addd')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Summary',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Current Pool Size',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                            Text('500,000 Gona',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('+',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('200CCD',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Divider(thickness: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Plan',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                            Text('30 days',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Yield (APY)',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                            Text('15%',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Checkbox(
                                value: this.value,
                                activeColor: Color(0xff29844B),
                                onChanged: (value) {
                                  setState(() {
                                    this.value = value!;
                                  });
                                },
                              ),
                              Flexible(
                                child: RichText(
                                  text: const TextSpan(
                                    text:
                                        'I have read and understood the terms and conditions. ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Read terms again.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff29844B),
                                          )),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: LongGradientButton(
                    title: "Confirm",
                    onPressed: () {
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
                                title: Center(
                                  child: Icon(
                                    size: 60,
                                    Icons.check_circle_outlined,
                                  ),
                                ),
                                content: Container(
                                  height: 95,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Congratulations\n',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                      Text(
                                          'you can now sit back and watch your coins work for you.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                ),
                                //
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 60.0),
                                    child: DialogGradientButton(
                                      title: 'Proceed',
                                      onPressed: () {
                                        Get.to(() => StakingEarnings());
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
