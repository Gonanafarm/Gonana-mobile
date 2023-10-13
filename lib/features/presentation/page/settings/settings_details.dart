import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/settings/delete_account.dart';

import '../../../controllers/user/user_controller.dart';

class MyDetails extends StatefulWidget {
  const MyDetails({
    super.key,
  });

  @override
  State<MyDetails> createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
  UserController userController = Get.put(UserController());
  @override
  void initState() {
    getUserDetails();
    // print("name: ${userController.userModel.value.user!.firstName}");
    // _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  void getUserDetails() async {
    await userController.fetchUserByEmail();
    print("User details gotten");
  }

  String email = "";
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    if (userController.userModel.value != null &&
        userController.userModel.value != null &&
        userController.userModel.value.email != null &&
        userController.userModel.value.email!.isNotEmpty) {
      email = userController.userModel.value.email ?? '';
      firstName = userController.userModel.value.firstName ?? '';
      lastName = userController.userModel.value.lastName ?? '';
      phoneNumber = userController.userModel.value.phone ?? '';
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Container(
            // height: 302,
            // width: 342,
            color: const Color(0xffFFFFFF),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              // SizedBox(height: 20),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              //   SizedBox(
              //     width: 174,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: const [
              //         Text('Currency',
              //             style: TextStyle(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w600,
              //                 color: Color(0xff292D32))),
              //         Text('NGN(Nigerian Naira)',
              //             style: TextStyle(
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w400,
              //                 color: Color(0xff292D32)))
              //       ],
              //     ),
              //   ),
              //   IconButton(
              //       onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
              // ]),
              SizedBox(height: 20),
              SizedBox(
                // width: 174,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Flexible(
                      flex: 1,
                      child: Text('Email Address',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff292D32))),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(email,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff292D32))),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                // width: 174,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Flexible(
                      flex: 1,
                      child: Text('LastName',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff292D32))),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(lastName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff292D32))),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                // width: 174,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Flexible(
                      flex: 1,
                      child: Text('First name',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff292D32))),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(firstName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff292D32))),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                // width: 174,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Flexible(
                      flex: 1,
                      child: Text('Phone number',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff292D32))),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(phoneNumber,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff292D32))),
                    )
                  ],
                ),
              ),
              // SizedBox(height: 20),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              //   SizedBox(
              //     width: 174,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: const [
              //         Text('Gender',
              //             style: TextStyle(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w600,
              //                 color: Color(0xff292D32))),
              //         Text('Male',
              //             style: TextStyle(
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w400,
              //                 color: Color(0xff292D32)))
              //       ],
              //     ),
              //   ),
              //   IconButton(
              //       onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
              // ]),
              // SizedBox(height: 20),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              //   SizedBox(
              //     width: 174,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: const [
              //         Text('Birthday',
              //             style: TextStyle(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w600,
              //                 color: Color(0xff292D32))),
              //         Text('August, 12',
              //             style: TextStyle(
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w400,
              //                 color: Color(0xff292D32)))
              //       ],
              //     ),
              //   ),
              //   IconButton(
              //       onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
              // ]),
              // SizedBox(height: 20),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              //   SizedBox(
              //     width: 174,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: const [
              //         Text('Shipping address',
              //             style: TextStyle(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w600,
              //                 color: Color(0xff292D32))),
              //         Text('View now',
              //             style: TextStyle(
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w400,
              //                 color: Color(0xff292D32)))
              //       ],
              //     ),
              //   ),
              //   IconButton(
              //       onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
              // ]),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                SizedBox(
                  // width: 174,
                  child: Text('Delete account',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffFF2323))),
                ),
                IconButton(
                    onPressed: () {
                      Get.to(() => DeleteAccount());
                    },
                    icon: const Icon(Icons.arrow_forward_ios))
              ])
            ])),
      ),
    );
  }
}
