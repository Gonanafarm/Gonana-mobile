import "package:flutter/material.dart";
import 'package:gonana/consts.dart';
import 'package:flutter_svg/svg.dart';



class FiatWalletHome extends StatefulWidget {
  const FiatWalletHome({super.key});

  @override
  State<FiatWalletHome> createState() => _FiatWalletHomeState();
}

class _FiatWalletHomeState extends State<FiatWalletHome> {
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
              height: 300,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff29844B), Color(0xff072C27)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft
                )
              ),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 60.0, bottom: 10),
                      child: Text(
                        'Fiat Wallet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400
                        )
                      )
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text('NGN 50,000',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Center(
                        child: SizedBox(
                          width: 180,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){

                                },
                                child: SizedBox(
                                  height: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svgs/money1.svg',
                                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                      ),
                                      const Text(
                                        'Withdraw',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400
                                        ),
                                      )
                                    ]
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){

                                },
                                child: SizedBox(
                                  height: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svgs/money1.svg',
                                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                      ),
                                      const Text(
                                        'Withdraw',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400
                                        ),
                                      )
                                    ]
                                  ),
                                ),
                              )
                            ]
                          )
                        )
                      )
                    )
                  ]
                ),
              ),
            ),
            CreditWidget(),
            DebitWidget(),
            CreditWidget(),
            DebitWidget(),
            CreditWidget(),
            DebitWidget(),
          ],
        )
      )
    );
  }
}

class DebitWidget extends StatelessWidget {
  const DebitWidget({
    super.key,
  });

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
            const Column(
              children: [
                Text(
                  'Sent to Jane Doe',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                  )
                ),
                Text(
                  '07:06 PM THU, Sep 14 2023',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff5F5E5E)
                  )
                )
              ]
            ),
            const Column(
              children: [
                Text(
                  'Debit',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: redColor
                  )
                ),
                Text(
                  '₦ 11,000',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                  )
                ),
              ]
            )
          ]
        )
      )
    );
  }
}

class CreditWidget extends StatelessWidget {
  const CreditWidget({
    super.key,
  });

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
              children: [
                Text(
                  'Recieved from John Doe',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                  )
                ),
                Text(
                  '07:06 PM THU, Sep 14 2023',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff5F5E5E)
                  )
                )
              ]
            ),
            const Column(
              children: [
                Text(
                  'Credit',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: greenColor
                  )
                ),
                Text(
                  '₦ 11,000',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                  )
                ),
              ]
            )
          ]
        )
      )
    );
  }
}