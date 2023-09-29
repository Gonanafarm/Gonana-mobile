import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/staking/staking_earnings.dart';

import '../../widgets/widgets.dart';

class StakingSplashScreen extends StatelessWidget {
  const StakingSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff29844B), Color(0xff003633)]),
      ),
      child: Stack(
        // alignment: AlignmentDirectional.bottomCenter,
        children: [
          SvgPicture.asset(
              // height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              "assets/svgs/splaash5.svg"),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20,
              top: MediaQuery.of(context).size.height * 0.55,
            ),
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Introducing',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffFFFFFF)),
                        ),
                        Text(
                          'Earn with Gonana',
                          style: TextStyle(
                              fontSize: 45.08,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffFFFFFF)),
                        ),
                        Text(
                          'You can stake/Lock you crypto For a duration of time and get good interests.',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffFFFFFF)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: Center(
                        child: LongTransparentButton(
                          title: 'Get started',
                          onPressed: () {
                            Get.to(() => StakingEarnings());
                          },
                        ),
                      ),
                    )
                  ]),
            ),
          )
        ],
      ),
    ));
  }
}
