import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/page/wallet/wallet_withdrawal_p2p_confirm.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

// Adds the Bank Widget for the confirmation Screen

class WithdrawalWalletDetails extends StatefulWidget {
  const WithdrawalWalletDetails({super.key});

  @override
  State<WithdrawalWalletDetails> createState() =>
      _WithdrawalWalletDetailsState();
}

class _WithdrawalWalletDetailsState extends State<WithdrawalWalletDetails> {
  final TextEditingController _userName = TextEditingController();

  final TextEditingController _amount = TextEditingController();

  String get userName => _userName.text;

  String get amount => _amount.text;

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Withdraawal',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Enter your wallet details to withdraw.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      EnterText(
                          controller: _userName,
                          label: 'User name',
                          hint: 'User name'),
                      sizeVer(10),
                      EnterText(
                          controller: _amount,
                          label: 'Amount',
                          hint: 'Enter the amount'),
                      const Spacer(),
                      LongGradientButton(
                          title: 'Confirm User  ',
                          onPressed: () {
                            Get.to(() => P2PWithdrawalConfirm());
                          }),
                    ]))));
  }
}
