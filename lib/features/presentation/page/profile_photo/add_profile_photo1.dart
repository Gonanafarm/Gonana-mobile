import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/user/user_controller.dart';
import '../../widgets/widgets.dart';
import '../auth/auth_passcode.dart';

class AddProfilePhoto extends StatefulWidget {
  const AddProfilePhoto({Key? key}) : super(key: key);

  @override
  State<AddProfilePhoto> createState() => _AddProfilePhotoState();
}

class _AddProfilePhotoState extends State<AddProfilePhoto> {
  final userController = Get.find<UserController>();
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
  }

  String imageStatus =
      "Profile should be 20 MB or less Upload file as PNG or JPEG.";
  @override
  void initState() {
    super.initState();
    setStage();
  }

  setStage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('registrationStage', 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: -4.0),
                    leading: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        )),
                    trailing: GestureDetector(
                      onTap: () {
                        Get.to(() => const SetPasscode());
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w400,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Add profile picture',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                  ),
                  SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Upload a picture for your profile.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.08),
                  child: Column(
                    children: [
                      imageFile == null
                          ? GestureDetector(
                              onTap: () async {
                                pickImage();
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Container(
                                    width: 181.43, // Adjust as needed
                                    height:
                                        181.43, // Should be equal to width for a perfect circle
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffD9D9D9),
                                    ),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () async {
                                          pickImage();
                                        },
                                        child: Text(
                                          '+',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 50,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10.0, right: 10),
                                    child: GestureDetector(
                                      onTap: () async {
                                        pickImage();
                                      },
                                      child: Container(
                                        width: 40, // Adjust as needed
                                        height:
                                            40, // Should be equal to width for a perfect circle
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                              "assets/svgs/add_image.svg"),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                pickImage();
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Container(
                                    width: 181.43, // Adjust as needed
                                    height: 181.43,
                                    child: ClipOval(
                                      child: Image.file(
                                        fit: BoxFit.cover,
                                        imageFile!,
                                        width: 181.43, // Adjust as needed
                                        height: 181.43,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10.0, right: 10),
                                    child: GestureDetector(
                                      onTap: () async {
                                        pickImage();
                                      },
                                      child: Container(
                                        width: 40, // Adjust as needed
                                        height:
                                            40, // Should be equal to width for a perfect circle
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                              "assets/svgs/add_image.svg"),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      const Text(
                        'John David',
                        style: TextStyle(
                          color: Color(0xFF29844B),
                          fontSize: 24,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.1),
                        child: Container(
                          // width: 214,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 11, vertical: 9),
                          decoration: ShapeDecoration(
                            color: Color(0xffD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            imageStatus,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              imageFile != null
                  ? LongGradientButton(
                      title: 'Proceed',
                      onPressed: () async {
                        print(imageFile);
                        print(imageFilePath);
                        bool created = false;
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var userEmailAdd = prefs.getString('userEmail');
                        created = await userController.uploadProfilePhoto(
                            userEmailAdd, imageFile);
                        if (created) {
                          print("image uploaded");
                          setState(() {
                            imageStatus = "Profile picture Upload Successful !";
                          });
                          Get.to(() => const SetPasscode());
                        }
                      })
                  : Container(
                      height: 60,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
