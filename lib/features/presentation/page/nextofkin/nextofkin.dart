// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:gonana/features/presentation/page/home.dart';
// import 'package:gonana/features/presentation/page/settings/settings.dart';
// import 'package:gonana/features/presentation/widgets/widgets.dart';
// import 'package:intl/intl.dart';
// import 'editnok.dart';
//
// class NextOfKin extends StatefulWidget {
//   const NextOfKin({super.key});
//
//   @override
//   State<NextOfKin> createState() => _NextOfKinState();
// }
//
// class _NextOfKinState extends State<NextOfKin> {
//   final TextEditingController _firstName = TextEditingController();
//   final TextEditingController _fullName = TextEditingController();
//   final TextEditingController _address = TextEditingController();
//   final TextEditingController _phoneNumber = TextEditingController();
//   final TextEditingController _relationship = TextEditingController();
//
//   String get firstName => _firstName.text;
//   String get fullName => _fullName.text;
//   String get address => _address.text;
//   String get phoneNumber => _phoneNumber.text;
//   String get relationship => _relationship.text;
//
//   DateTime? dob;
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
//               padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: ListView(
//                       children: [
//                         Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(
//                                   width: double.infinity,
//                                   child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Next of Kin',
//                                           style: TextStyle(
//                                               fontSize: 24,
//                                               fontWeight: FontWeight.w600),
//                                           textAlign: TextAlign.left,
//                                         ),
//                                         Text(
//                                           'Enter  These details',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400),
//                                           textAlign: TextAlign.left,
//                                         ),
//                                       ])),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 15),
//                                 child: EnterText(
//                                     controller: _fullName,
//                                     label: 'Full Name',
//                                     hint: 'Enter Full Name'),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 15),
//                                 child: EnterText(
//                                     controller: _address,
//                                     label: 'Address',
//                                     hint: 'Enter Address'),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 15),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Date of Birth',
//                                       style: TextStyle(
//                                           color: Color(0xff444444),
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w400),
//                                       textAlign: TextAlign.left,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () async {
//                                         DateTime? SelectedDob =
//                                             await showDatePicker(
//                                           context: context,
//                                           initialDate: dob ?? DateTime.now(),
//                                           firstDate: DateTime(1900),
//                                           lastDate: DateTime(2100),
//                                         );
//                                         if (SelectedDob == null) return;
//                                         //If OK
//                                         setState(() {
//                                           dob = SelectedDob;
//                                         });
//                                       },
//                                       child: Container(
//                                           height: 60,
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               0.9,
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   color:
//                                                       const Color(0xff444444)),
//                                               borderRadius:
//                                                   BorderRadius.circular(5)),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 15.0),
//                                                 child: Text(
//                                                   dob != null
//                                                       ? DateFormat('dd/MM/yy')
//                                                           .format(dob!)
//                                                       : 'select a date',
//                                                   style: const TextStyle(
//                                                       color: Color(0xff444444),
//                                                       fontSize: 14,
//                                                       fontWeight:
//                                                           FontWeight.w400),
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     right: 15.0),
//                                                 child: SvgPicture.asset(
//                                                     'assets/svgs/calender.svg'),
//                                               )
//                                             ],
//                                           )),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 15),
//                                 child: EnterText(
//                                     controller: _phoneNumber,
//                                     label: 'Phone Number',
//                                     hint: 'Enter mobile number'),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 15),
//                                 child: EnterText(
//                                     controller: _phoneNumber,
//                                     label: 'Relationship',
//                                     hint: 'e.g Brother'),
//                               ),
//                             ]),
//                       ],
//                     ),
//                   ),
//                   Center(
//                       child: LongGradientButton(
//                           title: 'Confirm',
//                           onPressed: () {
//                             Get.to(() => const EditNok());
//                           }))
//                 ],
//               )),
//         ));
//   }
// }
