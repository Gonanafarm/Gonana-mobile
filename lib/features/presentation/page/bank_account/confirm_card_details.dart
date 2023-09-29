// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gonana/features/presentation/page/bank_account/add_card_passcode.dart';
// import 'package:gonana/features/presentation/widgets/widgets.dart';
//
// enum VerificationType { sms, otp }
//
// class ConfirmCardDetails extends StatefulWidget {
//   const ConfirmCardDetails({super.key});
//
//   @override
//   State<ConfirmCardDetails> createState() => _ConfirmCardDetailsState();
// }
//
// class _ConfirmCardDetailsState extends State<ConfirmCardDetails> {
//   final TextEditingController  _amount = TextEditingController();
//   String get amount => _amount.text;
//   VerificationType? _selectedOption = VerificationType.otp;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color(0xffF1F1F1),
//         appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             leading: IconButton(
//                 icon: const Icon(
//                   Icons.arrow_back,
//                   color: Colors.black,
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 })),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 0.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                     width: double.infinity,
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Confirm Details',
//                             style: TextStyle(
//                                 fontSize: 24, fontWeight: FontWeight.w600),
//                             textAlign: TextAlign.left,
//                           ),
//                           const Text(
//                             'Confirm your card details',
//                             style: TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.w400),
//                             textAlign: TextAlign.left,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 20),
//                             child: SizedBox(
//                               child: EnterText(
//                                 controller: _amount,
//                                 label: 'Amount',
//                                 hint: 'Enter Amount'
//                               )
//                             ),
//                           ),
//                           Container(
//                             width: 342,
//                             height: 62,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Center(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 15.0, right: 20),
//                                     child: SvgPicture.asset(
//                                         'assets/svgs/bank_building.svg'),
//                                   ),
//                                   const Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text('Daniel John',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600)),
//                                         SizedBox(height: 5),
//                                         Text('First Bank of Nigeria',
//                                             style: TextStyle(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w400))
//                                       ]),
//                                   const SizedBox()
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Container(
//                             width: 342,
//                             // height: 124,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Column(
//                               children: [
//                                 const SizedBox(
//                                     child: Padding(
//                                   padding: EdgeInsets.only(top: 10.0),
//                                   child: Text(
//                                       'How do you want receive your verification code',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w600),
//                                       textAlign: TextAlign.center),
//                                 )),
//                                 SizedBox(
//                                   child: Column(
//                                     children: [
//                                       ListTile(
//                                         visualDensity: VisualDensity(
//                                             horizontal: -4, vertical: -4),
//                                         leading: Radio<VerificationType>(
//                                             activeColor: Color(0xff0ff29844B),
//                                             value: VerificationType.otp,
//                                             groupValue: _selectedOption,
//                                             onChanged:
//                                                 (VerificationType? value) {
//                                               setState(() {
//                                                 _selectedOption = value;
//                                               });
//                                             }),
//                                         title: const Text(
//                                             'Recieve OTP through Email',
//                                             style: TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w400)),
//                                       ),
//                                       ListTile(
//                                         leading: Radio<VerificationType>(
//                                             activeColor: Color(0xff0ff29844B),
//                                             value: VerificationType.sms,
//                                             groupValue: _selectedOption,
//                                             onChanged:
//                                                 (VerificationType? value) {
//                                               setState(() {
//                                                 _selectedOption = value;
//                                               });
//                                             }),
//                                         title: const Text(
//                                           'Send me an SMS through mobile number',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w400),
//                                         ),
//                                       ),
//                                       SizedBox(height: 10),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ])),
//                 LongGradientButton(
//                     title: 'Proceed',
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const CardPasscode()));
//                     }),
//               ],
//             ),
//           ),
//         ));
//   }
// }
