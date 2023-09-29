import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/controllers/user/user_controller.dart';
import 'package:gonana/features/data/models/user_model.dart';
import 'package:gonana/features/presentation/page/home.dart';
import 'package:gonana/features/presentation/page/settings/edit_profile.dart';
import 'package:gonana/features/presentation/page/settings/settings.dart';
import 'package:gonana/features/presentation/page/settings/settings_details.dart';
import 'package:gonana/features/presentation/widgets/custom_tab_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProfile extends StatefulWidget {
  const SettingsProfile({super.key});

  @override
  State<SettingsProfile> createState() => _SettingsProfileState();
}

class _SettingsProfileState extends State<SettingsProfile> {
  UserController userController = Get.put(UserController());
  UserModel userModel = UserModel();
  late TabController _tabController;

  @override
  void initState() {
    getUserDetails();
    print("name: ${userController.userModel.value.firstName}");
    // _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  void getUserDetails() async {
    await userController.fetchUserByEmail();
    print("User details gotten");
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  final picker = ImagePicker();
  File? imageFile;
  String? imageFilePath;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        imageFilePath = pickedFile.path;
      });
    }
    if (imageFile != null) {
      bool created = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userEmailAdd = prefs.getString('userEmail');
      created =
          await userController.uploadProfilePhoto(userEmailAdd, imageFile);
      if (created) {
        print("image updated");
        setState(() {
          userController.fetchUserByEmail();
        });
      }
    }
  }

  // String imageUrl =
  // '${userController.userModel.value.profilePhoto}'; // Replace with your image URL
  String placeholderAssetName =
      'assets/images/gonanas_profile.png'; // Replace with your placeholder asset

  Widget getImageWidget(String imageUrl) {
    if (imageUrl.isNotEmpty && Uri.parse(imageUrl).isAbsolute) {
      return FadeInImage(
        placeholder: AssetImage(placeholderAssetName),
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(placeholderAssetName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF1F1F1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.to(() => HomePage(navIndex: 2));
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 20,
                color: Color(0xff292D32),
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => EditProfile());
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: ListView(children: [
              Container(
                // height: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (userController.userModel.value != null &&
                              userController.userModel.value.profilePhoto !=
                                  null &&
                              userController
                                  .userModel.value.profilePhoto!.isEmpty)
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  height: 82,
                                  width: 82,
                                  child: ClipOval(
                                    child: getImageWidget(
                                      "${userController.userModel.value.profilePhoto}",
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 0.0,
                                    right: 0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      pickImage();
                                    },
                                    child: Container(
                                      width: 30, // Adjust as needed
                                      height:
                                          30, // Should be equal to width for a perfect circle
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/svgs/camera.svg",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else if (userController.userModel.value != null &&
                              userController.userModel.value.profilePhoto !=
                                  null)
                            Obx(() {
                              return Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Container(
                                    height: 82,
                                    width: 82,
                                    child: ClipOval(
                                      child: FadeInImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "${userController.userModel.value.profilePhoto}",
                                        ),
                                        placeholder: const AssetImage(
                                          "assets/images/gonanas_profile.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 0.0,
                                      right: 0,
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        pickImage();
                                      },
                                      child: Container(
                                        width: 30, // Adjust as needed
                                        height:
                                            30, // Should be equal to width for a perfect circle
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "assets/svgs/camera.svg",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          Row(
                            children: [
                              if (userController.userModel.value != null)
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    '${userController.userModel.value.lastName} ${userController.userModel.value.firstName}',
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              // Icon(Icons.info),
                            ],
                          ),
                          // const Text('Vegetable farmer',
                          //     style: TextStyle(
                          //       fontSize: 10,
                          //       fontWeight: FontWeight.w400,
                          //     )),
                        ],
                      ),
                      // Container(
                      //   height: 100,
                      //   child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         const SizedBox(
                      //           width: 167,
                      //           child: Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceEvenly,
                      //               children: [
                      //                 Column(children: [
                      //                   Text('23',
                      //                       style: TextStyle(
                      //                           fontSize: 14,
                      //                           fontWeight: FontWeight.w600)),
                      //                   Text('Followers',
                      //                       style: TextStyle(
                      //                           fontSize: 10,
                      //                           fontWeight: FontWeight.w400))
                      //                 ]),
                      //                 Column(children: [
                      //                   Text('30',
                      //                       style: TextStyle(
                      //                           fontSize: 14,
                      //                           fontWeight: FontWeight.w600)),
                      //                   Text('Post',
                      //                       style: TextStyle(
                      //                           fontSize: 10,
                      //                           fontWeight: FontWeight.w400))
                      //                 ]),
                      //                 Column(children: [
                      //                   Text('27',
                      //                       style: TextStyle(
                      //                           fontSize: 14,
                      //                           fontWeight: FontWeight.w600)),
                      //                   Text('Product post',
                      //                       style: TextStyle(
                      //                           fontSize: 10,
                      //                           fontWeight: FontWeight.w400))
                      //                 ])
                      //               ]),
                      //         ),
                      //         Flexible(
                      //           child: Padding(
                      //             padding: const EdgeInsets.only(top: 10.0),
                      //             child: Container(
                      //               height: 34,
                      //               width: 167,
                      //               child: ElevatedButton(
                      //                   onPressed: () {},
                      //                   style: ElevatedButton.styleFrom(
                      //                     backgroundColor:
                      //                         const Color(0xff29844B),
                      //                     shape: RoundedRectangleBorder(
                      //                       borderRadius:
                      //                           BorderRadius.circular(5.0),
                      //                     ),
                      //                   ),
                      //                   child: const Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.spaceEvenly,
                      //                       children: [
                      //                         Text('Follow'),
                      //                         Icon(Icons.add)
                      //                       ])),
                      //             ),
                      //           ),
                      //         )
                      //       ]),
                      // )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: CustomTabBar(),
              )
            ]),
          ),
        ));
  }
}
