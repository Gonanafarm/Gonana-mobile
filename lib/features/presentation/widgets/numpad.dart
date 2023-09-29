// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gonana/services/local_auth_service.dart';

import 'bottomsheets.dart';

class NumPad extends StatefulWidget {
  final double buttonSize;
  final VoidCallback? faceIdFunction;
  final Color buttonColor;
  final Color iconColor;
  final TextEditingController controller;
  final Function delete;

  const NumPad({
    Key? key,
    this.buttonSize = 70,
    this.buttonColor = Colors.indigo,
    this.iconColor = Colors.amber,
    required this.delete,
    required this.controller,
    this.faceIdFunction,
  }) : super(key: key);

  @override
  State<NumPad> createState() => _NumPadState();
}

class _NumPadState extends State<NumPad> {
  bool authenticated = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 352,
      width: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberButton(
                number: 1,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
              NumberButton(
                number: 2,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
              NumberButton(
                number: 3,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberButton(
                number: 4,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
              NumberButton(
                number: 5,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
              NumberButton(
                number: 6,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberButton(
                number: 7,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
              NumberButton(
                number: 8,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
              NumberButton(
                number: 9,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 70, height: 70),
              NumberButton(
                number: 0,
                size: widget.buttonSize,
                color: widget.buttonColor,
                controller: widget.controller,
              ),
              SizedBox(
                width: 70,
                child: GestureDetector(
                  onTap: widget.faceIdFunction,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff082D28),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: SvgPicture.asset('assets/svgs/fingerprint_auth.svg',
                        height: 70, width: 70, fit: BoxFit.fitWidth),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NumberButton extends StatelessWidget {
  final int number;
  final double size;
  final Color color;
  final TextEditingController controller;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff082D28),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              controller.text += number.toString();
            },
            child: Center(
              child: Text(number.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 36)),
            )));
  }
}
