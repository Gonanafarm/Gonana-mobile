import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/staking/confirm_stake.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../widgets/bottomsheets.dart';

enum StakeOption { Gona, CCD }

class Stake extends StatefulWidget {
  const Stake({Key? key}) : super(key: key);

  @override
  State<Stake> createState() => _StakeState();
}

class _StakeState extends State<Stake> {
  StakeOption? _character = StakeOption.Gona;
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
          child: ListView(
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
                child: Container(
                  color: Color(0xffFFFFFF),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Stack(
                            // alignment: Alignment.centerRight,
                            children: [
                              SvgPicture.asset("assets/svgs/gona_logo.svg"),
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Align(
                                    child: SvgPicture.asset(
                                        "assets/svgs/ccd_logo.svg")),
                              ),
                            ],
                          )),
                      SizedBox(width: 10),
                      Text(
                        'Gona/CCD',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                title: const Text('Add Gona'),
                leading: Radio<StakeOption>(
                  activeColor: Colors.black,
                  value: StakeOption.Gona,
                  groupValue: _character,
                  onChanged: (StakeOption? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Add CCD'),
                leading: Radio<StakeOption>(
                  activeColor: Colors.black,
                  value: StakeOption.CCD,
                  groupValue: _character,
                  onChanged: (StakeOption? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
                child: Container(
                  color: Color(0xffFFFFFF),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: SvgPicture.asset(
                                  "assets/svgs/gona_logo.svg")),
                          // SizedBox(width: 10),
                          Text(
                            '1 Gona',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Text(
                        "~",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w400),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child:
                                  SvgPicture.asset("assets/svgs/ccd_logo.svg")),
                          // SizedBox(width: 10),
                          Text(
                            '5 CCD',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xff1E1E1E))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: "Amount",
                              hintStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                child: const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 2,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: SvgPicture.asset(
                                      "assets/svgs/gona_logo.svg")),
                              Text(
                                "Gona",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: IconButton(
                                  onPressed: () {
                                    // tokenBottomSheet1(context);
                                  },
                                  icon: const Icon(
                                      size: 40, Icons.arrow_drop_down),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                child: RichText(
                  text: const TextSpan(
                    text: 'Your balance : 500,000 Gona',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' MAX',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff29844B),
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Icon(Icons.swap_vert),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xff1E1E1E))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: "Amount",
                              hintStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                child: const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 2,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: SvgPicture.asset(
                                      "assets/svgs/ccd_logo.svg")),
                              Text(
                                "CCD",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: IconButton(
                                  onPressed: () {
                                    // tokenBottomSheet2(context);
                                  },
                                  icon: const Icon(
                                      size: 40, Icons.arrow_drop_down),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                child: RichText(
                  text: const TextSpan(
                    text: 'Your balance : 1,000 CCD',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' MAX',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff29844B),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: LongGradientButton(
                    title: "Stake now",
                    onPressed: () {
                      Get.to(() => ConfirmStake());
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
