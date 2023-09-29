import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/settings/settings.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

class EditNok extends StatelessWidget {
  const EditNok({super.key});

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
                  Navigator.pop(context);
                })),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
            child: Column(
              children: [
                const SizedBox(
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Next of Kin',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'These are details of your Next of Kin',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.left,
                          ),
                        ])),
                SizedBox(height: 20),
                Container(
                    // height: 251,
                    // width: 342,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.0, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Name',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                Text('John Doe',
                                    style: TextStyle(
                                        color: Color(0xff292D32),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Phone Number',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                Text('+234 99887778747',
                                    style: TextStyle(
                                        color: Color(0xff292D32),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Address',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                Text('No. 14 keana road...',
                                    style: TextStyle(
                                        color: Color(0xff292D32),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Date of birth',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                Text('August, 12',
                                    style: TextStyle(
                                        color: Color(0xff292D32),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Relationship',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                Text('Brother',
                                    style: TextStyle(
                                        color: Color(0xff292D32),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                const Spacer(),
                LongGradientButton(
                    title: 'Edit',
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // Set to true if you want to allow dismissing the dialog by tapping outside it
                        builder: (BuildContext context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 20,
                                sigmaY:
                                    20), // Adjust the blur intensity as needed
                            child: Container(
                              height: 100,
                              child: AlertDialog(
                                title: Center(
                                  child: Icon(
                                    size: 60,
                                    Icons.check_circle_outlined,
                                  ),
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child:
                                      Text('Next of kin edited successfully'),
                                ),
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: DialogGradientButton(
                                      title: 'Proceed',
                                      onPressed: () {
                                        Get.to(() => Settings());
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
