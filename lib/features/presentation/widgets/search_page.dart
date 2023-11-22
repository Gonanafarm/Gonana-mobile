import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../consts.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  const SearchWidget({
    Key? key, 
    required this.controller,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1.5, color: darkColor)
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          border: InputBorder.none,
          suffixIcon: Container(
            padding: const EdgeInsets.only(right: 20),
            height: 24,
            width: 24,
            child: SvgPicture.asset(
              "assets/svgs/Search.svg",
            ),
          ),
          hintText: "type here to search",
          hintStyle: const TextStyle(color: darkGreyColor, fontSize: 15)
        ),
      ),
    );
  }
}
