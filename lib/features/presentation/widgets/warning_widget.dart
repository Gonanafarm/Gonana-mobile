import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/fiat_wallet/transaction_controller.dart';
import 'package:gonana/features/controllers/user/user_controller.dart';
import 'package:gonana/features/data/models/VirtualAccountModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../consts.dart';
import '../page/verification/verification.dart';

class WarningWidget extends StatefulWidget {
  const WarningWidget({Key? key}) : super(key: key);

  @override
  State<WarningWidget> createState() => _WarningWidgetState();
}

class _WarningWidgetState extends State<WarningWidget> {
  final UserController userController = Get.find<UserController>();
  // final transactionController = Get.find<TransactionController>();

  @override
  void initState() {
    super.initState();
    getBVNStatus();
  }

  bool? BVNisSubmited = false;
  getBVNStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BVNisSubmited = prefs.getBool('bvnSubmission');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Get.to(() => const UserVerificationPage());
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 90,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.99, -0.11),
              end: Alignment(-0.99, 0.11),
              colors: [Colors.white, Color(0xFFFFBCC9)],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/svgs/danger.svg"),
                sizeHor(0),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Tap to Verify your identity',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w600,
                          height: 0.13,
                        ),
                      ),
                      sizeVer(10),
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Text(
                          textAlign: TextAlign.start,
                          'Verify your account quickly and start enjoying the services available on the gonana app.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
