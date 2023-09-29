import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/page/auth/auth_splash4.dart';
import 'package:gonana/features/presentation/page/auth/sign_in_page.dart';
import 'package:gonana/features/presentation/page/nextofkin/nextofkin.dart';
import 'package:gonana/features/presentation/page/referrals/referrals.dart';
import 'package:gonana/features/presentation/page/security/security.dart';
import 'package:gonana/features/presentation/page/settings/settiings_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bank_account/bank_account.dart';
import '../home.dart';
import '../verification/verification.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Settings',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                          child: ListTile(
                            tileColor: Colors.white,
                            leading: const Icon(Icons.person),
                            title: InkWell(
                              onTap: () {
                                Get.to(() => const SettingsProfile());
                              },
                              child: const Text(
                                'Profile',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            subtitle: const Text(
                              'Your details and the store dashboard',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                Get.to(() => const SettingsProfile());
                              },
                            ),
                            onTap: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                          child: ListTile(
                            tileColor: Colors.white,
                            leading: const Icon(Icons.verified),
                            title: const Text(
                              'Verification',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: const Text(
                              'Update your BVN for transaction verification',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                Get.to(() => const UserVerificationPage());
                              },
                            ),
                            onTap: () {
                              Get.to(() => const UserVerificationPage());
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                          child: ListTile(
                            leading: const Icon(Icons.security),
                            tileColor: Colors.white,
                            title: const Text(
                              'Security',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: const Text(
                              'Rest Password, 2FA Auth or Reset Pin',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                Get.to(() => const Security());
                              },
                            ),
                            onTap: () {
                              Get.to(() => const Security());
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                        //   child: ListTile(
                        //     leading: const Icon(Icons.account_balance),
                        //     tileColor: Colors.white,
                        //     title: const Text(
                        //       'Bank Account',
                        //       style: TextStyle(
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //     subtitle: const Text(
                        //       'Save your bank account and card details.',
                        //       style: TextStyle(
                        //         fontSize: 10,
                        //         fontWeight: FontWeight.w400,
                        //       ),
                        //     ),
                        //     trailing: IconButton(
                        //       icon: const Icon(Icons.arrow_forward_ios),
                        //       onPressed: () {
                        //         Get.to(() => const BankAccount());
                        //       },
                        //     ),
                        //     onTap: () {
                        //       Get.to(() => const BankAccount());
                        //     },
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                        //   child: ListTile(
                        //     leading: const Icon(Icons.people_alt_sharp),
                        //     tileColor: Colors.white,
                        //     title: const Text(
                        //       'Next of Kin',
                        //       style: TextStyle(
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //     subtitle: const Text(
                        //       'Add  your next of kin',
                        //       style: TextStyle(
                        //         fontSize: 10,
                        //         fontWeight: FontWeight.w400,
                        //       ),
                        //     ),
                        //     trailing: IconButton(
                        //       icon: const Icon(Icons.arrow_forward_ios),
                        //       onPressed: () {
                        //         Get.to(() => const NextOfKin());
                        //       },
                        //     ),
                        //     onTap: () {
                        //       Get.to(() => const NextOfKin());
                        //     },
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                        //   child: ListTile(
                        //     leading: const Icon(Icons.group),
                        //     tileColor: Colors.white,
                        //     title: const Text(
                        //       'Referrals',
                        //       style: TextStyle(
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //     subtitle: const Text(
                        //       'Refer your friends and earn',
                        //       style: TextStyle(
                        //         fontSize: 10,
                        //         fontWeight: FontWeight.w400,
                        //       ),
                        //     ),
                        //     trailing: IconButton(
                        //       icon: const Icon(Icons.arrow_forward_ios),
                        //       onPressed: () {
                        //         Get.to(() => const Referrals());
                        //       },
                        //     ),
                        //     onTap: () {
                        //       Get.to(() => const Referrals());
                        //     },
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                        //   child: ListTile(
                        //     leading: const Icon(Icons.notifications),
                        //     tileColor: Colors.white,
                        //     title: const Text(
                        //       'Notification',
                        //       style: TextStyle(
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //     subtitle: const Text(
                        //       'Set your notification preference',
                        //       style: TextStyle(
                        //         fontSize: 10,
                        //         fontWeight: FontWeight.w400,
                        //       ),
                        //     ),
                        //     trailing: IconButton(
                        //       icon: const Icon(Icons.arrow_forward_ios),
                        //       onPressed: () {},
                        //     ),
                        //     onTap: () {},
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                        //   child: ListTile(
                        //     leading: const Icon(Icons.border_color),
                        //     tileColor: Colors.white,
                        //     title: const Text(
                        //       'Legal Information',
                        //       style: TextStyle(
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //     subtitle: const Text(
                        //       'Contract between you and Gonana',
                        //       style: TextStyle(
                        //         fontSize: 10,
                        //         fontWeight: FontWeight.w400,
                        //       ),
                        //     ),
                        //     trailing: IconButton(
                        //       icon: const Icon(Icons.arrow_forward_ios),
                        //       onPressed: () {},
                        //     ),
                        //     onTap: () {},
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 46,
                width: 243,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: const LinearGradient(
                        colors: [Color(0xffED7575), Color(0xffCD042D)])),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                  child: const Text('Logout'),
                  onPressed: () async {
                    Get.to(() => const Splash4());
                    bool cleared = false;
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    cleared = await preferences.clear();
                    if (cleared) {
                      print("cleared");
                    }
                  },
                ),
              ),
            ),
            sizeVer(10)
          ],
        ),
      ),
    );
  }
}
