// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:gonana/features/controllers/auth/passcode_controller.dart';
// import 'package:gonana/features/presentation/page/bank_account/bank_account.dart';
// import 'package:gonana/features/presentation/widgets/numpad.dart';
// import 'package:gonana/features/presentation/widgets/pinWidget.dart';
// import 'package:gonana/features/presentation/widgets/widgets.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import '../savings/view_savings.dart';
//
// class CardPasscode extends StatefulWidget {
//   const CardPasscode({super.key});
//
//   @override
//   State<CardPasscode> createState() => _CardPasscodeState();
// }
//
// class _CardPasscodeState extends State<CardPasscode> {
//   PasscodeController passcodeController = Get.put(PasscodeController());
//   TextEditingController _passCodeController = TextEditingController();
//   String get passCode => _passCodeController.text;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF1F1F1),
//       appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: IconButton(
//               icon: const Icon(
//                 Icons.arrow_back,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               })),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       'Four Digit passcode',
//                       style:
//                           TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//                       textAlign: TextAlign.left,
//                     ),
//                     Text(
//                       'Enter you four digit password to confirm this\n transaction',
//                       style:
//                           TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//                       textAlign: TextAlign.left,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.75,
//                 child: PinWidget(textEditingController: _passCodeController),
//               ),
//               NumPad(
//                 controller: _passCodeController,
//                 delete: () {},
//               ),
//               LongGradientButton(
//                 title: 'Proceed',
//                 onPressed: () async {
//                   bool created = false;
//                   print("passcode: $passCode");
//                   created = await passcodeController.verifyPasscode(passCode);
//                   if (created) {
//                     showDialog(
//                       context: context,
//                       barrierDismissible:
//                           true, // Set to true if you want to allow dismissing the dialog by tapping outside it
//                       builder: (BuildContext context) {
//                         return BackdropFilter(
//                           filter: ImageFilter.blur(
//                               sigmaX: 20,
//                               sigmaY:
//                                   20), // Adjust the blur intensity as needed
//                           child: Container(
//                             height: 100,
//                             child: AlertDialog(
//                               title: Center(
//                                 child: Icon(
//                                   size: 60,
//                                   Icons.check_circle_outlined,
//                                 ),
//                               ),
//                               content: Padding(
//                                 padding: const EdgeInsets.only(left: 60.0),
//                                 child: Text('Transaction Succesful'),
//                               ),
//                               actions: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 30.0),
//                                   child: DialogGradientButton(
//                                     title: 'Proceed',
//                                     onPressed: () async {
//                                       Get.to(() => BankAccount());
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
