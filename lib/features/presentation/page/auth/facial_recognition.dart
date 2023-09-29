// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:gonana/features/presentation/page/auth/number_verification_screen.dart';
// import '/features/presentation/widgets/widgets.dart';
// import 'package:camera/camera.dart';
//
// import 'auth_passcode.dart';
//
// class FacialRecognition extends StatefulWidget {
//   const FacialRecognition({super.key});
//
//   @override
//   State<FacialRecognition> createState() => _FacialRecognitionState();
// }
//
// class _FacialRecognitionState extends State<FacialRecognition> {
//   //List<CameraDescription> cameras = [];
//
//   // capture()async{
//   //   try{
//   //     WidgetsFlutterBinding.ensureInitialized();
//   //     cameras = await availableCameras();
//   //   } on CameraException catch (e) {
//   //     print('Error in fetching the camera: $e');
//   //   }
//   // }
//   // CameraController? controller;
//   // bool _isCameraInitialized = false;
//   // void onNewCameraSelected(CameraDescription cameraDescription)async{
//   //   final previousCameraController = controller;
//   //   //Instantiating the camera controller
//   //   final CameraController cameraController = CameraController(
//   //     cameraDescription,
//   //     ResolutionPreset.high,
//   //     imageFormatGroup: ImageFormatGroup.jpeg,
//   //   );
//   //   //
//   //   await previousCameraController?.dispose();
//
//   //   //Replace with new controller
//   //   if(mounted){
//   //     setState(() {
//   //       controller = cameraController;
//   //     });
//   //   }
//   // }
//   // //Update UI if  controller updated
//   // cameraController.addListener(() {
//   //     if (mounted) setState(() {});
//   // });
//   // //Initialize controller
//   // try{
//   //   await cameraController.initialize();
//   // } on CameraException catch(e){
//   //   print('Error initializing camera: $e');
//   // }
//   // // Update the Boolean
//   // if(mounted) {
//   //   setState(() {
//   //     _isCameraInitialized = controller!.value.isInitialized;
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color(0xffF1F1F1),
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {},
//               icon: const Icon(
//                 Icons.arrow_back,
//                 color: Colors.black,
//               )),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(8),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(
//                     child: Text('Make sure your in a well lit environment',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w400, fontSize: 14)),
//                   ),
//                   Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.6,
//                           height: MediaQuery.of(context).size.width * 0.7,
//                           child: Stack(
//                             alignment: AlignmentDirectional.center,
//                             children: [
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.all(16.0),
//                                         decoration: const BoxDecoration(
//                                           border: Border(
//                                             top: BorderSide(
//                                               color: Colors.black,
//                                               width: 1.0,
//                                             ),
//                                             left: BorderSide(
//                                               color: Colors.black,
//                                               width: 1.0,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: const EdgeInsets.all(16.0),
//                                         decoration: const BoxDecoration(
//                                           border: Border(
//                                             top: BorderSide(
//                                               color: Colors.black,
//                                               width: 1.0,
//                                             ),
//                                             right: BorderSide(
//                                               color: Colors.black,
//                                               width: 1.0,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.all(16.0),
//                                         decoration: const BoxDecoration(
//                                           border: Border(
//                                             bottom: BorderSide(
//                                               color: Colors.black,
//                                               width: 1.0,
//                                             ),
//                                             left: BorderSide(
//                                               color: Colors.black,
//                                               width: 1.0,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: const EdgeInsets.all(16.0),
//                                         decoration: const BoxDecoration(
//                                           border: Border(
//                                             bottom: BorderSide(
//                                               color: Colors.black,
//                                               width: 1.0,
//                                             ),
//                                             right: BorderSide(
//                                               color: Colors.black,
//                                               width: 1.0,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                               // SvgPicture.asset("assets/svgs/facial_capture.svg")
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         const Text("Move closer",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w600, fontSize: 32))
//                       ],
//                     ),
//                   ),
//                   LongGradientButton(
//                       title: 'Proceed',
//                       onPressed: () {
//                         Get.to(() => const SetPasscode());
//                       })
//                 ]),
//           ),
//         ));
//   }
// }
