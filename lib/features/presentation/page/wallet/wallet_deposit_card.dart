// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gonana/consts.dart';
// import 'package:gonana/features/presentation/page/wallet/wallet_deposit_card_details.dart';
// import 'package:gonana/features/presentation/widgets/widgets.dart';
//
//
// class CardDeposit extends StatelessWidget {
//   CardDeposit({super.key});
//
//   final TextEditingController _cardNumber =  TextEditingController();
//   final  TextEditingController _expiryDate =  TextEditingController();
//   final  TextEditingController _cvv =  TextEditingController();
//
//   String get cardNumber => _cardNumber.text;
//   String get expiryDate => _expiryDate.text;
//   String get cvv => _cvv.text;
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       backgroundColor: const Color(0xffF1F1F1),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: (){
//             Get.back();
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             size: 20,
//             color: Color(0xff292D32),
//           )
//         )
//       ),
//       body:  SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 60,
//                 width: double.infinity,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Withdrawal',
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Text(
//                       'Enter your wallet details to withdraw.',
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               EnterText(
//                 controller: _cardNumber,
//                 label: 'Card Number',
//                 hint: 'Enter your card number'
//               ),
//               sizeVer(10),
//               EnterText(
//                 controller: _expiryDate,
//                 label: 'Expiry Date',
//                 hint: 'Enter your expiry date'
//               ),
//               sizeVer(10),
//               EnterText(
//                 controller: _cvv,
//                 label: 'CVV',
//                 hint: 'Enter your CVV'
//               ),
//               const Spacer(),
//               LongGradientButton(
//                 title: 'Confirm Details',
//                 onPressed: (){
//                   Get.to(()=> CardDetails());
//                 }
//               ),
//             ]
//           )
//         )
//       )
//     );
//   }
//
// }
