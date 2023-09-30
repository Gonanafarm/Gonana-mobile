import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/controllers/post/post_controllers.dart';
import 'package:gonana/features/presentation/widgets/posts_container.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../controllers/user/user_controller.dart';
import '../home.dart';

class CreatePost2 extends StatefulWidget {
  const CreatePost2({Key? key}) : super(key: key);

  @override
  State<CreatePost2> createState() => _CreatePost2State();
}

class _CreatePost2State extends State<CreatePost2> {
  PostController postController = Get.put(PostController());
  bool isLoading = false;
  get controller => null;
  UserController userController = Get.put(UserController());

  String placeholderAssetName = 'assets/images/gonanas_profile.png';
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
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
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
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: Container(
                              // height: MediaQuery.of(context).size.height * 0.3,
                              // width: 342,
                              child: Column(
                                children: [
                                  SizedBox(
                                    // height: 40,
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      leading:
                                          userController.userModel.value != null
                                              ? (userController
                                                          .userModel
                                                          .value
                                                          .user!
                                                          .profilePhoto
                                                          ?.isEmpty ??
                                                      true)
                                                  ? Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: ClipOval(
                                                        child: getImageWidget(
                                                          "${userController.userModel.value.user!.profilePhoto}",
                                                        ),
                                                      ),
                                                    )
                                                  : Obx(() {
                                                      return Container(
                                                        height: 50,
                                                        width: 50,
                                                        child: ClipOval(
                                                          child: FadeInImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              "${userController.userModel.value.user!.profilePhoto}",
                                                            ),
                                                            placeholder:
                                                                const AssetImage(
                                                              "assets/images/gonanas_profile.png",
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    })
                                              : Container(),
                                      title: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                userController
                                                            .userModel.value !=
                                                        null
                                                    ? Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                        child: Text(
                                                          '${userController.userModel.value.user!.lastName} ${userController.userModel.value.user!.firstName}',
                                                          style:
                                                              const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                        ],
                                      ),
                                      trailing: const Padding(
                                        padding: EdgeInsets.only(bottom: 15.0),
                                        child: Icon(Icons.more_horiz),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        30.0, 20, 10, 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Obx(() {
                                          return RichText(
                                            text: TextSpan(
                                              text: postController.body.value,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                              children: <TextSpan>[
                                                // TextSpan(
                                                //     text: 'Read more.',
                                                //     style: TextStyle(
                                                //       fontWeight: FontWeight.w400,
                                                //       color: Color(0xff29844B),
                                                //     )),
                                              ],
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 300,
                                    // width: 340,
                                    child: Obx(() {
                                      return Image.file(
                                          postController.image.value);
                                    }),
                                  ),
                                  // const Padding(
                                  //   padding: EdgeInsets.only(
                                  //       left: 25, right: 25, top: 10),
                                  //   child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         Text('Daniel jim and 38 others',
                                  //             style: TextStyle(
                                  //                 color: Colors.white,
                                  //                 fontSize: 10,
                                  //                 fontWeight: FontWeight.w400)),
                                  //         Text('12 Comments',
                                  //             style: TextStyle(
                                  //                 color: Colors.white,
                                  //                 fontSize: 10,
                                  //                 fontWeight: FontWeight.w400))
                                  //       ]),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 20.0),
                                  //   child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.spaceEvenly,
                                  //             children: [
                                  //               IconButton(
                                  //                   icon: const Icon(
                                  //                     Icons.favorite_outline,
                                  //                     color: Colors.white24,
                                  //                   ),
                                  //                   onPressed: () {}),
                                  //               SvgPicture.asset(
                                  //                 "assets/svgs/emails_messages_icon.svg",
                                  //                 width: 45,
                                  //                 height: 30,
                                  //               ),
                                  //               SizedBox(width: 10),
                                  //               SvgPicture.asset(
                                  //                 "assets/svgs/send_icon.svg",
                                  //                 width: 45,
                                  //                 height: 30,
                                  //               ),
                                  //             ]),
                                  //         //Like and Visit Store
                                  //         SizedBox(
                                  //           height: 30,
                                  //           width: 92.5,
                                  //           child: ElevatedButton(
                                  //               style: ElevatedButton.styleFrom(
                                  //                 backgroundColor:
                                  //                     Color(0xff29844B),
                                  //                 shape: RoundedRectangleBorder(
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(
                                  //                           5.0),
                                  //                 ),
                                  //               ),
                                  //               onPressed: () {},
                                  //               child: const Text('Visit Store',
                                  //                   style: TextStyle(
                                  //                       color: Colors.white,
                                  //                       fontSize: 10,
                                  //                       fontWeight:
                                  //                           FontWeight.w600))),
                                  //         ),
                                  //       ]),
                                  // ),
                                  // //Comment section
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 15.0),
                                  //   child: Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //       children: [
                                  //         RichText(
                                  //           text: const TextSpan(
                                  //               text: 'Daniel Cho',
                                  //               style: TextStyle(
                                  //                   color: Colors.white,
                                  //                   fontSize: 12,
                                  //                   fontWeight:
                                  //                       FontWeight.w600),
                                  //               children: [
                                  //                 TextSpan(
                                  //                     text: ' I love these',
                                  //                     style: TextStyle(
                                  //                         color:
                                  //                             Color(0xff000000),
                                  //                         fontSize: 12,
                                  //                         fontWeight:
                                  //                             FontWeight.w400))
                                  //               ]),
                                  //         ),
                                  //         RichText(
                                  //           text: const TextSpan(
                                  //               text: 'John Donny',
                                  //               style: TextStyle(
                                  //                   color: Colors.white,
                                  //                   fontSize: 12,
                                  //                   fontWeight:
                                  //                       FontWeight.w600),
                                  //               children: [
                                  //                 TextSpan(
                                  //                     text:
                                  //                         ' @john david Can i get these for NGN 2000 ?',
                                  //                     style: TextStyle(
                                  //                         color: Colors.white,
                                  //                         fontSize: 12,
                                  //                         fontWeight:
                                  //                             FontWeight.w400))
                                  //               ]),
                                  //         )
                                  //       ]),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              LongGradientButton(
                  isLoading: isLoading,
                  title: "Post",
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    bool created = false;
                    try {
                      created = await postController.createPost(
                        postController.body.value,
                        postController.image.value,
                      );
                    } catch (e, s) {
                      print(e);
                      print(s);
                    }
                    if (created) {
                      setState(() {
                        isLoading = false;
                      });
                      await postController.getPosts();
                      Get.to(() => HomePage(navIndex: 1));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
