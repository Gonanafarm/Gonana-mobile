import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/savings/passcode.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../controllers/savings/savings_controller.dart';

class ConfirmDetails extends StatefulWidget {
  const ConfirmDetails({super.key});

  @override
  State<ConfirmDetails> createState() => _ConfirmDetailsState();
}

class _ConfirmDetailsState extends State<ConfirmDetails> {
  bool value = false;
  SavingsController savingsController = Get.put(SavingsController());
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int dayOfMonth = now.day;
    DateTime noOfMonthsFromNow = DateTime(
        now.year, now.month + savingsController.duration.value, now.day);
    String monthName = getMonthName(noOfMonthsFromNow.month);
    return Scaffold(
        backgroundColor: const Color(0xffF1F1F1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back, color: Colors.black)),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      // height: 32,
                      width: 342,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Confirm Details',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                  'Confirm the details for the transaction'),
                            )
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Container(
                        // height: 166,
                        // width: 342,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xffFFFFFF)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Obx(
                                () => Text(
                                    'Your saving ${savingsController.savingsAmount.value} at ${savingsController.interestRate.value}% \n for ${savingsController.duration.value}months yields '),
                              ),
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
                                const Divider(),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Estimted Yields'),
                                      Text(
                                          '${savingsController.savingsAmount.value + (savingsController.interestRate.value / 100)}  ${savingsController.tokenName.value}')
                                    ]),
                                const Divider(),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Release Date'),
                                      Text('$monthName $dayOfMonth, 2023')
                                    ])
                              ]))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                    // height: 68,
                    width: 307,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffFF2323))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                          'Note: withdrawal before end of duration would attract 3% fee.\n keys for withdrawal would be made available on the release date.'),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20),
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
                                    text: TextSpan(
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
                      LongGradientButton(
                        title: 'Save now',
                        onPressed: () {
                          savingsController.addTokens();
                          savingsController.addSavingsAmount();
                          Get.to(() => SavingsPasscode());
                        }
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

String getMonthName(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return '';
  }
}
