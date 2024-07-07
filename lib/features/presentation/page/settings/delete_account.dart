import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/page/savings/passcode.dart';
import 'package:gonana/features/presentation/page/settings/delete_passcode.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

enum DeleteOptions {
  anotherAccount,
  irrelevantProduct,
  transactionIssue,
  logisticsIssue,
  otherIssues
}

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  DeleteOptions? _character = DeleteOptions.anotherAccount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back, color: Colors.black))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Delete account',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600)),
                        SizedBox(height: 10),
                        const Text(
                            'Note: If you delete you can never recover your virtual account, hence, withdraw all your money',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: redColor)),
                        ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: -4.0),
                          title: Text('I created another account on Gonana'),
                          leading: Radio<DeleteOptions>(
                            activeColor: Colors.black,
                            value: DeleteOptions.anotherAccount,
                            groupValue: _character,
                            onChanged: (DeleteOptions? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: -4.0),
                          title:
                              const Text('I do not need this product anymore'),
                          leading: Radio<DeleteOptions>(
                            activeColor: Colors.black,
                            value: DeleteOptions.irrelevantProduct,
                            groupValue: _character,
                            onChanged: (DeleteOptions? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: -4.0),
                          title: const Text('Transaction issues'),
                          leading: Radio<DeleteOptions>(
                            activeColor: Colors.black,
                            value: DeleteOptions.transactionIssue,
                            groupValue: _character,
                            onChanged: (DeleteOptions? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: -4.0),
                          title: const Text('Logistics issues'),
                          leading: Radio<DeleteOptions>(
                            activeColor: Colors.black,
                            value: DeleteOptions.logisticsIssue,
                            groupValue: _character,
                            onChanged: (DeleteOptions? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: -4.0),
                          title: const Text('Other issues'),
                          leading: Radio<DeleteOptions>(
                            activeColor: Colors.black,
                            value: DeleteOptions.otherIssues,
                            groupValue: _character,
                            onChanged: (DeleteOptions? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LongGradientButton(
                  title: "Proceed",
                  onPressed: () {
                    Get.to(() => DeletePassoce());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
