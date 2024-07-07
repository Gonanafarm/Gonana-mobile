import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/page/home.dart';
import 'package:gonana/features/presentation/page/verification/verification_bvn.dart';
import 'package:gonana/features/presentation/page/verification/verification_drivers_license.dart';
import 'package:gonana/features/presentation/page/verification/verification_international_passport.dart';
import 'package:gonana/features/presentation/page/verification/verification_kyc.dart';
import 'package:gonana/features/presentation/page/verification/verification_nin.dart';
import 'package:gonana/features/presentation/page/verification/verification_voters_card.dart';

import '../settings/settings.dart';

class UserVerificationPage extends StatelessWidget {
  const UserVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF1F1F1),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Get.to(() => HomePage(navIndex: 3));
                })),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verification',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Verify yourself to be able to enjoy the best of Gonana .',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.left,
                      ),
                      // Text(
                      //   'Ensure you verify your KYC before your BVN',
                      //   style: TextStyle(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w400,
                      //       color: redColor),
                      //   textAlign: TextAlign.left,
                      // ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 342,
                    height: 380,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Padding(
                          //     padding: const EdgeInsets.all(8),
                          //     child: GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     VerificationNin()));
                          //       },
                          //       child: Container(
                          //           width: 342,
                          //           height: 56,
                          //           color: Colors.white,
                          //           child: const Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 Padding(
                          //                   padding:
                          //                       EdgeInsets.only(left: 15.0),
                          //                   child: Text('NIN',
                          //                       style: TextStyle(
                          //                           fontSize: 14,
                          //                           fontWeight: FontWeight.w600,
                          //                           color: Colors.black)),
                          //                 ),
                          //                 Padding(
                          //                   padding:
                          //                       EdgeInsets.only(right: 15.0),
                          //                   child:
                          //                       Icon(Icons.arrow_forward_ios),
                          //                 )
                          //               ])),
                          //     )),
                          // Padding(
                          //     padding: const EdgeInsets.all(8),
                          //     child: GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     const IntPassport()));
                          //       },
                          //       child: Container(
                          //           width: 342,
                          //           height: 56,
                          //           color: Colors.white,
                          //           child: const Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 Padding(
                          //                   padding:
                          //                       EdgeInsets.only(left: 15.0),
                          //                   child: Text(
                          //                       'International Passport',
                          //                       style: TextStyle(
                          //                           fontSize: 14,
                          //                           fontWeight: FontWeight.w600,
                          //                           color: Colors.black)),
                          //                 ),
                          //                 Padding(
                          //                   padding:
                          //                       EdgeInsets.only(right: 15.0),
                          //                   child:
                          //                       Icon(Icons.arrow_forward_ios),
                          //                 )
                          //               ])),
                          //     )),
                          // Padding(
                          //     padding: const EdgeInsets.all(8),
                          //     child: GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     const VerificationVotersCard()));
                          //       },
                          //       child: Container(
                          //           width: 342,
                          //           height: 56,
                          //           color: Colors.white,
                          //           child: const Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 Padding(
                          //                   padding:
                          //                       EdgeInsets.only(left: 15.0),
                          //                   child: Text('Voters Card (VIN)',
                          //                       style: TextStyle(
                          //                           fontSize: 14,
                          //                           fontWeight: FontWeight.w600,
                          //                           color: Colors.black)),
                          //                 ),
                          //                 Padding(
                          //                   padding:
                          //                       EdgeInsets.only(right: 15.0),
                          //                   child:
                          //                       Icon(Icons.arrow_forward_ios),
                          //                 )
                          //               ])),
                          //     )),
                          // Padding(
                          //     padding: const EdgeInsets.all(8),
                          //     child: GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     const VerificationDriversLicense()));
                          //       },
                          //       child: Container(
                          //           width: 342,
                          //           height: 56,
                          //           color: Colors.white,
                          //           child: const Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 Padding(
                          //                   padding:
                          //                       EdgeInsets.only(left: 15.0),
                          //                   child: Text('Drivers LIscense',
                          //                       style: TextStyle(
                          //                           fontSize: 14,
                          //                           fontWeight: FontWeight.w600,
                          //                           color: Colors.black)),
                          //                 ),
                          //                 Padding(
                          //                   padding:
                          //                       EdgeInsets.only(right: 15.0),
                          //                   child:
                          //                       Icon(Icons.arrow_forward_ios),
                          //                 )
                          //               ])),
                          //     )),
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              KYCVerification()));
                                },
                                child: Container(
                                    width: 342,
                                    height: 56,
                                    color: Colors.white,
                                    child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 15.0),
                                            child: Text('KYC',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black)),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 15.0),
                                            child:
                                                Icon(Icons.arrow_forward_ios),
                                          )
                                        ])),
                              )),
                          // Padding(
                          //     padding: const EdgeInsets.all(8),
                          //     child: GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     VerificationBvn()));
                          //       },
                          //       child: Container(
                          //           width: 342,
                          //           height: 56,
                          //           color: Colors.white,
                          //           child: const Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 Padding(
                          //                   padding:
                          //                       EdgeInsets.only(left: 15.0),
                          //                   child: Text('BVN',
                          //                       style: TextStyle(
                          //                           fontSize: 14,
                          //                           fontWeight: FontWeight.w600,
                          //                           color: Colors.black)),
                          //                 ),
                          //                 Padding(
                          //                   padding:
                          //                       EdgeInsets.only(right: 15.0),
                          //                   child:
                          //                       Icon(Icons.arrow_forward_ios),
                          //                 )
                          //               ])),
                          //     ))
                        ])),
              ),
            ]),
          ),
        ));
  }
}
