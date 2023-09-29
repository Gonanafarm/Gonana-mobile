// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '/features/presentation/widgets/widgets.dart';
// import '/features/presentation/widgets/progressbar.dart';
// import 'facial_capture.dart';
//
// class SetPassword extends StatefulWidget {
//   const SetPassword({super.key});
//
//   @override
//   State<SetPassword> createState() => _SetPasswordState();
// }
//
// class _SetPasswordState extends State<SetPassword> {
//   List<String> str = [
//     "At least one lowercase letter",
//     "At least one uppercase letter",
//     "At least one number",
//     "At least 8 charecters long"
//   ];
//   bool visibility1 = false;
//   bool visibility2 = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF1F1F1),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back,
//               size: 20,
//               color: Colors.black,
//             )),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             children: [
//               Expanded(
//                 child: ListView(
//                   children: [
//                     SizedBox(
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const [
//                             Text(
//                               'Password',
//                               style: TextStyle(
//                                   fontSize: 24, fontWeight: FontWeight.w600),
//                             ),
//                             Text('Fill in these details')
//                           ]),
//                     ),
//                     const SizedBox(height: 15),
//                     Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text('Password'),
//                             TextField(
//                               obscureText: visibility1,
//                               decoration: InputDecoration(
//                                   suffixIcon: IconButton(
//                                     onPressed: () {
//                                       visibility1 == true
//                                           ? setState(() {
//                                               visibility1 = false;
//                                             })
//                                           : setState(() {
//                                               visibility1 = true;
//                                             });
//                                     },
//                                     icon: visibility1 == true
//                                         ? Icon(
//                                             Icons.visibility_outlined,
//                                           )
//                                         : Icon(
//                                             Icons.visibility_off_outlined,
//                                           ),
//                                   ),
//                                   border: OutlineInputBorder(),
//                                   hintText: 'Enter your password'),
//                             ),
//                           ],
//                         )),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         children: str.map((textList) {
//                           return Row(children: [
//                             const Text(
//                               "\u2022",
//                               style: TextStyle(fontSize: 14),
//                             ), //bullet text
//                             const SizedBox(
//                               width: 10,
//                             ), //space between bullet and text
//                             Expanded(
//                               child: Text(
//                                 textList,
//                                 style: const TextStyle(fontSize: 14),
//                               ), //text
//                             )
//                           ]);
//                         }).toList(),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text('Confirm password'),
//                           TextField(
//                             obscureText: visibility2,
//                             decoration: InputDecoration(
//                                 suffixIcon: IconButton(
//                                   onPressed: () {
//                                     visibility2 == true
//                                         ? setState(() {
//                                             visibility2 = false;
//                                           })
//                                         : setState(() {
//                                             visibility2 = true;
//                                           });
//                                   },
//                                   icon: visibility2 == true
//                                       ? Icon(
//                                           Icons.visibility_outlined,
//                                         )
//                                       : Icon(
//                                           Icons.visibility_off_outlined,
//                                         ),
//                                 ),
//                                 border: OutlineInputBorder(),
//                                 hintText: 'Confirm password'),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // const Spacer(),
//                   ],
//                 ),
//               ),
//               Align(
//                 alignment: AlignmentDirectional.bottomCenter,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: LongGradientButton(
//                     title: 'Finish',
//                     onPressed: () {
//                       Get.to(()=>const FacialCapture());
//                     }
//                   ),
//                 ),
//                 // const ProgressIndicatorBar(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// //  const Text("\u2022", style: TextStyle(fontSize: 30),),
// //               const SizedBox(width: 10,),
// //               Expanded(
// //                 child:Text(strone, style: TextStyle(fontSize: 30),), //text
// //               ),
