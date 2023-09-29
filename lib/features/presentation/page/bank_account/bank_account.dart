// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:gonana/features/presentation/page/bank_account/add_bank_account.dart';
// import 'package:gonana/features/presentation/page/bank_account/add_card.dart';
// import 'package:gonana/features/presentation/page/home.dart';
//
// class BankAccount extends StatelessWidget {
//   const BankAccount({super.key});
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
//                   Get.to(() => HomePage(navIndex: 2));
//                 })),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     width: double.infinity,
//                     child: Text(
//                       'Bank Account',
//                       style:
//                           TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                   Padding(
//                       padding: const EdgeInsets.only(top: 35),
//                       child: SizedBox(
//                         width: 342,
//                         height: 430,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                               height: 167,
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     height: 74,
//                                     width: 342,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           SvgPicture.asset(
//                                               'assets/svgs/bank_building.svg'),
//                                           Column(
//                                             children: const [
//                                               Text(
//                                                 'First Bank of Nigeria',
//                                                 style: TextStyle(
//                                                     fontSize: 14,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//                                               Text(
//                                                 '2211221100',
//                                                 style: TextStyle(
//                                                     fontSize: 14,
//                                                     fontWeight:
//                                                         FontWeight.w600),
//                                               ),
//                                               Text(
//                                                 'Daniel John',
//                                                 style: TextStyle(
//                                                     fontSize: 14,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               )
//                                             ],
//                                           ),
//                                           const SizedBox(width: 20),
//                                           const Icon(
//                                             Icons.arrow_forward_ios,
//                                             color: Colors.black,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     height: 74,
//                                     width: 342,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: Padding(
//                                       padding: EdgeInsets.all(8),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Image.asset(
//                                               'assets/images/mastercard_icon.png',
//                                               height: 20,
//                                               width: 32,
//                                               fit: BoxFit.contain),
//                                           const Text(
//                                             '51993 1******0074',
//                                             style: TextStyle(
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w400),
//                                           ),
//                                           const SizedBox(width: 20),
//                                           const Icon(
//                                             Icons.arrow_forward_ios,
//                                             color: Colors.black,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 167,
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const AddBankAccount()));
//                                     },
//                                     child: Container(
//                                       width: 342,
//                                       height: 74,
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5)),
//                                       child: Center(
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: const [
//                                             Text(
//                                               'Add bank account',
//                                               style: TextStyle(
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.w400),
//                                             ),
//                                             SizedBox(width: 9),
//                                             Icon(Icons.add)
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const AddCard()));
//                                     },
//                                     child: Container(
//                                       width: 342,
//                                       height: 74,
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(5)),
//                                       child: Center(
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: const [
//                                             Text(
//                                               'Add Card',
//                                               style: TextStyle(
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.w400),
//                                             ),
//                                             SizedBox(width: 62),
//                                             Icon(Icons.add)
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ))
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
