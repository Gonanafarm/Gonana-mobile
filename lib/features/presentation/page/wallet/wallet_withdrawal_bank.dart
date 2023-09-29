import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/page/wallet/wallet_withdrawal_bank_confirm.dart';
import 'package:gonana/features/presentation/page/wallet/wallet_withdrawal_wallet_details.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

// Adds the Bank Widget for the confirmation Screen

class WithdrawalBankAdd extends StatefulWidget {
  const WithdrawalBankAdd({super.key});

  @override
  State<WithdrawalBankAdd> createState() => _WithdrawalBankAddState();
}

class _WithdrawalBankAddState extends State<WithdrawalBankAdd> {
  final TextEditingController _bankName = TextEditingController();

  final TextEditingController _accountNumber = TextEditingController();

  String get bankName => _bankName.text;

  String get accountNumber => _accountNumber.text;

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
                              'Enter your bank details you want to withdraw to.',
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
                          controller: _bankName,
                          label: 'Bank name',
                          hint: 'Bank name'),
                      sizeVer(10),
                      EnterText(
                          controller: _accountNumber,
                          label: 'Account Number',
                          hint: '12345678'),
                      const Spacer(),
                      LongGradientButton(
                          title: 'Confirm User',
                          onPressed: () {
                            Get.to(() => WalletWithdrawalBankConfirmation());
                          }),
                    ]))));
  }
}
