// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:gonana/consts.dart';
// import 'package:gonana/features/presentation/page/wallet/wallet_deposit.dart';
// import 'package:gonana/features/presentation/page/wallet/wallet_withdrawal.dart';
//
// import '../savings/savings_splash.dart';
// import '../staking/staking_splash.dart';
// import '../swap/swap_page.dart';
//
// class WalletPage extends StatelessWidget {
//   const WalletPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color(0xffF1F1F1),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//             Container(
//               width: double.infinity,
//               height: 300,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topRight,
//                   end: Alignment.bottomLeft,
//                   colors: [Color(0xff29844B), Color(0xff003633)]
//                 )
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                   const Padding(
//                     padding: EdgeInsets.only(top: 60.0, bottom: 10),
//                     child: Text('Fiat balance',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400
//                       )
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 10.0),
//                     child: Text('NGN 50,000',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.w600
//                       )
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10.0),
//                     child: Center(
//                       child: SizedBox(
//                         width: 180,
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   Get.to(()=> WalletWithdrawal());
//                                 },
//                                 child: SizedBox(
//                                   height: 50,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       SvgPicture.asset(
//                                         'assets/svgs/money1.svg',
//                                         colorFilter: const ColorFilter.mode(
//                                             Colors.white, BlendMode.srcIn),
//                                       ),
//                                       const Text(
//                                         'Withdraw',
//                                         style: TextStyle(
//                                           color: primaryColor,
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w400
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   Get.to(()=> WalletDeposit());
//                                 },
//                                 child: SizedBox(
//                                   height: 50,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       SvgPicture.asset(
//                                         'assets/svgs/money1.svg',
//                                         colorFilter: const ColorFilter.mode(
//                                             Colors.white, BlendMode.srcIn),
//                                       ),
//                                       const Text(
//                                         'Deposit',
//                                         style: TextStyle(
//                                             color: primaryColor,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w400),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ]),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10.0),
//                     child: Container(
//                         height: 32,
//                         width: 254,
//                         decoration: BoxDecoration(
//                             color: primaryColor,
//                             borderRadius: BorderRadius.circular(5)),
//                         child: const Center(
//                             child: Text('Portfolio Value : NGN 500,000'))),
//                   )
//                 ])),
//             ),
//             Container(
//               //color: Color(0xff1E1E1E),
//               child: Column(
//                 children: [
//                   SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 20),
//                           child: Container(
//                             height: 72,
//                             width: 342,
//                             decoration: BoxDecoration(
//                                 color: primaryColor,
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8),
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         Get.to(() =>
//                                           const SavingsSplashScreen()
//                                         );
//                                       },
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           SvgPicture.asset(
//                                               'assets/svgs/savings.svg'),
//                                           const Text('Savings',
//                                             style: TextStyle(
//                                               fontSize: 10,
//                                               fontWeight: FontWeight.w400
//                                             )
//                                           )
//                                         ]
//                                       )
//                                     )
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8),
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         Get.to(() => const SwapScreen());
//                                       },
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           SvgPicture.asset(
//                                               'assets/svgs/swap.svg'),
//                                           const Text('Swap',
//                                             style: TextStyle(
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w400
//                                             )
//                                           )
//                                         ]
//                                       )
//                                     )
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8),
//                                     child: GestureDetector(
//                                       onTap: () {
//
//                                       },
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           SvgPicture.asset('assets/svgs/token.svg'),
//                                           const Text('Buy token',
//                                             style: TextStyle(
//                                               fontSize: 10,
//                                               fontWeight: FontWeight.w400
//                                             )
//                                           )
//                                         ]
//                                       )
//                                     )
//                                   ),
//                                   Padding(
//                                       padding: const EdgeInsets.all(8),
//                                       child: GestureDetector(
//                                           onTap: () {},
//                                           child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 SvgPicture.asset(
//                                                     'assets/svgs/sell_token.svg'),
//                                                 const Text('Sell token',
//                                                     style: TextStyle(
//                                                         fontSize: 10,
//                                                         fontWeight:
//                                                             FontWeight.w400))
//                                               ]))),
//                                   Padding(
//                                       padding: const EdgeInsets.all(8),
//                                       child: GestureDetector(
//                                           onTap: () {
//                                             Get.to(() =>
//                                                 const StakingSplashScreen());
//                                           },
//                                           child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 SvgPicture.asset(
//                                                     'assets/svgs/stake.svg'),
//                                                 const Text('Stake',
//                                                     style: TextStyle(
//                                                         fontSize: 10,
//                                                         fontWeight:
//                                                             FontWeight.w400))
//                                               ]))),
//                                 ]),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 6),
//                           child: Container(
//                               width: 342,
//                               height: 56,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: primaryColor),
//                               child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     SvgPicture.asset('assets/svgs/BTC.svg'),
//                                     const SizedBox(width: 20),
//                                     const Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Text('BTC 0',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600)),
//                                         Text('NGN 0',
//                                             style: TextStyle(
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w400)),
//                                       ],
//                                     ),
//                                     const SizedBox(width: 20),
//                                     const SizedBox(
//                                       width: 60,
//                                       child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text('-1.23%',
//                                                 style: TextStyle(
//                                                     color: redColor,
//                                                     fontSize: 10,
//                                                     fontWeight:
//                                                         FontWeight.w400)),
//                                             Icon(Icons.arrow_forward_ios)
//                                           ]),
//                                     ),
//                                   ])),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 6),
//                           child: Container(
//                               width: 342,
//                               height: 56,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: primaryColor),
//                               child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     SvgPicture.asset('assets/svgs/BTC.svg'),
//                                     const SizedBox(width: 20),
//                                     const Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Text('BTC 0',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600)),
//                                         Text('NGN 0',
//                                             style: TextStyle(
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w400)),
//                                       ],
//                                     ),
//                                     const SizedBox(width: 20),
//                                     const SizedBox(
//                                       width: 60,
//                                       child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text('-1.23%',
//                                                 style: TextStyle(
//                                                     color: redColor,
//                                                     fontSize: 10,
//                                                     fontWeight:
//                                                         FontWeight.w400)),
//                                             Icon(Icons.arrow_forward_ios)
//                                           ]),
//                                     ),
//                                   ])),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 6),
//                           child: Container(
//                               width: 342,
//                               height: 56,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: primaryColor),
//                               child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     SvgPicture.asset('assets/svgs/BTC.svg'),
//                                     const SizedBox(width: 20),
//                                     const Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Text('BTC 0',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600)),
//                                         Text('NGN 0',
//                                             style: TextStyle(
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w400)),
//                                       ],
//                                     ),
//                                     const SizedBox(width: 20),
//                                     const SizedBox(
//                                       width: 60,
//                                       child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text('-1.23%',
//                                                 style: TextStyle(
//                                                     color: redColor,
//                                                     fontSize: 10,
//                                                     fontWeight:
//                                                         FontWeight.w400)),
//                                             Icon(Icons.arrow_forward_ios)
//                                           ]),
//                                     ),
//                                   ])),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 6),
//                           child: Container(
//                               width: 342,
//                               height: 56,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: primaryColor),
//                               child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     SvgPicture.asset('assets/svgs/BTC.svg'),
//                                     const SizedBox(width: 20),
//                                     const Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Text('BTC 0',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600)),
//                                         Text('NGN 0',
//                                             style: TextStyle(
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w400)),
//                                       ],
//                                     ),
//                                     const SizedBox(width: 20),
//                                     const SizedBox(
//                                       width: 60,
//                                       child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text('-1.23%',
//                                                 style: TextStyle(
//                                                     color: redColor,
//                                                     fontSize: 10,
//                                                     fontWeight:
//                                                         FontWeight.w400)),
//                                             Icon(Icons.arrow_forward_ios)
//                                           ]),
//                                     ),
//                                   ])),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 6),
//                           child: Container(
//                               width: 342,
//                               height: 56,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: primaryColor),
//                               child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     SvgPicture.asset('assets/svgs/BTC.svg'),
//                                     const SizedBox(width: 20),
//                                     const Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Text('BTC 0',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600)),
//                                         Text('NGN 0',
//                                             style: TextStyle(
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w400)),
//                                       ],
//                                     ),
//                                     const SizedBox(width: 20),
//                                     const SizedBox(
//                                       width: 60,
//                                       child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text('-1.23%',
//                                                 style: TextStyle(
//                                                     color: redColor,
//                                                     fontSize: 10,
//                                                     fontWeight:
//                                                         FontWeight.w400)),
//                                             Icon(Icons.arrow_forward_ios)
//                                           ]),
//                                     ),
//                                   ])),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 6),
//                           child: Container(
//                               width: 342,
//                               height: 56,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: primaryColor),
//                               child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     SvgPicture.asset('assets/svgs/BTC.svg'),
//                                     const SizedBox(width: 20),
//                                     const Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Text('BTC 0',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600)),
//                                         Text('NGN 0',
//                                             style: TextStyle(
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w400)),
//                                       ],
//                                     ),
//                                     const SizedBox(width: 20),
//                                     const SizedBox(
//                                       width: 60,
//                                       child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text('-1.23%',
//                                                 style: TextStyle(
//                                                     color: redColor,
//                                                     fontSize: 10,
//                                                     fontWeight:
//                                                         FontWeight.w400)),
//                                             Icon(Icons.arrow_forward_ios)
//                                           ]),
//                                     ),
//                                   ])),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 6),
//                           child: Container(
//                               width: 342,
//                               height: 56,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: primaryColor),
//                               child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     SvgPicture.asset('assets/svgs/BTC.svg'),
//                                     const SizedBox(width: 20),
//                                     const Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Text('BTC 0',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w600)),
//                                         Text('NGN 0',
//                                             style: TextStyle(
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.w400)),
//                                       ],
//                                     ),
//                                     const SizedBox(width: 20),
//                                     const SizedBox(
//                                       width: 60,
//                                       child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text('-1.23%',
//                                                 style: TextStyle(
//                                                     color: redColor,
//                                                     fontSize: 10,
//                                                     fontWeight:
//                                                         FontWeight.w400)),
//                                             Icon(Icons.arrow_forward_ios)
//                                           ]),
//                                     ),
//                                   ])),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ]),
//         ));
//   }
// }
