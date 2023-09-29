import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/savings/savings_withdrawal.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../controllers/savings/savings_controller.dart';

class SavingsDetails extends StatelessWidget {
  SavingsDetails({super.key});
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
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    // height: 280,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Savings Details',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 24),
                          ),
                          SizedBox(height: 10),
                          const Text(
                              'These are the details about your savings'),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            // height: 166,
                            decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Obx(
                                    () => Text(
                                      'Your saving ${savingsController.savingsAmount.value} at ${savingsController.interestRate.value} % \n for 12months yields',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  SizedBox(
                                      child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Daily yields'),
                                        Obx(
                                          () => Text(
                                              '23 ${savingsController.tokenName.value} '),
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Total Estimted Yields'),
                                          Obx(
                                            () => Text(
                                                '${savingsController.savingsAmount.value + (savingsController.interestRate.value / 100)}   Gona'),
                                          )
                                        ]),
                                    const Divider(),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('Release Date'),
                                          Text('Aug 2, 2023')
                                        ])
                                  ]))
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                  // const Spacer(),
                  // Center(
                  //     child: LongGradientButton(
                  //         title: 'Withdraw',
                  //         onPressed: () {
                  //           Get.to(() => SavingsWithdrawal());
                  //         }))
                ],
              )),
        ));
  }
}
