import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/controllers/post/post_controllers.dart';
import 'package:gonana/features/data/models/post_model.dart';
import 'package:gonana/features/presentation/page/feeds/comment_bottomsheet.dart';
import 'package:gonana/features/presentation/page/feeds/share_post_bottomsheet.dart';
import 'package:gonana/features/presentation/page/feeds/story_view.dart';
import 'package:gonana/features/presentation/page/feeds/user_store.dart';
import 'package:gonana/features/presentation/page/market/cart_page.dart';
import 'package:gonana/features/presentation/widgets/posts_container.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../consts.dart';
import '../../../controllers/cart/cart_controller.dart';
import '../../../controllers/user/user_controller.dart';
import '../../widgets/warning_widget.dart';
import 'create_post.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({Key? key}) : super(key: key);

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  PostController postController = Get.put(PostController());
  UserController userController = Get.put(UserController());
  PostModel postModel = PostModel();
  CartController cartController = Get.put(CartController());
  @override
  // void initState() {
  //   super.initState();
  //   postController.fetchPosts();
  //   print("initState() called");
  // }

  List storyList = [
    MyStoryIcon(),
    Story(),
    EmptyStory(),
    Story(),
    Story(),
  ];
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff29844B),
        child: Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Get.to(() => CreatePost());
        },
      ),
      backgroundColor: const Color(0xffF1F1F1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20.0, 25, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          userController.userModel.value != null
                              ? (userController.userModel.value.profilePhoto
                                          ?.isEmpty ??
                                      true)
                                  ? Container(
                                      height: 50,
                                      width: 50,
                                      child: ClipOval(
                                        child: getImageWidget(
                                          "${userController.userModel.value.profilePhoto}",
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
                                              "${userController.userModel.value.profilePhoto}",
                                            ),
                                            placeholder: const AssetImage(
                                              "assets/images/gonanas_profile.png",
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                              : Container(), // Handle the case when userModel.value is null
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              userController.userModel.value != null
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Text(
                                        '${userController.userModel.value.lastName} ${userController.userModel.value.firstName}',
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  : Container(), // Handle the case when userModel.value is null
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // SvgPicture.asset(
                          //   "assets/svgs/Essential.svg",
                          //   width: 45,
                          //   height: 30,
                          // ),
                          // sizeHor(20.0),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => CartPage());
                            },
                            child: Stack(
                              children: [
                                SvgPicture.asset(
                                    height: 40,
                                    width: 40,
                                    "assets/svgs/cart.svg"),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      color: Colors.red[500],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Obx(() {
                                        return Text(
                                          cartController.cartModel!.value
                                                      .products!.isNotEmpty ||
                                                  cartController.cartModel! ==
                                                      null
                                              ? "${cartController.cartModel!.value.products!.length}"
                                              : "",
                                          style: const TextStyle(
                                            color: primaryColor,
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // Divider(
                //   thickness: 1,
                // ),
                // Container(
                //   height: 80,
                //   child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: storyList.length,
                //       shrinkWrap: true,
                //       itemBuilder: (BuildContext context, index) {
                //         return Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Container(
                //             child: storyList[index],
                //           ),
                //         );
                //       }),
                // ),
                Divider(
                  thickness: 1,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.3,
                      // width: 342,
                      child: postController.postModel.data!.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const WarningWidget(),
                                sizeVer(
                                    MediaQuery.of(context).size.height * 0.1),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svgs/empty_product.svg",
                                        width: 189.71,
                                        height: 156.03,
                                      ),
                                      const Text(
                                        'Sorry! no post yet',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontFamily: 'Proxima Nova',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Text(
                                        'All post will be visible here',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Proxima Nova',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                const WarningWidget(),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: ListView.builder(
                                      itemCount:
                                          postController.postModel.data!.length,
                                      // itemCount: postModel.body!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final reversedIndex = (postController
                                                    .postModel!.data!.length -
                                                1) -
                                            index;
                                        return Column(
                                          children: [
                                            SizedBox(
                                              // height: 40,
                                              child: ListTile(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 15.0),
                                                leading: postController
                                                        .postModel
                                                        .data![reversedIndex]
                                                        .ownerPhoto!
                                                        .isEmpty
                                                    ? Container(
                                                        height: 30,
                                                        width: 30,
                                                        child: ClipOval(
                                                          child: getImageWidget(
                                                              "${postController.postModel.data![reversedIndex].ownerPhoto!}"),
                                                        ),
                                                      )
                                                    : Obx(() {
                                                        return Container(
                                                          height: 30,
                                                          width: 30,
                                                          child: ClipOval(
                                                            child: FadeInImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  "${postController.postModel.data![reversedIndex].ownerPhoto!}"),
                                                              placeholder:
                                                                  const AssetImage(
                                                                      "assets/images/gonanas_profile.png"),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                title: Row(
                                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Flexible(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            postController
                                                                .postModel
                                                                .data![
                                                                    reversedIndex]
                                                                .ownerName!,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          // const Text(
                                                          //   "Vegetable farmer",
                                                          //   style: TextStyle(
                                                          //       fontSize: 10,
                                                          //       fontWeight:
                                                          //           FontWeight
                                                          //               .w400),
                                                          // )
                                                        ],
                                                      ),
                                                    ),
                                                    // SizedBox(width: 15),
                                                    // Padding(
                                                    //   padding: EdgeInsets.only(
                                                    //       bottom: 15.0),
                                                    //   child: Text(
                                                    //     "8h ago",
                                                    //     style: TextStyle(
                                                    //         fontSize: 10,
                                                    //         fontWeight:
                                                    //             FontWeight
                                                    //                 .w400),
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                                // trailing: const Padding(
                                                //   padding: EdgeInsets.only(
                                                //       bottom: 15.0),
                                                //   child: Icon(Icons.more_horiz),
                                                // ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15.0, 0, 10, 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text:
                                                          // 'We just had the best harvest every, get your fresh, nice to vegetables while they last ',
                                                          postController
                                                                      .postModel
                                                                      .data![
                                                                          reversedIndex]
                                                                      .product!
                                                                      .body!
                                                                      .isEmpty ||
                                                                  postController
                                                                              .postModel
                                                                              .data![
                                                                          reversedIndex] ==
                                                                      null ||
                                                                  postController
                                                                          .postModel ==
                                                                      null
                                                              ? " "
                                                              : postController
                                                                  .postModel
                                                                  .data![
                                                                      reversedIndex]
                                                                  .product!
                                                                  .body,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black),
                                                      children: const <TextSpan>[
                                                        TextSpan(
                                                            text: '',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xff29844B),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                // height: 340,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                child: postController
                                                        .postModel
                                                        .data![reversedIndex]
                                                        .product!
                                                        .images!
                                                        .isNotEmpty
                                                    ? Image.network(
                                                        postController
                                                            .postModel
                                                            .data![
                                                                reversedIndex]
                                                            .product!
                                                            .images![0])
                                                    : Container(
                                                        // child: Image.asset(
                                                        //     "assets/images/barter.png"),
                                                        )),
                                            sizeVer(10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  height: 30,
                                                  width: 92.5,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Color(0xff29844B),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        bool created = false;
                                                        created = await postController
                                                            .getPostsById(
                                                                postController
                                                                    .postModel
                                                                    .data![
                                                                        reversedIndex]
                                                                    .ownerId,
                                                                "product");
                                                        print(postController
                                                            .postModel
                                                            .data![index]
                                                            .ownerId);
                                                        if (created) {
                                                          print(postController
                                                              .idPostModel!
                                                              .data!
                                                              .length);
                                                          Get.to(() =>
                                                              const UserStore());
                                                        }
                                                      },
                                                      child: const Text(
                                                          'Visit Store',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600))),
                                                ),
                                              ],
                                            ),

                                            // const Padding(
                                            //   padding: EdgeInsets.only(
                                            //       left: 25, right: 25, top: 10),
                                            //   child: Row(
                                            //       mainAxisAlignment:
                                            //           MainAxisAlignment
                                            //               .spaceBetween,
                                            //       children: [
                                            //         Text(
                                            //             'Daniel jim and 38 others',
                                            //             style: TextStyle(
                                            //                 fontSize: 10,
                                            //                 fontWeight:
                                            //                     FontWeight
                                            //                         .w400)),
                                            //         Text('12 Comments',
                                            //             style: TextStyle(
                                            //                 fontSize: 10,
                                            //                 fontWeight:
                                            //                     FontWeight
                                            //                         .w400))
                                            //       ]),
                                            // ),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.symmetric(
                                            //           horizontal: 20.0),
                                            //   child: Row(
                                            //       mainAxisAlignment:
                                            //           MainAxisAlignment
                                            //               .spaceBetween,
                                            //       children: [
                                            //         Row(
                                            //             mainAxisAlignment:
                                            //                 MainAxisAlignment
                                            //                     .spaceEvenly,
                                            //             children: [
                                            //               IconButton(
                                            //                   icon: const Icon(
                                            //                       size: 30,
                                            //                       Icons
                                            //                           .favorite_outline),
                                            //                   onPressed: () {}),
                                            //               GestureDetector(
                                            //                 onTap: () {
                                            //                   comment(context);
                                            //                 },
                                            //                 child: SvgPicture
                                            //                     .asset(
                                            //                   "assets/svgs/emails_messages_icon.svg",
                                            //                   width: 45,
                                            //                   height: 30,
                                            //                 ),
                                            //               ),
                                            //               SizedBox(width: 10),
                                            //               GestureDetector(
                                            //                 onTap: () {
                                            //                   sharePost(
                                            //                       context);
                                            //                 },
                                            //                 child: SvgPicture
                                            //                     .asset(
                                            //                   "assets/svgs/send_icon.svg",
                                            //                   width: 45,
                                            //                   height: 30,
                                            //                 ),
                                            //               ),
                                            //             ]),
                                            //         //Like and Visit Store
                                            //         SizedBox(
                                            //           height: 30,
                                            //           width: 92.5,
                                            //           child: ElevatedButton(
                                            //               style: ElevatedButton
                                            //                   .styleFrom(
                                            //                 backgroundColor:
                                            //                     Color(
                                            //                         0xff29844B),
                                            //                 shape:
                                            //                     RoundedRectangleBorder(
                                            //                   borderRadius:
                                            //                       BorderRadius
                                            //                           .circular(
                                            //                               5.0),
                                            //                 ),
                                            //               ),
                                            //               onPressed: () {},
                                            //               child: const Text(
                                            //                   'Visit Store',
                                            //                   style: TextStyle(
                                            //                       color: Colors
                                            //                           .white,
                                            //                       fontSize: 10,
                                            //                       fontWeight:
                                            //                           FontWeight
                                            //                               .w600))),
                                            //         ),
                                            //       ]),
                                            // ),
                                            // //Comment section
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.symmetric(
                                            //           horizontal: 15.0),
                                            //   child: Column(
                                            //       crossAxisAlignment:
                                            //           CrossAxisAlignment.start,
                                            //       children: [
                                            //         RichText(
                                            //           text: const TextSpan(
                                            //               text: 'Daniel Cho',
                                            //               style: TextStyle(
                                            //                   color: Color(
                                            //                       0xff000000),
                                            //                   fontSize: 12,
                                            //                   fontWeight:
                                            //                       FontWeight
                                            //                           .w600),
                                            //               children: [
                                            //                 TextSpan(
                                            //                     text:
                                            //                         ' I love these',
                                            //                     style: TextStyle(
                                            //                         color: Color(
                                            //                             0xff000000),
                                            //                         fontSize:
                                            //                             12,
                                            //                         fontWeight:
                                            //                             FontWeight
                                            //                                 .w400))
                                            //               ]),
                                            //         ),
                                            //         RichText(
                                            //           text: const TextSpan(
                                            //               text: 'John Donny',
                                            //               style: TextStyle(
                                            //                   color: Color(
                                            //                       0xff000000),
                                            //                   fontSize: 12,
                                            //                   fontWeight:
                                            //                       FontWeight
                                            //                           .w600),
                                            //               children: [
                                            //                 TextSpan(
                                            //                     text:
                                            //                         ' @john david Can i get these for NGN 2000 ?',
                                            //                     style: TextStyle(
                                            //                         color: Color(
                                            //                             0xff000000),
                                            //                         fontSize:
                                            //                             12,
                                            //                         fontWeight:
                                            //                             FontWeight
                                            //                                 .w400))
                                            //               ]),
                                            //         )
                                            //       ]),
                                            // ),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.symmetric(
                                            //           horizontal: 30.0),
                                            //   child: Container(
                                            //     height: 50,
                                            //     decoration: BoxDecoration(
                                            //       borderRadius:
                                            //           BorderRadius.circular(
                                            //               10.0), // Set the desired border radius
                                            //       border: Border.all(
                                            //         color: Colors.black,
                                            //         width: 1.0,
                                            //       ),
                                            //     ),
                                            //     child: Center(
                                            //       child: TextField(
                                            //         autofocus: false,
                                            //         decoration:
                                            //             const InputDecoration(
                                            //                 border:
                                            //                     OutlineInputBorder(),
                                            //                 hintText:
                                            //                     "Add a comment",
                                            //                 hintStyle: TextStyle(
                                            //                     color: Color(
                                            //                         0xff444444),
                                            //                     fontSize: 14,
                                            //                     fontWeight:
                                            //                         FontWeight
                                            //                             .w400)),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                            if (index ==
                                                postController.postModel.data!
                                                        .length -
                                                    1) ...[
                                              CircularProgressIndicator(),
                                              sizeVer(MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15),
                                            ],
                                            sizeVer(10)
                                          ],
                                        );
                                      }),
                                ),
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
    );
  }
}

class MyStoryIcon extends StatelessWidget {
  const MyStoryIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67,
      width: 67,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset("assets/images/john_david_photo.png"),
          const Icon(
            color: Colors.white,
            Icons.add,
            size: 40,
          ),
        ],
      ),
    );
  }
}

class EmptyStory extends StatelessWidget {
  const EmptyStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => StoryView());
      },
      child: Container(
        height: 67,
        width: 67,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff29844B),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class Story extends StatelessWidget {
  const Story({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => StoryView());
      },
      child: Container(
        height: 67,
        width: 67,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff29844B),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child:
            Center(child: Image.asset("assets/images/story_profile_photo.png")),
      ),
    );
  }
}
