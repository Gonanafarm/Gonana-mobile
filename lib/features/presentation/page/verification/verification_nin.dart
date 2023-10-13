import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

class VerificationNin extends StatelessWidget {
  VerificationNin({super.key});

  final TextEditingController _nin = TextEditingController();
  String get nin => _nin.text;

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
                          Text(
                            'NIN',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'Enter These details',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: SizedBox(
                                child: EnterText(
                                    controller: _nin,
                                    label: 'NIN Number',
                                    hint: 'Enter you NIN Number here')),
                          )
                        ],
                      ),
                    ),
                    LongGradientButton(
                        title: 'Proceed',
                        onPressed: () {
                          Get.back();
                        })
                  ])),
        ));
  }
}
