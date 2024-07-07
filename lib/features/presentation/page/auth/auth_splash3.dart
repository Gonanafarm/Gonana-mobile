import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import 'auth_splash4.dart';

class Splash3 extends StatelessWidget {
  const Splash3({super.key});

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
              width: MediaQuery.of(context).size.width,
              "assets/svgs/splash3.svg"),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20,
              top: MediaQuery.of(context).size.height * 0.55,
            ),
            child: SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Offering DeFi\n solutions.',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.09,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffFFFFFF)),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: Center(
                        child: LongTransparentButton(
                          title: 'Next',
                          onPressed: () {
                            Get.to(() => const Splash4());
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
