// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:gonana/features/presentation/page/home.dart';
//
// class Referrals extends StatelessWidget {
//   const Referrals({super.key});
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
//         body: Padding(
//           padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
//           child: Column(
//             children: [
//               const SizedBox(
//                   width: double.infinity,
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Referrals',
//                           style: TextStyle(
//                               fontSize: 24, fontWeight: FontWeight.w600),
//                           textAlign: TextAlign.left,
//                         ),
//                         Text(
//                           'Earn 100 Gona each time another user signup using your referral link.',
//                           style: TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.w400),
//                           textAlign: TextAlign.left,
//                         ),
//                       ])),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: SizedBox(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         // width: 189,
//                         height: 44,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(5)),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.only(left: 8.0, right: 8),
//                                 child: Text('Johndavid22667/getL',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w400)),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 8.0),
//                                 child: SvgPicture.asset('assets/svgs/edit.svg'),
//                               )
//                             ]),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "250",
//                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 15.0),
//                     child: Text(
//                       "Gona",
//                       style: TextStyle(
//                         fontSize: 14,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 20),
//               Referred(
//                 name: 'Madam Loe',
//                 periodJoined: 'Joined 10 days ago',
//                 signupProgress: 'Signup complete',
//                 progressColor: Color(0xff29844B),
//               ),
//               SizedBox(height: 20),
//               Referred(
//                 name: 'Jake Doe',
//                 periodJoined: 'Joined 3h ago',
//                 signupProgress: 'Signup in progress',
//                 progressColor: Color(0xffFF2323),
//               )
//             ],
//           ),
//         ));
//   }
// }
//
// class Referred extends StatelessWidget {
//   final String name;
//   final String periodJoined;
//   final String signupProgress;
//   final Color progressColor;
//   const Referred(
//       {Key? key,
//       required this.name,
//       required this.periodJoined,
//       required this.signupProgress,
//       required this.progressColor})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(color: Color(0xffFFFFFF)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(height: 15),
//                 Text(
//                   periodJoined,
//                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
//                 ),
//               ],
//             ),
//             Text(
//               signupProgress,
//               style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400,
//                   color: progressColor),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
