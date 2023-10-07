import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:gonana/consts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gonana/features/controllers/fiat_wallet/transaction_controller.dart';
import 'package:gonana/features/presentation/page/fiat_wallet/deposit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/user/user_controller.dart';
import '../../widgets/warning_widget.dart';
import 'fiat_withdrawal.dart';

class FiatWalletHome extends StatefulWidget {
  const FiatWalletHome({super.key});

  @override
  State<FiatWalletHome> createState() => _FiatWalletHomeState();
}

class _FiatWalletHomeState extends State<FiatWalletHome> {
  bool? BVNisSubmited = false;
  getBVNStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BVNisSubmited = prefs.getBool('bvnSubmission');
  }

  getBalance() async {
    await transactionController.fetchBalance();
    await transactionController.fetchTransactions();
  }

  @override
  void initState() {
    super.initState();
    getBalance();
    getBVNStatus();
  }

  TransactionController transactionController =
      Get.put(TransactionController());
  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF1F1F1),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff29844B), Color(0xff072C27)],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft)),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(top: 60.0, bottom: 10),
                          child: Text('Fiat Wallet',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400))),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                            'NGN ${transactionController.balanceModel?.balance ?? 0}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Center(
                              child: SizedBox(
                                  width: 180,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                                () => const FiatWithdrawal());
                                          },
                                          child: SizedBox(
                                            height: 50,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/svgs/withdrawal.svg',
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                            Colors.white,
                                                            BlendMode.srcIn),
                                                  ),
                                                  const Text(
                                                    'Withdraw',
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ]),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => const Deposit());
                                          },
                                          child: SizedBox(
                                            height: 50,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/svgs/money1.svg',
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                            Colors.white,
                                                            BlendMode.srcIn),
                                                  ),
                                                  const Text(
                                                    'Deposit',
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ]),
                                          ),
                                        )
                                      ]))))
                    ]),
              ),
            ),
            sizeVer(20),
            BVNisSubmited! ||
                    userController
                        .userModel.value.virtualAccountNumber!.isNotEmpty
                ? Container(height: 1)
                : WarningWidget(),
            sizeVer(20),
            (transactionController.transactionModel != null &&
                    transactionController.transactionModel!.transactions !=
                        null &&
                    transactionController
                        .transactionModel!.transactions!.isNotEmpty)
                ? Container(
                    // height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      itemCount: transactionController
                          .transactionModel!.transactions!.length,
                      itemBuilder: (context, index) {
                        // Build and return your transaction item widget here
                        return transactionController.transactionModel!
                                    .transactions![index].type ==
                                "DEBIT"
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                child: Container(
                                    height: 56,
                                    // width: 342,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/svgs/debit_icon.svg'),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    '${transactionController.transactionModel!.transactions![index].time}',
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xff5F5E5E)))
                                              ]),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text('Debit',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: redColor)),
                                                Text(
                                                    '₦ ${transactionController.transactionModel!.transactions![index].amountSettled}',
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black)),
                                              ])
                                        ])))
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                child: Container(
                                    height: 56,
                                    width: 342,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/svgs/credit_icon.svg'),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    '${transactionController.transactionModel!.transactions![index].time}',
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xff5F5E5E)))
                                              ]),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text('Debit',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: redColor)),
                                                Text(
                                                    '₦ ${transactionController.transactionModel!.transactions![index].amountSettled}',
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black)),
                                              ])
                                        ])));
                      },
                    ),
                  )
                :
                // Transactions are null or empty, display a message or placeholder content
                Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        sizeVer(MediaQuery.of(context).size.height * 0.05),
                        SvgPicture.asset(
                          "assets/svgs/empty_product.svg",
                          width: 189.71,
                          height: 156.03,
                        ),
                        const Text(
                          'Sorry! no transaction yet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        sizeVer(10),
                        const Text(
                          'All transactions would show here',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
            // CreditWidget(),
            // DebitWidget(),
            // CreditWidget(),
            // DebitWidget(),
            // CreditWidget(),
            // DebitWidget(),
          ],
        )));
  }
}

class DebitWidget extends StatefulWidget {
  const DebitWidget({
    super.key,
  });

  @override
  State<DebitWidget> createState() => _DebitWidgetState();
}

class _DebitWidgetState extends State<DebitWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Container(
            height: 56,
            width: 342,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset('assets/svgs/debit_icon.svg'),
                  const Column(children: [
                    Text('Sent to Jane Doe',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    Text('07:06 PM THU, Sep 14 2023',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5F5E5E)))
                  ]),
                  const Column(children: [
                    Text('Debit',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: redColor)),
                    Text('₦ 11,000',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                  ])
                ])));
  }
}

class CreditWidget extends StatefulWidget {
  const CreditWidget({
    super.key,
  });

  @override
  State<CreditWidget> createState() => _CreditWidgetState();
}

class _CreditWidgetState extends State<CreditWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Container(
            height: 56,
            width: 342,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset('assets/svgs/credit_icon.svg'),
                  const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('07:06 PM THU, Sep 14 2023',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff5F5E5E)))
                      ]),
                  const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Credit',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: greenColor)),
                        Text('₦ 11,000',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                      ])
                ])));
  }
}
