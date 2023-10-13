import 'package:flutter/material.dart';

const backGroundColor = Color.fromRGBO(0, 0, 0, 1.0);
const blueColor = Color.fromRGBO(0, 149, 246, 1);
const primaryColor = Colors.white;
const secondaryColor = Color.fromRGBO(22, 22, 22, 1);
const darkGreyColor = Color.fromRGBO(97, 97, 97, 1);
const greenColor = Color.fromRGBO(41, 132, 75, 1);
const redColor = Color(0xffFF2323);
const yellowColor = Color(0xffFFD700);
const darkColor = Color.fromRGBO(0, 0, 0, 1);
const greyColor = Color.fromRGBO(41, 45, 50, 1);
const navColor = Color.fromRGBO(241, 241, 241, 1);
List<String> nigerianStates = [
  "Abia",
  "Adamawa",
  "Akwa Ibom",
  "Anambra",
  "Bauchi",
  "Bayelsa",
  "Benue",
  "Borno",
  "Cross River",
  "Delta",
  "Ebonyi",
  "Edo",
  "Ekiti",
  "Enugu",
  "Gombe",
  "Imo",
  "Jigawa",
  "Kaduna",
  "Kano",
  "Katsina",
  "Kebbi",
  "Kogi",
  "Kwara",
  "Lagos",
  "Nasarawa",
  "Niger",
  "Ogun",
  "Ondo",
  "Osun",
  "Oyo",
  "Plateau",
  "Rivers",
  "Sokoto",
  "Taraba",
  "Yobe",
  "Zamfara",
  "Federal Capital Territory"
];

Widget sizeVer(double height) {
  return SizedBox(
    height: height,
  );
}

Widget sizeHor(double width) {
  return SizedBox(width: width);
}

Widget myDivider() {
  return Divider(
    thickness: 1,
    color: Color.fromRGBO(0, 0, 0, 0.1),
  );
}

List<String> images = [
  'assets/images/image 4.png',
  'assets/images/image 6.png',
  'assets/images/image 7.png',
];

class PageConst {
  static const String marketPage = "marketpage";
  static const String hotDeals = "hotdeals";
  static const String buyNow = "buynow";
  static const String cartPage = "cartpage";
  static const String checkoutPage = "checkoutpage";
}

String? emailValidator(value) {
  RegExp emailRegex =
      RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email';
  } else {
    return null;
  }
}

String? inputValidator(value) {
  if (value == null || value.isEmpty) {
    return 'Field must not be empty';
  } else {
    return null;
  }
}

String? passwordValidator(value) {
  RegExp passwordRegex =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d\W_]{8,}$');
  if (!passwordRegex.hasMatch(value)) {
    return 'Your password must be at least 8 characters,\n'
        'containing at least one uppercase letter,\none lowercase letter, and one digit.\n'
        'Special characters are allowed but not required.';
  }
  return null;
}

// String? passwordValidator(value){
//   RegExp passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$');
//   if(!passwordRegex.hasMatch(value)){
//     return 'Your password must be at least 8 characters,\ncontaining at least one uppercase letter,\none lowercase letter, and one digit';
//   }return null;
// }

String? phoneValidator(value) {
  RegExp phoneRegex = RegExp(r'^\d{10,}$');
  if (!phoneRegex.hasMatch(value)) {
    return 'Enter valid phone number';
  }
  return null;
}

String? bvnValidator(value) {
  RegExp bvnRegex = RegExp(r'^.{1,11}$');
  if (!bvnRegex.hasMatch(value)) {
    return 'Input should have up to 11 characters';
  }
  return null;
}
