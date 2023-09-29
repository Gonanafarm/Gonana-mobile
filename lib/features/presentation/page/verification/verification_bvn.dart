import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../../consts.dart';

class VerificationBvn extends StatelessWidget {
  VerificationBvn({super.key});

  final TextEditingController _bvn = TextEditingController();
  String get bvn => _bvn.text;
  final _bvnKey = GlobalKey<FormState>();
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
              padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'BVN',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                          const Text(
                            'Enter These details',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.left,
                          ),
                          Form(
                            key: _bvnKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 8.0),
                              child: SizedBox(
                                child: EnterFormText(
                                    controller: _bvn,
                                    validator: bvnValidator,
                                    label: 'BVN',
                                    hint:
                                        'Enter your Bank Verification Number'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Dial the USSD code *565*0# to check your BVN',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                    LongGradientButton(
                        title: 'Proceed',
                        onPressed: () {
                          bool isValid = _bvnKey.currentState!.validate();
                          Get.back();
                        })
                  ])),
        ));
  }
}
