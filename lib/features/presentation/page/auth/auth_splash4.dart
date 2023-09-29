import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import 'sign_in_page.dart';
import 'sign_up_page.dart';

class Splash4 extends StatelessWidget {
  const Splash4 ({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff29844B), Color(0xff003633)]
          ),
        ),
      child: Stack(
        // alignment: AlignmentDirectional.bottomCenter,
        children: [
          SvgPicture.asset(
            width: MediaQuery.of(context).size.width,
            "assets/svgs/splash4.svg"
          ),
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Crypto as a \nmeans of \npayment.',
                        style: TextStyle(
                          fontSize: 45.08,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffFFFFFF)
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: (){
                          Get.to(()=> const Login());
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xffFFFFFF),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          minimumSize: const Size(342, 60),
                          backgroundColor: const Color(0xffFFFFFF)
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Login',
                              style: TextStyle(
                                color: Colors.black
                              )
                            ),
                            SizedBox(width: 10.0),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Center(
                      child: LongTransparentButton(
                        title: 'Signup',
                        onPressed: () {
                          Get.to(()=> const SignUp());
                        },
                      ),
                    ),
                  )
                ]
              ),
            ),
          )
        ],
      ),
    ));
  }
}