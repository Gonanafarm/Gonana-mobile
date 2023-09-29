// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gonana/features/controllers/swap/swap_controller.dart';
// import 'package:gonana/features/presentation/page/swap/passcode.dart';
// import 'package:gonana/features/presentation/page/wallet/wallet_page.dart';
// import 'package:gonana/features/presentation/widgets/bottomsheets.dart';
// import '/features/presentation/widgets/widgets.dart';
// import 'package:get/get.dart';
//
// class SwapScreen extends StatefulWidget {
//   const SwapScreen({super.key});
//
//   @override
//   State<SwapScreen> createState() => _SwapScreenState();
// }
//
// class _SwapScreenState extends State<SwapScreen> {
//   // SwapController swapController = Get.put(SwapController());
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//         init: SwapController(),
//         builder: (swapController) {
//           return Scaffold(
//             backgroundColor: const Color(0xffF1F1F1),
//             appBar: AppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               leading: IconButton(
//                   onPressed: () {
//                     Get.to(()=> WalletPage());
//                   },
//                   icon: const Icon(
//                     Icons.arrow_back,
//                     size: 20,
//                     color: Color(0xff292D32),
//                   )),
//             ),
//             body: SafeArea(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                       child: ListView(
//                         children: [
//                           const Text(
//                             'Swap tokens',
//                             style: TextStyle(
//                                 fontSize: 24, fontWeight: FontWeight.w600),
//                           ),
//                           const Text('swap your tokens easily'),
//                           const SizedBox(height: 42),
//                           const Text(
//                             '  From',
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.w600),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 border: Border.all(color: Color(0xff1E1E1E))),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 20.0, right: 0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width:
//                                         MediaQuery.of(context).size.width * 0.3,
//                                     child: const TextField(
//                                       decoration: InputDecoration(
//                                         hintText: "Amount",
//                                         hintStyle: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400),
//                                         border: InputBorder.none,
//                                       ),
//                                     ),
//                                   ),
//                                   IntrinsicHeight(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           height: 40,
//                                           child: const VerticalDivider(
//                                             color: Colors.black,
//                                             thickness: 2,
//                                           ),
//                                         ),
//                                         Padding(
//                                             padding: const EdgeInsets.only(
//                                                 top: 15.0),
//                                             child: SvgPicture.asset(
//                                                 "assets/svgs/${swapController.tokenLogoFrom}.svg")),
//                                         Text(
//                                           swapController.tokenNameFrom
//                                               .toString(),
//                                           style: const TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               bottom: 8.0),
//                                           child: IconButton(
//                                             onPressed: () {
//                                               tokenBottomSheet1(context);
//                                             },
//                                             icon: const Icon(
//                                                 size: 40,
//                                                 Icons.arrow_drop_down),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 10.0, horizontal: 20),
//                             child: RichText(
//                               text: const TextSpan(
//                                 text: 'Your balance : NGN 500,000',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.black),
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                       text: ' MAX',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff29844B),
//                                       )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           const Icon(Icons.arrow_circle_down),
//                           const SizedBox(height: 20),
//                           const Text(
//                             '  To',
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.w600),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 border: Border.all(color: Color(0xff1E1E1E))),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 20.0, right: 0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width:
//                                         MediaQuery.of(context).size.width * 0.3,
//                                     child: const TextField(
//                                       decoration: InputDecoration(
//                                         hintText: "Amount",
//                                         hintStyle: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400),
//                                         border: InputBorder.none,
//                                       ),
//                                     ),
//                                   ),
//                                   IntrinsicHeight(
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           height: 40,
//                                           child: const VerticalDivider(
//                                             color: Colors.black,
//                                             thickness: 2,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 15.0),
//                                           child: SvgPicture.asset(
//                                               "assets/svgs/${swapController.tokenLogoTo}.svg"),
//                                         ),
//                                         Text(
//                                           swapController.tokenNameTo.toString(),
//                                           style: const TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               bottom: 8.0),
//                                           child: IconButton(
//                                             onPressed: () {
//                                               tokenBottomSheet2(context);
//                                             },
//                                             icon: const Icon(
//                                                 size: 40,
//                                                 Icons.arrow_drop_down),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 10.0, horizontal: 20),
//                             child: RichText(
//                               text: const TextSpan(
//                                 text: 'Your balance : NGN 23,000',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.black),
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                       text: ' MAX',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff29844B),
//                                       )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 42),
//                           Container(
//                               // height: 186,
//                               // width: 342,
//                               decoration: BoxDecoration(
//                                   color: const Color(0xffffffff),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 15.0),
//                                 child: Column(
//                                   children: [
//                                     Row(children: [
//                                       SizedBox(
//                                         // width: 300,
//                                         // height: 24,
//                                         child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               SizedBox(
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     SvgPicture.asset(
//                                                         "assets/svgs/${swapController.tokenLogoFrom}.svg"),
//                                                     Text(
//                                                       '1 ${swapController.tokenNameFrom}',
//                                                       style: const TextStyle(
//                                                           fontSize: 16,
//                                                           fontWeight:
//                                                               FontWeight.w600),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Text(' ='),
//                                               SizedBox(
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     SvgPicture.asset(
//                                                         "assets/svgs/${swapController.tokenLogoTo}.svg"),
//                                                     Container(
//                                                       width:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width *
//                                                               0.3,
//                                                       child: Text(
//                                                         '${swapController.tokenNameTo} 0.0023',
//                                                         style: const TextStyle(
//                                                             fontSize: 16,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w600),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ]),
//                                       ),
//                                     ]),
//                                     SizedBox(height: 40),
//                                     const Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text('You get'),
//                                           Text(
//                                             '1.23 USDT',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600),
//                                           )
//                                         ]),
//                                     Divider(),
//                                     Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text('Transaction Fee'),
//                                           Text(
//                                             '5 gona',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600),
//                                           )
//                                         ])
//                                   ],
//                                 ),
//                               )),
//                         ],
//                       ),
//                     ),
//                     LongGradientButton(
//                         title: 'Swap now',
//                         onPressed: () {
//                           Get.to(() => SwapPasscode());
//                         }),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }
