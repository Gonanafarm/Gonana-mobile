import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../consts.dart';

class QuantityCard extends StatelessWidget {
  final Function increment;
  final Function decrement;
  final int count;
  const QuantityCard(
      {super.key,
      required this.increment,
      required this.decrement,
      required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: primaryColor,
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Quantity",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: darkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      increment();
                    },
                    icon: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(178, 178, 178, 1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Color.fromRGBO(41, 45, 50, 1),
                        size: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Text(
                      '$count',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      decrement();
                    },
                    icon: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(178, 178, 178, 1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Color.fromRGBO(41, 45, 50, 1),
                        size: 16,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text("maximum number of pre customer",
                        style: GoogleFonts.montserrat(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
