import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/staking/stake.dart';

class StakingPool extends StatefulWidget {
  const StakingPool({Key? key}) : super(key: key);

  @override
  State<StakingPool> createState() => _StakingPoolState();
}

class _StakingPoolState extends State<StakingPool> {
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Pool',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600)),
                    Text('select the coin you would like to stake')
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.to(() => Stake());
                },
                child: PoolContainers(
                  firstName: 'Gona',
                  firstLogo: 'gona_logo',
                  secondName: 'CCD',
                  secondLogo: 'ccd_logo',
                ),
              ),
              PoolContainers(
                firstName: 'CCD',
                firstLogo: 'ccd_logo',
                secondName: 'USDC',
                secondLogo: 'usdc_logo',
              ),
              PoolContainers(
                firstName: 'Gona',
                firstLogo: 'gona_logo',
                secondName: 'USDT',
                secondLogo: 'usdt_logo',
              ),
              PoolContainers(
                firstName: 'Gona',
                firstLogo: 'gona_logo',
                secondName: 'USDC',
                secondLogo: 'usdc_logo',
              ),
              PoolContainers(
                firstName: 'CCD',
                firstLogo: 'ccd_logo',
                secondName: 'USDT',
                secondLogo: 'usdt_logo',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PoolContainers extends StatelessWidget {
  final String firstName;
  final String firstLogo;
  final String secondName;
  final String secondLogo;
  const PoolContainers(
      {Key? key,
      required this.firstName,
      required this.firstLogo,
      required this.secondName,
      required this.secondLogo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 20),
      child: Container(
        color: Color(0xffFFFFFF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Stack(
                      // alignment: Alignment.centerRight,
                      children: [
                        SvgPicture.asset("assets/svgs/$firstLogo.svg"),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Align(
                              child: SvgPicture.asset(
                                  "assets/svgs/$secondLogo.svg")),
                        ),
                      ],
                    )),
                Text(
                  '$firstName/$secondName',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
