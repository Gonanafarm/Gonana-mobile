import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../consts.dart';

class DeliveryCard extends StatelessWidget {
  const DeliveryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: primaryColor,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: primaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: darkColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      sizeVer(10),
                      Text(
                        "Red star Express PLC for logistics",
                        style: GoogleFonts.montserrat(
                          fontSize: 10,
                          color: darkColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      sizeVer(10),
                      Text(
                        "Estimated delivery date: March 12 2023",
                        style: GoogleFonts.montserrat(
                          fontSize: 10,
                          color: darkColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      sizeVer(10),
                      Text(
                        "Track ID: 9922739DAA",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: darkColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      sizeVer(5.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/svgs/location.svg"),
                          sizeHor(5.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your location: No1 friesland Road, PO Box\n97 97 Vom plateau state Nigeria",
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  color: darkColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              sizeVer(8),
                              Text(
                                "Phone Number: 09074839384",
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  color: darkColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  Icon(
                    Icons.chevron_right_outlined,
                    color: greyColor,
                  )
                ],
              ),
            ),
            sizeVer(10.0),
          ],
        ),
      ),
    );
  }
}
