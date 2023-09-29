// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import '/features/presentation/widgets/widgets.dart';
// import 'facial_recognition.dart';
//
// class FacialCapture extends StatelessWidget {
//   const FacialCapture({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF1F1F1),
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             )),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const SizedBox(
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Facial Confirmation',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w600, fontSize: 24),
//                         ),
//                         Text(
//                             'Take a selfie so that we can confirm your identity')
//                       ]),
//                 ),
//                 Center(
//                   child: SvgPicture.asset("assets/svgs/facial_capture.svg"),
//                 ),
//                 LongGradientButton(title: 'Proceed', onPressed: () {
//                   Get.to(()=> const FacialRecognition());
//                 })
//               ]),
//         ),
//       ),
//     );
//   }
// }
