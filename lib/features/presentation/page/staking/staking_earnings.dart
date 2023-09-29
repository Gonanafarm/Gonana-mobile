import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/staking/staking_duration.dart';
import 'package:gonana/features/presentation/page/staking/staking_splash.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

class StakingEarnings extends StatelessWidget {
  const StakingEarnings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Get.to(() => StakingSplashScreen());
            },
            child: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Earnings',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              const Text('start earning from your crypto tokens by staking'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xff29844B), Color(0xff072C27)])),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      child: Column(children: [
                        const Text(
                          'Your Earnings',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                        const Text(
                          '15 Gona',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff072C27),
                                // fixedSize: const Size(142, 38),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            onPressed: () {},
                            icon: const Icon(Icons.north_west),
                            label: const Text(
                              'Transfer Earnings',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.white),
                            ))
                      ]),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Center(
                  child: LongGradientButton(
                      title: 'Start Earning',
                      onPressed: () {
                        Get.to(() => StakingDuration());
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
