import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/savings/savings_splash.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../controllers/savings/savings_controller.dart';

class SavingsWithdrawal extends StatefulWidget {
  const SavingsWithdrawal({super.key});

  @override
  State<SavingsWithdrawal> createState() => _SavingsWithdrawalState();
}

class _SavingsWithdrawalState extends State<SavingsWithdrawal> {
  bool value = false;
  SavingsController savingsController = Get.put(SavingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  // height: 32,
                  width: 342,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Withdrawal',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600)),
                        Text('Confirm the details for the transaction'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Container(
                            height: 198,
                            width: 342,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xffFFFFFF)),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Obx(
                                    () => Text(
                                        'Your saving ${savingsController.savingsAmount.value} at ${savingsController.interestRate.value}% \n for 12months yields '),
                                  ),
                                  SizedBox(height: 15),
                                  SizedBox(
                                      child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Daily yields'),
                                        Obx(() => Text(
                                            '23 ${savingsController.tokenName.value}'))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Total Estimted Yields'),
                                          Obx(() => Text(
                                              '${savingsController.savingsAmount.value + (savingsController.interestRate.value / 100)} ${savingsController.tokenName.value}'))
                                        ]),
                                    Divider(),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Release Date'),
                                          Text('Aug 2, 2023')
                                        ]),
                                    Divider(),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('After 3% penalty'),
                                          Obx(() => Text(
                                              '${(savingsController.savingsAmount.value + (savingsController.interestRate.value / 100)) - (3 / 100)}'))
                                        ])
                                  ]))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                      // height: 75,
                      // width: 307,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffFF2323))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Note: withdrawal before end of duration would attract 3% fee. keys for withdrawal would be made available on the release date.'),
                      )),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        // height: 48,
                        // width: 309,
                        decoration: BoxDecoration(
                            color: const Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: LongGradientButton(
                          title: 'Confirm',
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
                                      content: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30.0),
                                        child: Text('Withdrawal succesful'),
                                      ),
                                      actions: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30.0),
                                          child: DialogGradientButton(
                                            title: 'Proceed',
                                            onPressed: () {
                                              Get.to(
                                                  () => SavingsSplashScreen());
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
              ]),
        ),
      ),
    );
  }
}
