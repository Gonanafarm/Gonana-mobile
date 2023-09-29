import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/controllers/post/post_controllers.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../consts.dart';
import '../../widgets/widgets.dart';
import 'create_post2.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _caption = TextEditingController();
  PostController postController = Get.put(PostController());
  String get caption => _caption.text;
  final picker = ImagePicker();
  File? _imageFile;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      postController.updateImage(_imageFile);
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
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Create post",
                          style: TextStyle(
                              fontSize: 24,
                              color: darkColor,
                              fontWeight: FontWeight.w600)),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                                height: 30,
                                width: 30,
                                "assets/images/john_david_photo.png"),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.03),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("John",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: darkColor,
                                        fontWeight: FontWeight.w600)),
                                Text("Yaay, it friday.",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: darkColor,
                                        fontWeight: FontWeight.w400)),
                              ],
                            )
                          ],
                        ),
                      ),
                      EnterLargeText(
                        controller: _caption,
                        onChanged: (body) {
                          postController.updateBody(body);
                        },
                        label: '',
                        hint: 'What do you want to talk about',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  pickImage();
                                },
                                child: SvgPicture.asset(
                                  "assets/svgs/add_image.svg",
                                  width: 45,
                                  height: 30,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text("Add image",
                                  style: TextStyle(
                                      fontSize: 14,
                                      // color: darkColor,
                                      fontWeight: FontWeight.w400)),
                              // SizedBox(width: 15),
                              // SvgPicture.asset(
                              //   "assets/svgs/add_video.svg",
                              //   width: 45,
                              //   height: 30,
                              // ),
                              // SizedBox(width: 10),
                              // Text("Add video",
                              //     style: TextStyle(
                              //         fontSize: 14,
                              //         // color: darkColor,
                              //         fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: _imageFile != null
                                  ? Image.file(
                                      fit: BoxFit.cover,
                                      _imageFile!,
                                    )
                                  : Container()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            LongGradientButton(
                title: "Next",
                onPressed: () {
                  Get.to(() => CreatePost2());
                })
          ],
        ),
      )),
    );
  }
}
