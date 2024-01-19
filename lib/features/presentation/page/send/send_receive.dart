import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gonana/consts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../controllers/user/user_controller.dart';

class SendReceiveQR extends StatefulWidget {
  const SendReceiveQR({super.key});

  @override
  State<SendReceiveQR> createState() => _SendReceiveQRState();
}

class _SendReceiveQRState extends State<SendReceiveQR> {
  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back,
                    size: 20, color: Color(0xff292D32)))),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Receive Gona',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  // width: MediaQuery.of(context).size.width * 0.8,
                  child: QrImageView(
                    data: '${userController.userModel.value.walletAddress}',
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 74,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              '${userController.userModel.value.walletAddress}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          sizeHor(10),
                          GestureDetector(
                              onTap: () {
                                String textToCopy =
                                    "${userController.userModel.value.walletAddress}";
                                Clipboard.setData(
                                    ClipboardData(text: textToCopy));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Wallet address copied to clipboard"),
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                  'assets/svgs/content_edit.svg'))
                        ],
                      ),
                    )),
              ),
              // const Text(
              //   'Minimum receivable: 20GNX',
              //   style: TextStyle(
              //     fontSize: 10,
              //     fontWeight: FontWeight.w400,
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: redColor,
                    width: 1,
                  )),
                  child: const Text(
                      'Warning !!!\n please send only eth to this address, sending any other\n token to this address would result in permanent loss',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff292D32))),
                ),
              ),
            ],
          ),
        ));
  }
}
