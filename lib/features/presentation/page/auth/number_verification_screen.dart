// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gonana/features/presentation/page/auth/setpassword.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import '../../widgets/numpad.dart';
// import '../../widgets/widgets.dart';
//
// class NumberVerification extends StatefulWidget {
//   const NumberVerification({Key? key}) : super(key: key);
//
//   @override
//   State<NumberVerification> createState() => _NumberVerificationState();
// }
//
// class _NumberVerificationState extends State<NumberVerification> {
//   final TextEditingController _verificationController = TextEditingController();
//   String get verificationController => _verificationController.text;
//   var phoneNumber = "09029026157";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF1F1F1),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: const Icon(
//               Icons.arrow_back,
//               size: 20,
//               color: Color(0x00ff0000),
//             )),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(30, 8, 30, 30),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView(
//                 children: [
//                   SizedBox(
//                     width: double.infinity,
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text('Verification',
//                               style: TextStyle(
//                                   fontSize: 24, fontWeight: FontWeight.w600),
//                               textAlign: TextAlign.left),
//                           Text('Enter the code that was sent to $phoneNumber',
//                               textAlign: TextAlign.left)
//                         ]),
//                   ),
//                   const SizedBox(height: 30),
//                   SizedBox(
//                     // width: 300,
//                     child: Center(
//                       child: PinCodeTextField(
//                         controller: _verificationController,
//                         pinTheme: PinTheme(
//                           shape: PinCodeFieldShape.box,
//                           borderRadius: BorderRadius.circular(5),
//                           borderWidth: 1,
//                           fieldHeight: 60.0,
//                           fieldWidth: 64.0,
//                           activeColor: const Color(0xff444444),
//                           disabledColor: const Color(0xff444444),
//                           inactiveColor: const Color(0xff444444),
//                         ),
//                         appContext: context,
//                         length: 4,
//                         onChanged: (String value) {
//                           print(value);
//                         },
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 15.0),
//                     child: SizedBox(
//                       child: NumPad(
//                         controller: _verificationController,
//                         delete: (){}
//                       )
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             LongGradientButton(
//               title: 'Proceed',
//               onPressed: () {
//                 Get.to(()=> const SetPassword());
//               }
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
