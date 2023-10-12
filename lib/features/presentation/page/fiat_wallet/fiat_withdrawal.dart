import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:gonana/consts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gonana/features/presentation/page/fiat_wallet/register_bank.dart';
import 'package:gonana/features/presentation/page/fiat_wallet/send_to_users.dart';

class FiatWithdrawal extends StatefulWidget {
  const FiatWithdrawal({super.key});

  @override
  State<FiatWithdrawal> createState() => _FiatWithdrawalState();
}

class _FiatWithdrawalState extends State<FiatWithdrawal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF1F1F1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
                width: double.infinity,
                child: Text('Withdrawal',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black))),
            const SizedBox(
                width: double.infinity,
                child: Text('Select your mode of withdrawal',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black))),
            sizeVer(30),
            InkWell(
              onTap: () {
                Get.to(() => const SendToUsers());
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/svgs/send_user.svg'),
                            sizeHor(20),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Gonana User',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    )),
                                Text('Send to a Gonana user',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ))
                              ]),
                          ],
                        ),
                        const Icon(Icons.arrow_forward_ios)
                      ]),
                ),
              ),
            ),
            sizeVer(20),
            InkWell(
              onTap: () {
                Get.to(() => const RegisterBank());
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/svgs/Buildings.svg'),
                            sizeHor(20),
                            const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Withdraw to bank',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Text('Withdraw to your commercial bank',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      
                                    ))
                                ]
                              ),
                          ],
                        ),
                        const Icon(Icons.arrow_forward_ios)
                      ]
                    ),
                ),
              ),
            ),
          ]
        ),
      )
    )
  );
  }
}
