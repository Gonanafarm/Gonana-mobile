import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/savings/savings_duration.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

class SavingsSplashScreen extends StatelessWidget {
  const SavingsSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
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
            "assets/svgs/splash3.svg"
          ),
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
                          'Gonana Savings',
                          style: TextStyle(
                              fontSize: 45.08,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffFFFFFF)),
                        ),
                        Text(
                          'Protect your crypto assets from devaluation and depreciation by saving them on the gonana app, youcan also up to 15% per annum interest while you do this.',
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
                            Get.to(() => SavingsPage());
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
