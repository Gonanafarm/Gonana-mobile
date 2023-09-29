// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:gonana/features/presentation/page/bank_account/bank_account.dart';
// import 'package:gonana/features/presentation/widgets/widgets.dart';
//
// import '../savings/view_savings.dart';
//
// class AddBankAccount extends StatefulWidget {
//   const AddBankAccount({super.key});
//
//   @override
//   State<AddBankAccount> createState() => _AddBankAccountState();
// }
//
// class _AddBankAccountState extends State<AddBankAccount> {
//   final TextEditingController _accountNumber = TextEditingController();
//
//   String get accountNumber => _accountNumber.text;
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
//         body: Padding(
//           padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
//           child: Column(
//             children: [
//               const Padding(
//                 padding: const EdgeInsets.only(bottom: 38.0),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Add Bank Account',
//                         style: TextStyle(
//                             fontSize: 24, fontWeight: FontWeight.w600),
//                         textAlign: TextAlign.left,
//                       ),
//                       Text(
//                         'Enter These details.',
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.w400),
//                         textAlign: TextAlign.left,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 270,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     EnterText(
//                       controller: _accountNumber,
//                       label: 'Account Number',
//                       hint: 'Enter Number here'
//                     ),
//                     Container(
//                       height: 60,
//
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.all(4.0),
//                           child: Text('Select Account',
//                               style: TextStyle(
//                                   color: Color(0xff444444),
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400),
//                               textAlign: TextAlign.left),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             selectBank(context);
//                           },
//                           child: Container(
//                               // height: 60,
//                               decoration: BoxDecoration(
//                                   color: Colors.transparent,
//                                   border: Border.all(
//                                     color: const Color(0xff444444),
//                                   ),
//                                   borderRadius: BorderRadius.circular(5)),
//                               child: const Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           left: 8.0, top: 22, bottom: 20),
//                                       child: Text(
//                                           'Select from our verified merchant',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400,
//                                               color: Color(0xff444444))),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(right: 8.0),
//                                       child: Icon(Icons.expand_more),
//                                     )
//                                   ])),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               LongGradientButton(
//                   title: 'Confirm',
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
//                                 child: Text('Bank acccount added succesful'),
//                               ),
//                               actions: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 30.0),
//                                   child: DialogGradientButton(
//                                     title: 'Proceed',
//                                     onPressed: () {
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
//                   })
//             ],
//           ),
//         ));
//   }
//
//   selectBank(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         builder: (context) {
//           return Container(
//               height: MediaQuery.of(context).size.height * .85,
//               color: const Color(0xffF1F1F1),
//               child: Column(children: [
//                 SizedBox(
//                     width: double.infinity,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(8.0, 8.0, 24, 8.0),
//                           child: IconButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               icon: const Icon(Icons.close)),
//                         ),
//                       ],
//                     )),
//                 Padding(
//                     padding: const EdgeInsets.fromLTRB(24, 15, 24, 24),
//                     child: Column(children: [
//                       const SizedBox(
//                         width: double.infinity,
//                         child: Padding(
//                           padding: EdgeInsets.only(bottom: 30.0),
//                           child: Text('Select a Banking Firm',
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               textAlign: TextAlign.left),
//                         ),
//                       ),
//                       SizedBox(
//                           height: 380,
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 CustomListTile(
//                                     onTap: () {}, title: 'First Bank PLC'),
//                                 CustomListTile(
//                                     onTap: () {},
//                                     title: 'United Bank for Africa'),
//                                 CustomListTile(
//                                     onTap: () {}, title: 'Union Bank'),
//                                 CustomListTile(
//                                     onTap: () {}, title: 'Fidelity Bank '),
//                                 CustomListTile(
//                                     onTap: () {}, title: 'Access Bank'),
//                                 CustomListTile(onTap: () {}, title: 'Wema Bank')
//                               ]))
//                     ]))
//               ]));
//         });
//   }
// }
//
// class CustomListTile extends StatelessWidget {
//   final VoidCallback onTap;
//   final String title;
//   const CustomListTile({super.key, required this.onTap, required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//           width: 342,
//           height: 56,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 15.0),
//               child: Text(title,
//                   style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black)),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(right: 15.0),
//               child: Icon(Icons.arrow_forward_ios),
//             )
//           ])),
//     );
//   }
// }
