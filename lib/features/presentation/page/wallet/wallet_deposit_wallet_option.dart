import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/page/wallet/wallet_deposit_wallet_p2p.dart';

class WalletOptions extends StatefulWidget {
  const WalletOptions({super.key});

  @override
  State<WalletOptions> createState() => _WalletOptionsState();
}

class _WalletOptionsState extends State<WalletOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF1F1F1),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Color(0xff292D32),
                ))),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  // height: 55,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wallet Option',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Select the wallet you\'d prefare to perform your\npeer-to-peer payment.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                      color: primaryColor,
                      child: ListTile(
                        onTap: () {
                          Get.to(() => WalletP2P());
                        },
                        leading: Image.asset('assets/images/kuda.png'),
                        title: const Text(
                          'Kuda',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        trailing: const SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Operating',
                                style: TextStyle(
                                    color: greenColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                      color: primaryColor,
                      child: ListTile(
                        leading: Image.asset('assets/images/barter.png'),
                        title: const Text(
                          'Barter',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                      color: primaryColor,
                      child: ListTile(
                        leading: Image.asset('assets/images/changera.png'),
                        title: const Text(
                          'Changera',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                      color: primaryColor,
                      child: ListTile(
                        leading: Image.asset('assets/images/pocket_app.png'),
                        title: const Text(
                          'Kuda',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
