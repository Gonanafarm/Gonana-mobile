// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gonana/features/presentation/page/bank_account/confirm_card_details.dart';
// import 'package:gonana/features/presentation/widgets/widgets.dart';
// import 'package:intl/intl.dart';
//
//
// class AddCard extends StatefulWidget {
//   const AddCard({super.key});
//
//   @override
//   State<AddCard> createState() => _AddCardState();
// }
//
// class _AddCardState extends State<AddCard> {
//   final TextEditingController _cardNumber = TextEditingController();
//   final TextEditingController  _cvv = TextEditingController();
//   String get cardNumber => _cardNumber.text;
//   String get cvv => _cvv.text;
//
//   DateTime? expDate;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF1F1F1),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: (){
//             Navigator.pop(context);
//           }
//         )
//       ),
//       body: Padding(
//         padding:  const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
//         child: Column(
//           children: [
//             SizedBox(
//               width: double.infinity,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:  [
//                   const Text('Add Card',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600
//                     ),
//                     textAlign: TextAlign.left,
//                   ),
//                   const Text('Enter your card details',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400
//                     ),
//                     textAlign: TextAlign.left,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 20),
//                     child: SizedBox(
//                       child: EnterText(
//                         controller: _cardNumber,
//                         label: 'Card Number',
//                         hint: 'Enter your card number'
//                       )
//                     ),
//                   ),
//                   SizedBox(
//                     height: 82,
//                     width: 342,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text('Expiry Date',
//                           style: TextStyle(
//                             color: Color(0xff444444),
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400
//                           ),
//                           textAlign: TextAlign.left,
//                         ),
//                         GestureDetector(
//                           onTap: () async{
//                             DateTime? SelectedExpDate = await showDatePicker(
//                               context: context,
//                               initialDate: expDate ?? DateTime.now(),
//                               firstDate: DateTime(1900),
//                               lastDate: DateTime(2100),
//                             );
//                             if(SelectedExpDate == null) return;
//                             //If OK
//                             setState(() {
//                               expDate = SelectedExpDate;
//                             });
//                           },
//                           child: Container(
//                             height: 60,
//                             width: 342,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: const Color(0xff444444)
//                               ),
//                               borderRadius: BorderRadius.circular(5)
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 15.0),
//                                   child: Text(
//                                     expDate != null ? DateFormat('dd/MM/yy').format(expDate!) : 'select your expiry date',
//                                     style: const TextStyle(
//                                       color: Color(0xff444444),
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 15.0),
//                                   child: SvgPicture.asset('assets/svgs/calender.svg'),
//                                 )
//                               ],
//                             )
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   EnterText(
//                     controller: _cvv,
//                     label: 'CVV',
//                     hint: 'Enter you CVV'
//                   )
//                 ],
//               ),
//             ),
//             const Spacer(),
//             LongGradientButton(title: 'Confirm', onPressed: (){
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const ConfirmCardDetails())
//               );
//             })
//           ]
//         )
//       )
//     );
//   }
// }
