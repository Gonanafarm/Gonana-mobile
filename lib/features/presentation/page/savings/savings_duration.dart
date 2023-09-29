import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/savings/savings_amount.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../controllers/savings/savings_controller.dart';

class SavingsPage extends StatefulWidget {
  const SavingsPage({super.key});

  @override
  State<SavingsPage> createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  SavingsController savingsController = Get.put(SavingsController());
  Color containerColor = Color(0xff082D28);
  Color containerColor2 = Color(0xff082D28);
  Color containerColor3 = Color(0xff082D28);
  Color containerColor4 = Color(0xff082D28);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Duration',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                      Text('select your savings duration in months')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Percentage earned after duration'),
                      Obx(
                        () => Text('+${savingsController.interestRate.value}%',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                    height: 180,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      savingsController.updateDuration(1);
                                      savingsController.updateInterestRate(0.8);
                                      setState(() {
                                        containerColor = Color(0xff29844B);
                                        containerColor2 = Color(0xff082D28);
                                        containerColor3 = Color(0xff082D28);
                                        containerColor4 = Color(0xff082D28);
                                      });
                                    },
                                    child: Container(
                                      height: 76,
                                      width: 144,
                                      decoration: BoxDecoration(
                                          color: containerColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              '1 month \n30 days',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              '+0.8%',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            )
                                          ]),
                                    ),
                                  ),
                                  InkWell(
                                      child: Container(
                                        height: 76,
                                        width: 144,
                                        decoration: BoxDecoration(
                                            color: containerColor2,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                '3 month \n88 days',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                '+3.0%',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              )
                                            ]),
                                      ),
                                      onTap: () {
                                        savingsController.updateDuration(3);
                                        savingsController
                                            .updateInterestRate(3.0);
                                        setState(() {
                                          containerColor = Color(0xff082D28);
                                          containerColor2 = Color(0xff29844B);
                                          containerColor3 = Color(0xff082D28);
                                          containerColor4 = Color(0xff082D28);
                                        });
                                      })
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      child: Container(
                                        height: 76,
                                        width: 144,
                                        decoration: BoxDecoration(
                                            color: containerColor3,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                '6 month \n180 days',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                '+7.0%',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              )
                                            ]),
                                      ),
                                      onTap: () {
                                        savingsController.updateDuration(6);
                                        savingsController
                                            .updateInterestRate(7.0);
                                        setState(() {
                                          containerColor = Color(0xff082D28);
                                          containerColor2 = Color(0xff082D28);
                                          containerColor3 = Color(0xff29844B);
                                          containerColor4 = Color(0xff082D28);
                                        });
                                      }),
                                  InkWell(
                                      child: Container(
                                        height: 76,
                                        width: 144,
                                        decoration: BoxDecoration(
                                            color: containerColor4,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                '12 month \n364 days',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                '+15.0%',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              )
                                            ]),
                                      ),
                                      onTap: () {
                                        savingsController.updateDuration(12);
                                        savingsController
                                            .updateInterestRate(15.0);
                                        setState(() {
                                          containerColor = Color(0xff082D28);
                                          containerColor2 = Color(0xff082D28);
                                          containerColor3 = Color(0xff082D28);
                                          containerColor4 = Color(0xff29844B);
                                        });
                                      })
                                ])
                          ]),
                    )),
                const Spacer(),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Check out FAQ if you have any questions'),
                      InkWell(
                          child: const Text('Click Here',
                              style: TextStyle(color: Color(0xff29844B))),
                          onTap: () {}),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: LongGradientButton(
                          title: 'Proceed',
                          onPressed: () {
                            Get.to(() => SavingsAmountPage());
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
