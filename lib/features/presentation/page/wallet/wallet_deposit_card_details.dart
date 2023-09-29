// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:gonana/consts.dart';
// import 'package:gonana/features/presentation/page/home.dart';
// import 'package:gonana/features/presentation/page/wallet/wallet_deposit_passcode.dart';
// import 'package:gonana/features/presentation/widgets/widgets.dart';
//
// class CardDetails extends StatefulWidget {
//   const CardDetails({super.key});
//
//   @override
//   State<CardDetails> createState() => _CardDetailsState();
// }
//
// class _CardDetailsState extends State<CardDetails> {
//   final TextEditingController _amount = TextEditingController();
//
//   String get amount => _amount.text;
//
//   int selectedOption = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color(0xffF1F1F1),
//         appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             leading: IconButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 icon: const Icon(
//                   Icons.arrow_back,
//                   size: 20,
//                   color: Color(0xff292D32),
//                 ))),
//         body: SafeArea(
//             child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         // height: 60,
//                         width: double.infinity,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Withdraawal',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             Text(
//                               'Enter your wallet details to withdraw.',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       EnterText(
//                           controller: _amount,
//                           label: 'Card Number',
//                           hint: 'Enter your card number'),
//                       sizeVer(10),
//                       Container(
//                           // height: 62,
//                           decoration: BoxDecoration(
//                               color: primaryColor,
//                               borderRadius: BorderRadius.circular(5)),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   SvgPicture.asset('assets/svgs/Buildings.svg'),
//                                   const Column(children: [
//                                     Text('First Bank of Nigeria',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w400,
//                                         )),
//                                     Text('2211221100',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w600,
//                                         )),
//                                     Text('Daniel John',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w400,
//                                         )),
//                                   ]),
//                                   sizeHor(30)
//                                 ]),
//                           )),
//                       sizeVer(15),
//                       Container(
//                           // height: 150,
//                           width: 342,
//                           decoration: BoxDecoration(
//                               color: primaryColor,
//                               borderRadius: BorderRadius.circular(5)),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 sizeVer(8),
//                                 Center(
//                                   child: const Text(
//                                       'How do you want receive your \nverification code',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w600)),
//                                 ),
//                                 SizedBox(
//                                   // height: 50,
//                                   // width: 250,
//                                   child: RadioListTile(
//                                       title: const Text(
//                                           'Receive OTP through email'),
//                                       value: 0,
//                                       groupValue: selectedOption,
//                                       onChanged: ((value) {
//                                         setState(() {
//                                           selectedOption = value!;
//                                         });
//                                       })),
//                                 ),
//                                 SizedBox(
//                                   // height: 50,
//                                   // width: 250,
//                                   child: RadioListTile(
//                                       title: const Text(
//                                           'Send me and SMS through mobile number'),
//                                       value: 1,
//                                       groupValue: selectedOption,
//                                       onChanged: ((value) {
//                                         setState(() {
//                                           selectedOption = value!;
//                                         });
//                                       })),
//                                 )
//                               ])),
//                       const Spacer(),
//                       LongGradientButton(
//                           title: 'Proceed',
//                           onPressed: () {
//                             Get.to(() => WalletCardPasscode());
//                           }),
//                     ]))));
//   }
// }
