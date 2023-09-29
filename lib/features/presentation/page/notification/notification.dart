// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gonana/consts.dart';
//
//
// class Notifications extends StatelessWidget {
//   const Notifications({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color(0xffF1F1F1),
//         // appBar: AppBar(
//         //   backgroundColor: const Color(0xffF1F1F1),
//         //   elevation: 0,
//         //   leading: IconButton(
//         //       onPressed: () {
//         //         Get.to(() => const HomePage());
//         //       },
//         //       icon: const Icon(
//         //         Icons.arrow_back,
//         //         size: 20,
//         //         color: Color(0xff292D32),
//         //       )),
//         // ),
//         body: SafeArea(
//             child: ListView(children: [
//           const Padding(
//             padding: EdgeInsets.all(20.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: Text(
//                 'Notifications',
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//               child: Column(children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
//               child: ListTile(
//                 tileColor: Colors.white,
//                 leading: SvgPicture.asset('assets/svgs/Arrow.svg'),
//                 title: const Text(
//                   'Gona Bought',
//                   style: TextStyle(
//                     color: greenColor,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 subtitle: const Text(
//                   '500,000 GNX bought with NGN 500,000',
//                   style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 trailing: const Text('Jan 25')
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
//               child: ListTile(
//                   tileColor: Colors.white,
//                   leading: SvgPicture.asset('assets/svgs/Heart.svg'),
//                   title: const Text(
//                     'James and 32 other like your post.',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   trailing: const Text('Jan 25')),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
//               child: ListTile(
//                   tileColor: Colors.white,
//                   leading:
//                       SvgPicture.asset('assets/svgs/emails_messages_icon.svg'),
//                   title: const Text(
//                     'James and 12 other Commented on your post.',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   trailing: const Text('Jan 25')),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
//               child: ListTile(
//                   tileColor: Colors.white,
//                   leading: SvgPicture.asset('assets/svgs/Arrow2.svg'),
//                   title: const Text(
//                     'Gona Sold',
//                     style: TextStyle(
//                       color: redColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   subtitle: const Text(
//                     '100,000 GNX worth NGN 100,000',
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   trailing: const Text('Jan 25')),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
//               child: ListTile(
//                   tileColor: Colors.white,
//                   leading: SvgPicture.asset('assets/svgs/Shop.svg'),
//                   title: const Text(
//                     '20 chickens was succesfully sold to Daniel Cho',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   trailing: const Text('Jan 25')),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
//               child: ListTile(
//                   tileColor: Colors.white,
//                   leading: SvgPicture.asset('assets/svgs/money1.svg'),
//                   title: const Text(
//                     'Withdrawal Succesful',
//                     style: TextStyle(
//                       color: redColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   subtitle: const Text(
//                     'You\'ve withdrawn NGN 20,000',
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   trailing: const Text('Jan 25')),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
//               child: ListTile(
//                   tileColor: Colors.white,
//                   leading: SvgPicture.asset('assets/svgs/money2.svg'),
//                   title: const Text(
//                     'Deposit',
//                     style: TextStyle(
//                       color: greenColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   subtitle: const Text(
//                     'NGN 20,000 was deposited to your wallet',
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   trailing: const Text('Jan 25')),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
//               child: ListTile(
//                   tileColor: Colors.white,
//                   leading: SvgPicture.asset('assets/svgs/Minus.svg'),
//                   title: const Text(
//                     'Gona Sent',
//                     style: TextStyle(
//                       color: redColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   subtitle: const Text(
//                     '25.443 Gona sent ',
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   trailing: const Text('Jan 25')),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
//               child: ListTile(
//                   tileColor: Colors.white,
//                   leading: SvgPicture.asset('assets/svgs/Arrow.svg'),
//                   title: const Text(
//                     'Gona Received',
//                     style: TextStyle(
//                       color: greenColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   subtitle: const Text(
//                     '30.0 Gona token recieved',
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   trailing: const Text('Jan 25')),
//             ),
//           ]))
//         ])));
//   }
// }
