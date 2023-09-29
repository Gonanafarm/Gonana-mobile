import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gonana/consts.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryModal extends StatelessWidget {
  const DeliveryModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/svgs/Good.svg"),
              sizeVer(10),
              Text(
                "You can track your order from\nthe red star site Proceed",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: const Color.fromRGBO(68, 68, 68, 1),
                  fontWeight: FontWeight.w400,
                ),
              ),
              sizeVer(10),
              Container(
                width: 185,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.04, 0.9994],
                    colors: [
                      Color(0xff072C27),
                      Color(0xff29844B),
                    ],
                    transform: GradientRotation(89.94 * 3.14 / 180),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Proceed",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    sizeHor(5.0),
                    const Icon(
                      Icons.arrow_forward,
                      color: primaryColor,
                      size: 20,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
