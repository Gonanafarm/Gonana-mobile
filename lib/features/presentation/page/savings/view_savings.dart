import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/home.dart';
import 'package:gonana/features/presentation/page/savings/savings_details.dart';
import 'package:gonana/features/presentation/page/savings/savings_duration.dart';
import 'package:gonana/features/presentation/page/savings/savings_splash.dart';
import 'package:gonana/features/presentation/page/wallet/wallet_page.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../controllers/savings/savings_controller.dart';

class ViewSavings extends StatefulWidget {
  const ViewSavings({super.key});

  @override
  State<ViewSavings> createState() => _ViewSavingsState();
}

class _ViewSavingsState extends State<ViewSavings> {
  SavingsController savingsController = Get.put(SavingsController());

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int dayOfMonth = now.day;
    int currentMonth = now.month;
    DateTime noOfMonthsFromNow = DateTime(
        now.year, now.month + savingsController.duration.value, now.day);
    String monthName = getMonthName(noOfMonthsFromNow.month);
    String year = currentMonth + savingsController.duration.value > 10
        ? "${now.year + 1}"
        : "${now.year}";
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
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Your save assets',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600)),
                        const Text(
                            'These are your saved assets, you can also add'),
                        const SizedBox(
                          height: 12,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => SavingsPage());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'New Saving',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.to(() => SavingsPage());
                                    },
                                    icon: const Icon(Icons.add)),
                              ],
                            ),
                          ),
                        ),
                        Obx(
                          () => Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: Scrollbar(
                              child: ListView.builder(
                                  // reverse: true,
                                  itemCount: savingsController
                                      .savingsAmountList.value.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final reversedIndex = savingsController
                                            .savingsAmountList.value.length -
                                        1 -
                                        index;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(() => SavingsDetails());
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xffFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0),
                                                      child: Container(
                                                        height: 50,
                                                        width: 45,
                                                        child: Obx(
                                                          () => SvgPicture.asset(
                                                              "assets/svgs/${savingsController.tokenLogosList[reversedIndex]}.svg"),
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Obx(
                                                          () => Text(
                                                              '${savingsController.savingsAmountList[reversedIndex]} ${savingsController.tokenNamesList[index]}',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ),
                                                        Obx(
                                                          () => Text(
                                                            'At ${savingsController.interestRate.value}% interest',
                                                          ),
                                                        ),
                                                        Text(
                                                            'Due for $monthName $dayOfMonth, $year',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                    // height: 100,
                                                    child: Container(
                                                  child: Icon(
                                                      Icons.arrow_forward_ios),
                                                )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              const Spacer(),
              LongGradientButton(
                  title: "Save now",
                  onPressed: () {
                    Get.to(() => HomePage(navIndex: 1));
                  })
            ],
          ),
        ),
      ),
    );
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
