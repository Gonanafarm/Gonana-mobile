import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/controllers/fiat_wallet/transaction_controller.dart';
import 'package:gonana/features/presentation/page/home.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../consts.dart';

class VerificationBvn extends StatefulWidget {
  VerificationBvn({super.key});

  @override
  State<VerificationBvn> createState() => _VerificationBvnState();
}

class _VerificationBvnState extends State<VerificationBvn> {
  final TextEditingController _bvn = TextEditingController();

  String get bvn => _bvn.text;

  final _bvnKey = GlobalKey<FormState>();

  TransactionController transactionController =
      Get.put(TransactionController());

  bool isLoading = false;

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
                            'Verify yourself to be able to enjoy the best of Gonana',
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
                        isLoading: isLoading,
                        title: 'Proceed',
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          bool isValid = _bvnKey.currentState!.validate();
                          if (isValid) {
                            bool created = await transactionController
                                .verifyBVN(_bvn.text, context);
                            if (created) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('bvnSubmission', true);
                              Get.to(() => HomePage(navIndex: 3));
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        })
                  ])),
        ));
  }
}
