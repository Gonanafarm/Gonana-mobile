import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../consts.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            "Pay Now",
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
            size: 25,
          )
        ],
      ),
    );
  }
}
