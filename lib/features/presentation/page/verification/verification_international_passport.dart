import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import 'package:intl/intl.dart';

class IntPassport extends StatefulWidget {
  const IntPassport({super.key});

  @override
  State<IntPassport> createState() => _IntPassportState();
}

class _IntPassportState extends State<IntPassport> {
  DateTime? issDate;
  DateTime? expDate;
  final TextEditingController _passportNumber = TextEditingController();
  String get passportNumber => _passportNumber.text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF1F1F1),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 10.0),
              child: Column(children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'International Passport',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                      const Text(
                        'Enter These details',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.left,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: SizedBox(
                          child: EnterText(
                            controller: _passportNumber,
                            label: 'Passport Number',
                            hint: 'Enter Number here'
                          )
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: SizedBox(
                            height: 82,
                            width: 342,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Issued Date',
                                  style: TextStyle(
                                      color: Color(0xff444444),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.left,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    DateTime? selectedIssDate =
                                        await showDatePicker(
                                            context: context,
                                            initialDate:
                                                issDate ?? DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100));
                                    if (selectedIssDate == null) return;
                                    //If OK
                                    setState(() {
                                      issDate = selectedIssDate;
                                    });
                                  },
                                  child: Container(
                                      height: 60,
                                      width: 342,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: Color(0xff444444)),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: Text(
                                              issDate != null
                                                  ? DateFormat('dd/MM/yy')
                                                      .format(issDate!)
                                                  : 'select a date',
                                              style: const TextStyle(
                                                  color: Color(0xff444444),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15.0),
                                            child: SvgPicture.asset(
                                                'assets/svgs/calender.svg'),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: SizedBox(
                            height: 82,
                            width: 342,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Expiry Date',
                                  style: TextStyle(
                                      color: Color(0xff444444),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.left,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    DateTime? SelectedExpDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: expDate ?? DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                    );
                                    if (SelectedExpDate == null) return;
                                    //If OK
                                    setState(() {
                                      expDate = SelectedExpDate;
                                    });
                                  },
                                  child: Container(
                                      height: 60,
                                      width: 342,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff444444)),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: Text(
                                              expDate != null
                                                  ? DateFormat('dd/MM/yy')
                                                      .format(expDate!)
                                                  : 'select a date',
                                              style: const TextStyle(
                                                  color: Color(0xff444444),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15.0),
                                            child: SvgPicture.asset(
                                                'assets/svgs/calender.svg'),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                const Spacer(),
                LongGradientButton(
                    title: 'Confirm',
                    onPressed: () {
                      Get.back();
                    })
              ])),
        ));
  }
}
