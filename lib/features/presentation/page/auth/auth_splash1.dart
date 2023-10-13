import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';
import 'auth_spash2.dart';

class Splash1 extends StatelessWidget {
  const Splash1({super.key});

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
              colors: [Color(0xff29844B), Color(0xff003633)])),
      child: Stack(
        children: [
          SvgPicture.asset(
              width: MediaQuery.of(context).size.width,
              'assets/svgs/splash1.svg'),
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
                  Center(child: Image.asset('assets/images/whit1.png')),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Center(
                      child: LongTransparentButton(
                        title: 'Get started',
                        onPressed: () {
                          Get.to(() => const Splash2());
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
