import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../consts.dart';

class PaymentCard extends StatefulWidget {
  const PaymentCard({super.key});

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  String selectedRadioValue = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Type",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: darkColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            sizeVer(10),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pay with crypto",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: darkColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  sizeVer(10),
                  Row(
                    children: [
                      // Image.asset(
                      //   "assets/images/image 7.png",
                      //   width: 32,
                      //   height: 20,
                      // ),
                      // sizeHor(10),
                      Text(
                        "Crypto balance: ",
                        style: GoogleFonts.montserrat(
                          fontSize: 10,
                          color: darkColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              trailing: Icon(
                Icons.chevron_right_outlined,
                color: greyColor,
              ),
              leading: Radio(
                activeColor: Color(0xff29844B),
                value: 'Option 1',
                groupValue: selectedRadioValue,
                onChanged: (value) {
                  setState(() {
                    selectedRadioValue = value.toString();
                  });
                },
              ),
            ),
            sizeVer(15),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pay with GonnanaWallet",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: darkColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  sizeVer(8),
                  Text(
                    "Available balance: 20000 Gona",
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      color: darkColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Estimation: NGN 500,000",
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      color: darkColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.chevron_right_outlined,
                color: greyColor,
              ),
              leading: Radio(
                activeColor: Color(0xff29844B),
                value: 'Option 2',
                groupValue: selectedRadioValue,
                onChanged: (value) {
                  setState(() {
                    selectedRadioValue = value.toString();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
