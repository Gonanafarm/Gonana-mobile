import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinWidget extends StatelessWidget {
  const PinWidget({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
        controller: textEditingController,
        appContext: context,
        length: 4,
        onChanged: (value) {
          print(value);
        },
        onCompleted: (value) {
          print("Completed: $value");
        },
        pinTheme: PinTheme(
          activeColor: Color(0xff444444),
          inactiveColor: Color(0xff444444),
          borderWidth: 1,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 60,
          fieldWidth: 64,
          activeFillColor: Colors.white,
        ));
  }
}
