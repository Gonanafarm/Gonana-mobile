// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:gonana/consts.dart';
// import 'package:gonana/features/presentation/page/wallet/wallet_deposit_bank_options.dart';
// import 'package:gonana/features/presentation/page/wallet/wallet_deposit_card.dart';
// import 'package:gonana/features/presentation/page/wallet/wallet_deposit_wallet_option.dart';
// import 'package:gonana/features/presentation/widgets/widgets.dart';
//
//
// class WalletDeposit extends StatelessWidget {
//   const WalletDeposit({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController amount =  TextEditingController();
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
//                 height: 50,
//                 width: double.infinity,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Deposit',
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Text(
//                       'Enter the amount you want to deposit',
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SizedBox(
//                   child: Column(
//                     children: [
//                       EnterText(
//                         label: "Fiat Amount",
//                         hint: "NGN",
//                         controller: amount
//                       ),
//                       const Text('Transaction fee: 00.00',
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: Container(
//                   width: 342,
//                   height: 170,
//                   decoration: BoxDecoration(
//                     color: primaryColor,
//                     borderRadius: BorderRadius.circular(5)
//                   ),
//                   child: const Center(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 15.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(vertical: 8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('Deposit amount',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                                 Text('00,000,000',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(vertical: 8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('Transaction Fee',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                                 Text('0',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(vertical: 8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('Estimation in USDT',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                                 Text('00,000,000',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const Spacer(),
//               LongGradientButton(
//                 title: "Proceed to deposit",
//                 onPressed: (){
//                   depositTypeBottomSheet(context);
//                 }
//               )
//             ]
//           )
//         )
//       )
//     );
//   }
//
//   void depositTypeBottomSheet(context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context){
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.67,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.black),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Deposit Type',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const Text(
//                       'Select the token you want to use for your savings.'
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.07),
//                     DepositTypeWidget(
//                       onTap: (){
//                         Get.to(()=>const WalletOptions());
//                       },
//                       leading: 'money',
//                       title: "Wallet peer to peer",
//                       subtitle: 'Use a third party wallet',
//                     ),
//                     const SizedBox(height: 10),
//                     DepositTypeWidget(
//                       onTap: (){
//                         Get.to(()=> const BankDeposit());
//                       },
//                       leading: 'Buildings',
//                       title: "Bank peer to peer",
//                       subtitle: 'Use bank accounts',
//                     ),
//                     const SizedBox(height: 10),
//                     DepositTypeWidget(
//                       onTap: (){
//                         Get.to(()=> CardDeposit());
//                       },
//                       leading: 'card',
//                       title: "Deposit with card",
//                       subtitle: 'Deposit using your Bank card',
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         );
//       }
//     );
//   }
// }
//
// class DepositTypeWidget extends StatefulWidget {
//   final VoidCallback onTap;
//   final String leading;
//   final String title;
//   final String subtitle;
//   const DepositTypeWidget({
//     Key? key,
//     required this.leading,
//     required this.title,
//     required this.subtitle,
//     required this.onTap,
//   }): super(key: key);
//
//
//   @override
//   State<DepositTypeWidget> createState() => _DepositTypeWidgetState();
// }
//
// class _DepositTypeWidgetState extends State<DepositTypeWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       color: primaryColor,
//       child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: ListTile(
//             visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
//             dense: true,
//             onTap: widget.onTap,
//             leading: Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: SvgPicture.asset("assets/svgs/${widget.leading}.svg")
//             ),
//             title: Text(
//               widget.title,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             subtitle: Text(
//               widget.subtitle,
//               style: const TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             trailing: const Icon(Icons.arrow_forward_ios,
//               color: Colors.black
//             )
//           ),
//         ),
//     );
//   }
// }
