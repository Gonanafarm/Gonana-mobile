import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/controllers/auth/get_details.dart';
import 'package:gonana/features/presentation/page/settings/settiings_profile.dart';
import 'package:gonana/features/presentation/page/settings/settings.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/user/user_controller.dart';
import '../../widgets/widgets.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

  bool value = false;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final picker = ImagePicker();
  File? _imageFile;
  String? _imageFilePath;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageFilePath = pickedFile.path;
      });
    }
  }

  bool isLoading = false;
  final _editProfileKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if (userController.userModel.value != null &&
        userController.userModel.value.user != null &&
        userController.userModel.value.user!.firstName != null &&
        userController.userModel.value.user!.firstName!.isNotEmpty &&
        userController.userModel.value.user!.lastName != null &&
        userController.userModel.value.user!.lastName!.isNotEmpty &&
        userController.userModel.value.user!.email != null &&
        userController.userModel.value.user!.email!.isNotEmpty &&
        userController.userModel.value.user!.phone != null &&
        userController.userModel.value.user!.phone!.isNotEmpty) {
      firstNameController.text =
          userController.userModel.value.user!.firstName ?? '';
      lastNameController.text =
          userController.userModel.value.user!.lastName ?? '';
      emailController.text = userController.userModel.value.user!.email ?? '';
      phoneNumberController.text =
          userController.userModel.value.user!.phone ?? '';
    }
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Text(
                        'Upload a picture for your profile.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 30),
                      Form(
                        key: _editProfileKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              // height: 82,
                              width: MediaQuery.of(context).size.width,
                              child: EnterText(
                                controller: firstNameController,
                                label: 'First Name',
                                hint: 'First Name',
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: EnterText(
                                controller: lastNameController,
                                label: 'Last name',
                                hint: 'Last name',
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                                // height: 82,
                                width: MediaQuery.of(context).size.width,
                                child: EnterText(
                                  controller: emailController,
                                  label: 'Email address',
                                  hint: 'email',
                                )),
                            SizedBox(height: 10),
                            SizedBox(
                                // height: 82,
                                width: MediaQuery.of(context).size.width,
                                child: EnterText(
                                  controller: phoneNumberController,
                                  label: 'Phone number',
                                  hint: 'Phone number',
                                )),
                            // SizedBox(height: 10),
                            // SizedBox(
                            //     // height: 82,
                            //     width: MediaQuery.of(context).size.width,
                            //     child: EnterText(
                            //       // onChanged: (quantity) {
                            //       //   productController.updateQuantity(quantity);
                            //       // },
                            //       controller: birthdayController,
                            //       label: 'Birthday',
                            //       hint: 'August 12',
                            //     )),
                            // SizedBox(height: 10),
                            // SizedBox(
                            //     // height: 82,
                            //     width: MediaQuery.of(context).size.width,
                            //     child: EnterText(
                            //       // onChanged: (quantity) {
                            //       //   productController.updateQuantity(quantity);
                            //       // },
                            //       controller: addressController,
                            //       label: 'Address',
                            //       hint: 'Wuse 2',
                            //     )),
                          ],
                        ),
                      ),
                      // SizedBox(height: 20),
                      // Container(
                      //   color: Colors.white,
                      //   child: Row(children: [
                      //     Checkbox(
                      //       value: this.value,
                      //       activeColor: Color(0xff29844B),
                      //       onChanged: (value) {
                      //         setState(() {
                      //           this.value = value!;
                      //         });
                      //       },
                      //     ),
                      //     const Flexible(
                      //         child: Text(
                      //       'Make address visible to public in profile ?',
                      //       style: TextStyle(
                      //         color: Colors.black,
                      //         fontSize: 14,
                      //         fontFamily: 'Proxima Nova',
                      //         fontWeight: FontWeight.w400,
                      //         height: 1.71,
                      //       ),
                      //     ))
                      //   ]),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            LongGradientButton(
                isLoading: isLoading,
                title: 'Save',
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await userController.updateProfile(
                      firstNameController.text,
                      lastNameController.text,
                      phoneNumberController.text,
                      emailController.text);
                  await userController.fetchUserByEmail();
                  Get.to(
                    () => const Settings(),
                  );
                  setState(() {
                    isLoading = false;
                  });
                })
          ],
        ),
      ),
    );
  }
}
