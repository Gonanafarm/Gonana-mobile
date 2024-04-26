import 'dart:ui';

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

import '../../../controllers/post/post_controllers.dart';
import '../../../controllers/user/user_controller.dart';
import '../../widgets/widgets.dart';
import '../bank_account/bank_account.dart';
import '../home.dart';
import '../verification/verification.dart';
import '../store/store_add_poduct.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  PostController postController = Get.put(PostController());
  UserController userController = Get.put(UserController());
  bool? BVNisSubmited = false;

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
                              onPressed: () async {
                                Get.to(() => const SettingsProfile());
                                // bool created = false;
                                // created = await postController.getPostsById(
                                //     userController.userModel.value.id, "post");
                                // print(userController.userModel.value.id);
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            //   child: Container(
            //     height: 46,
            //     width: 243,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(5),
            //         gradient: const LinearGradient(
            //             colors: [Color(0xff29844B), Color(0xff072C27)])),
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.transparent,
            //           elevation: 0,
            //           shadowColor: Colors.transparent,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(5.0),
            //           )),
            //       child: const Text('Add product '),
            //       onPressed: () async {
            //         SharedPreferences prefs =
            //             await SharedPreferences.getInstance();
            //         BVNisSubmited = prefs.getBool('bvnSubmission');
            //         if (userController
            //                 .userModel.value.virtualAccountNumber!.isNotEmpty ||
            //             userController.userModel.value.virtualAccountNumber !=
            //                 null) {
            //           Get.to(() => AddProduct());
            //         } else if ((userController.userModel.value
            //                     .virtualAccountNumber!.isNotEmpty ||
            //                 userController
            //                         .userModel.value.virtualAccountNumber ==
            //                     null) &&
            //             BVNisSubmited!) {
            //           ErrorSnackbar.show(
            //               context, "Your BVN is awaiting verification");
            //         } else if ((userController.userModel.value
            //                     .virtualAccountNumber!.isNotEmpty ||
            //                 userController
            //                         .userModel.value.virtualAccountNumber ==
            //                     null) &&
            //             BVNisSubmited!) {
            //           ErrorSnackbar.show(context,
            //               "Please kindly go to verifications and submit your BVN for verification to create your virtual account ");
            //         }
            //       },
            //     ),
            //   ),
            // ),
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
                    successDialog(context);
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

Future<dynamic> successDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible:
        true, // Set to true if you want to allow dismissing the dialog by tapping outside it
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 20, sigmaY: 20), // Adjust the blur intensity as needed
        child: Container(
          height: 100,
          child: AlertDialog(
            title: const Center(
              child: Icon(
                size: 60,
                Icons.check_circle_outlined,
              ),
            ),
            content: Padding(
              padding: EdgeInsets.only(left: 0.0),
              child: Container(
                height: 50,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Are you sure you logout',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Center(
                child: DialogGradientButton(
                  title: 'Yes, I want to logout',
                  onPressed: () async {
                    bool cleared = false;
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    cleared = await preferences.remove("token");
                    if (cleared) {
                      print("cleared");
                      Navigator.pop(context);
                      Get.offAll(() => const Splash4());
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 20),
                child: Center(
                  child: DialogWhiteButton(
                    title: 'No, go back',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
