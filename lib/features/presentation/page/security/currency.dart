// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:gonana/features/presentation/page/security/security.dart';
// import 'package:gonana/features/presentation/widgets/widgets.dart';
//
// class Currency extends StatefulWidget {
//   const Currency({super.key});
//
//   @override
//   State<Currency> createState() => _CurrencyState();
// }
//
// class _CurrencyState extends State<Currency> {
//   TextEditingController textEditingController = TextEditingController();
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
//           padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 10.0),
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               const SizedBox(
//                 width: double.infinity,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Currency',
//                       style:
//                           TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//                       textAlign: TextAlign.left,
//                     ),
//                     Text(
//                       'select your currency',
//                       style:
//                           TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//                       textAlign: TextAlign.left,
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: SizedBox(
//                   height: 82,
//                   // width: 342,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Select Account',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w600),
//                       ),
//                       Container(
//                         height: 60,
//                         // width: 342,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: const Color(0xff444444)),
//                             borderRadius: BorderRadius.circular(5)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Padding(
//                                 padding: const EdgeInsets.only(left: 15.0),
//                                 child:
//                                     Text('Select from our verified merchant')),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 15.0),
//                               child: IconButton(
//                                   onPressed: () {
//                                     currencyModal(context);
//                                   },
//                                   icon: const Icon(Icons.expand_more)),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               const Spacer(),
//               LongGradientButton(
//                   title: 'Proceed',
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       barrierDismissible:
//                           false, // Set to true if you want to allow dismissing the dialog by tapping outside it
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
//                                 padding: const EdgeInsets.only(left: 30.0),
//                                 child: Text('Currency changed succesful'),
//                               ),
//                               actions: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 30.0),
//                                   child: DialogGradientButton(
//                                     title: 'Proceed',
//                                     onPressed: () {
//                                       Get.to(() => Security());
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   currencyModal(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         builder: (context) {
//           return Container(
//               height: MediaQuery.of(context).size.height * 0.85,
//               color: const Color(0xffF1F1F1),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: double.infinity,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.close, color: Colors.black),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const Text('Select a Banking Firm',
//                             style: TextStyle(
//                                 fontSize: 24, fontWeight: FontWeight.w600)),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 15.0, horizontal: 0.0),
//                           child: GestureDetector(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Container(
//                               width: 342,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(5)),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 15.0),
//                                     child: SvgPicture.asset(
//                                         'assets/svgs/naira.svg'),
//                                   ),
//                                   const Text(
//                                     'NGN (Naira)',
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 15.0),
//                                     child: IconButton(
//                                         onPressed: () {},
//                                         icon: const Icon(
//                                             Icons.arrow_forward_ios)),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 15.0, horizontal: 0.0),
//                           child: GestureDetector(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Container(
//                               width: 342,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(5)),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 15.0),
//                                     child: SvgPicture.asset(
//                                         'assets/svgs/naira.svg'),
//                                   ),
//                                   const Text(
//                                     'NGN (Naira)',
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 15.0),
//                                     child: IconButton(
//                                         onPressed: () {},
//                                         icon: const Icon(
//                                             Icons.arrow_forward_ios)),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 15.0, horizontal: 0.0),
//                           child: GestureDetector(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Container(
//                               width: 342,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(5)),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 15.0),
//                                     child: SvgPicture.asset(
//                                         'assets/svgs/dollar.svg'),
//                                   ),
//                                   const Text(
//                                     'USD (Dollar)',
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 15.0),
//                                     child: IconButton(
//                                         onPressed: () {},
//                                         icon: const Icon(
//                                             Icons.arrow_forward_ios)),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 15.0, horizontal: 0.0),
//                           child: GestureDetector(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Container(
//                               width: 342,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(5)),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 15.0),
//                                     child: SvgPicture.asset(
//                                         'assets/svgs/pound.svg'),
//                                   ),
//                                   const Text(
//                                     'GBP (Pounds)',
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 15.0),
//                                     child: IconButton(
//                                         onPressed: () {},
//                                         icon: const Icon(
//                                             Icons.arrow_forward_ios)),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 15.0, horizontal: 0.0),
//                           child: GestureDetector(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Container(
//                               width: 342,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(5)),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 15.0),
//                                     child:
//                                         SvgPicture.asset('assets/svgs/yen.svg'),
//                                   ),
//                                   const Text(
//                                     'JPY (Yen)',
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 15.0),
//                                     child: IconButton(
//                                         onPressed: () {},
//                                         icon: const Icon(
//                                             Icons.arrow_forward_ios)),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ));
//         });
//   }
// }
