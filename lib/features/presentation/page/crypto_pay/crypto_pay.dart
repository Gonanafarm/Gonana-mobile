import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/crypto_pay/crypto_passcode.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../widgets/bottomsheets.dart';

class CryptoPay extends StatelessWidget {
  const CryptoPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              size: 20,
              color: Color(0xff292D32),
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Crypto Py\ay',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const Text('Feel in the details to pay with crypto'),
              const SizedBox(height: 42),
              const Text(
                '  From',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Color(0xff1E1E1E))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "Amount",
                            hintStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              child: const VerticalDivider(
                                color: Colors.black,
                                thickness: 2,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: SvgPicture.asset(
                                    "assets/svgs/gona_logo.svg")),
                            Text(
                              "Gona",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: IconButton(
                                onPressed: () {
                                  cryptoPayBottomSheet(context);
                                },
                                icon:
                                    const Icon(size: 40, Icons.arrow_drop_down),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Center(
                  child: LongGradientButton(
                      title: "Pay Now",
                      onPressed: () {
                        Get.to(() => CryptoPasscode());
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
