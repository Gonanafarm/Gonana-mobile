import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

class TwoChoiceDialog extends StatelessWidget {
  const TwoChoiceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Container(
            height: 298,
            width: 220,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/dialog_check.svg',
                      height: 72,
                      width: 72,
                    ),
                    const Text(
                      'Are you sure you want to\n delete this product?',
                      softWrap: true,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ShortGradientButton(
                          title: 'No, I don\'t', onPressed: () {}),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ShortBorderButton(
                        title: 'Yes, I do',
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    )
                  ],
                ))));
  }
}

class ConfirmChoice extends StatelessWidget {
  const ConfirmChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Container(
        height: 318,
        width: 220,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            SvgPicture.asset(
              'assets/svgs/dialog_check.svg',
              height: 72,
              width: 72,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'You\'ve successfully\nadded a new product',
                style: TextStyle(
                    color: Color(0xff444444),
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Note:\n \nFor Every succesful\n transaction there would be\n 1.5% charge',
                style: TextStyle(
                    color: Color(0xff444444),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ShortGradientButton(title: 'Continue', onPressed: () {}),
            ),
          ]),
        ),
      ),
    );
  }
}
