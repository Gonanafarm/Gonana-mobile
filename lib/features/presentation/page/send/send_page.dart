import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/page/send/send_confirm_passcode.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../controllers/fiat_wallet/transaction_controller.dart';
import '../fiat_wallet/register_bank.dart';

class SendPage extends StatefulWidget {
  const SendPage({super.key});

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  final _sendCryptoKey = GlobalKey<FormState>();
  final TextEditingController _walletAddress = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  String get walletAddress => _walletAddress.text;
  String get amount => _amount.text;
  TransactionController transactionController =
      Get.put(TransactionController());

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
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Send Coin',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Form(
                  key: _sendCryptoKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: EnterFormText(
                            label: "Enter Wallet Address",
                            hint: "Your wallet address",
                            validator: inputValidator,
                            controller: _walletAddress),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: EnterFormText(
                            label: "Amount",
                            hint: "Enter amount to send in crypto ",
                            validator: inputValidator,
                            controller: _amount),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                    'Your balance: ETH ${transactionController.cryptoBalanceModel.cryptoWalletBalanceInEth ?? 0}',
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff292D32))),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         border: Border.all(
              //       color: greenColor,
              //       width: 1,
              //     )),
              //     child: const Text(
              //         'It would cost you 5 GNX to send tokens to another wallet',
              //         style: TextStyle(
              //             fontSize: 10,
              //             fontWeight: FontWeight.w400,
              //             color: Color(0xff292D32))),
              //   ),
              // ),
              const Spacer(),
              LongGradientButton(
                  title: "Send Now",
                  onPressed: () async {
                    bool isValidated = _sendCryptoKey.currentState!.validate();
                    if (isValidated) {
                      Get.to(() => SendCryptoPasscode(), arguments: {
                        "amount": amount,
                        "walletAddress": walletAddress,
                      });
                    }
                  })
            ],
          )),
    );
  }
}
