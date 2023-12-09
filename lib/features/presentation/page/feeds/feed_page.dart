// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/post/post_controllers.dart';
import 'package:gonana/features/data/models/post_model.dart';
import 'package:gonana/features/presentation/page/feeds/share_post_bottomsheet.dart';
import 'package:gonana/features/presentation/page/feeds/story_view.dart';
import 'package:gonana/features/presentation/page/feeds/user_store.dart';
import 'package:gonana/features/presentation/page/market/cart_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import '../../../../consts.dart';
import '../../../controllers/cart/cart_controller.dart';
import '../../../controllers/user/user_controller.dart';
import '../../widgets/warning_widget.dart';
import 'create_post.dart';
import 'package:flutter/services.dart' show PlatformException;

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
  final TextEditingController commentController = TextEditingController();
  bool isLoadingComments = true;
  // @override
  // void initState() {
  //   super.initState();
  //   postController.fetchPosts();
  //   print("initState() called");
  // }

  List storyList = [
    const MyStoryIcon(),
    const Story(),
    const EmptyStory(),
    const Story(),
    const Story(),
  ];
  String placeholderAssetName = 'assets/images/gonanas_profile.png';
  bool isCommentLoading = false;
  bool isVisitStoreLoading = false;
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

  bool? BVNisSubmited = false;
  getBVNStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BVNisSubmited = prefs.getBool('bvnSubmission');
    print("${userController.userModel.value!.virtualAccountNumber}");
  }

  ScrollController scrollController = ScrollController();
  bool loading = false;
  getMoreData() async {
    setState(() {
      loading = true;
    });
    await postController.getMorePosts();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getBVNStatus();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreData();
      }
    });
    for (int i = 0; i < postController.postModel!.data!.length; i++) {
      if (postController.postModel!.data![i].product!.likes!
          .any((like) => like.id == userController.userModel.value.id)) {
        likedPostIndices.add(i);
      }
    }
  }

  Set<int> likedPostIndices = Set<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff29844B),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Get.to(() => const CreatePost());
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
                              : Container(),
                          // Handle the case when userModel.value is null
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
                                        '${userController.userModel.value.lastName ?? ''} ${userController.userModel.value.firstName ?? ''}',
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              // Handle the case when userModel.value is null
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const CartPage());
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
                const Divider(
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
                                (BVNisSubmited != null && BVNisSubmited!) ||
                                        (userController.userModel != null &&
                                            userController.userModel.value
                                                    .virtualAccountNumber !=
                                                null &&
                                            userController
                                                .userModel
                                                .value
                                                .virtualAccountNumber!
                                                .isNotEmpty)
                                    ? Container(height: 1)
                                    : const WarningWidget(),
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
                                (BVNisSubmited != null && BVNisSubmited!) ||
                                        (userController.userModel != null &&
                                            userController.userModel.value
                                                    .virtualAccountNumber !=
                                                null &&
                                            userController
                                                .userModel
                                                .value
                                                .virtualAccountNumber!
                                                .isNotEmpty)
                                    ? Container(height: 1)
                                    : const WarningWidget(),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            controller: scrollController,
                                            itemCount: postController
                                                .postModel.data!.length,
                                            // itemCount: postModel.body!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final reversedIndex =
                                                  (postController.postModel!
                                                              .data!.length -
                                                          1) -
                                                      index;
                                              // bool postLiked = likedPostIndices
                                              //     .contains(index);
                                              bool postLiked = postController
                                                  .postModel!
                                                  .data![index]
                                                  .product!
                                                  .likes!
                                                  .any((like) =>
                                                      like.id ==
                                                      userController
                                                          .userModel.value.id);
                                              bool unliked = true;
                                              // if (postController.postModel!
                                              //     .data![index].product!.likes!
                                              //     .any((like) =>
                                              //         like.id ==
                                              //         userController.userModel
                                              //             .value.id)) {
                                              //   likedPostIndices.add(index);
                                              //   // postLiked = true;
                                              //   unliked = false;
                                              // }
                                              return Column(
                                                children: [
                                                  SizedBox(
                                                    //Posters name and profile pic
                                                    // height: 40,
                                                    child: ListTile(
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 15.0),
                                                      leading: postController
                                                                  .postModel
                                                                  .data?[index]
                                                                  ?.ownerPhoto
                                                                  ?.isEmpty ??
                                                              true
                                                          ? Container(
                                                              height: 30,
                                                              width: 30,
                                                              child: ClipOval(
                                                                child: getImageWidget(postController
                                                                        .postModel
                                                                        .data?[
                                                                            index]
                                                                        ?.ownerPhoto ??
                                                                    ''),
                                                              ),
                                                            )
                                                          : Container(
                                                              height: 30,
                                                              width: 30,
                                                              child: ClipOval(
                                                                child:
                                                                    FadeInImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image:
                                                                      NetworkImage(
                                                                    postController
                                                                            .postModel
                                                                            .data?[index]
                                                                            ?.ownerPhoto ??
                                                                        '',
                                                                  ),
                                                                  placeholder:
                                                                      const AssetImage(
                                                                          "assets/images/gonanas_profile.png"),
                                                                ),
                                                              ),
                                                            ),
                                                      title: Row(
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
                                                                          index]
                                                                      .ownerName!,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      child: postController
                                                              .postModel
                                                              .data![index]
                                                              .product!
                                                              .images!
                                                              .isNotEmpty
                                                          ? Image.network(
                                                              postController
                                                                  .postModel
                                                                  .data![index]
                                                                  .product!
                                                                  .images![0],
                                                              errorBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      Object
                                                                          error,
                                                                      StackTrace?
                                                                          stackTrace) {
                                                                // Handle the error, log it, or show a placeholder image.
                                                                return Center(
                                                                    child: const Icon(
                                                                        Icons
                                                                            .error));
                                                              },
                                                            )
                                                          : Container()),
                                                  sizeVer(5),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: 90,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              IconButton(
                                                                icon: likedPostIndices
                                                                        .contains(
                                                                            index)
                                                                    ? const Icon(
                                                                        Icons
                                                                            .favorite,
                                                                        color: Colors
                                                                            .red,
                                                                        size:
                                                                            30,
                                                                      )
                                                                    : const Icon(
                                                                        Icons
                                                                            .favorite_outline,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                onPressed:
                                                                    () async {
                                                                  bool liked;
                                                                  if (likedPostIndices
                                                                      .contains(
                                                                          index)) {
                                                                    setState(
                                                                        () {
                                                                      likedPostIndices
                                                                          .remove(
                                                                              index);
                                                                    });
                                                                    liked = await postController
                                                                        .unlikePost(
                                                                      postController
                                                                          .postModel
                                                                          .data![
                                                                              index]
                                                                          .product!
                                                                          .id,
                                                                    );
                                                                    setState(
                                                                        () {
                                                                      unliked =
                                                                          true;
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      likedPostIndices
                                                                          .add(
                                                                              index);
                                                                    });
                                                                    unliked =
                                                                        await postController
                                                                            .likePost(
                                                                      postController
                                                                          .postModel
                                                                          .data![
                                                                              index]
                                                                          .product!
                                                                          .id,
                                                                    );
                                                                  }

                                                                  print(
                                                                      likedPostIndices);
                                                                  setState(() {
                                                                    postLiked =
                                                                        likedPostIndices
                                                                            .contains(index);
                                                                    log(postLiked
                                                                        ? "post liked"
                                                                        : "post unliked");
                                                                    log("likedPostIndices: $likedPostIndices");
                                                                  });
                                                                },
                                                              ),
                                                              InkWell(
                                                                  onTap: () {
                                                                    _makeComment(
                                                                        context,
                                                                        index);
                                                                  },
                                                                  child: SvgPicture.asset(
                                                                      'assets/svgs/emails_messages_icon.svg',
                                                                      height:
                                                                          30,
                                                                      width:
                                                                          30)),
                                                            ],
                                                          ),
                                                        ),
                                                        //Visit Store button
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10.0),
                                                          child: SizedBox(
                                                            height: 30,
                                                            width: 92.5,
                                                            child: ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0xff29844B),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0),
                                                                  ),
                                                                ),
                                                                onPressed: () async {
                                                                  setState(() {
                                                                    isVisitStoreLoading =
                                                                        true;
                                                                  });
                                                                  bool created =
                                                                      false;
                                                                  created = await postController.getPostsById(
                                                                      postController
                                                                          .postModel
                                                                          .data![
                                                                              index]
                                                                          .ownerId,
                                                                      "product");
                                                                  log("${postController.postModel.data![index].ownerId}");
                                                                  if (created) {
                                                                    log("${postController.idPostModel!.data!.length}");
                                                                    Get.to(() =>
                                                                        const UserStore());
                                                                    setState(
                                                                        () {
                                                                      isVisitStoreLoading =
                                                                          false;
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      isVisitStoreLoading =
                                                                          false;
                                                                    });
                                                                  }
                                                                },
                                                                child: isVisitStoreLoading
                                                                    ? Container(
                                                                        height: 15,
                                                                        width: 15,
                                                                        child: const CircularProgressIndicator(
                                                                          color:
                                                                              Colors.white,
                                                                        ))
                                                                    : const Text('Visit Store', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //     height: 45,
                                                  //     width:
                                                  //         MediaQuery.of(context)
                                                  //                 .size
                                                  //                 .width *
                                                  //             0.01,
                                                  //     child: ListView.builder(
                                                  //         itemCount: 2,
                                                  //         itemBuilder:
                                                  //             (BuildContext
                                                  //                     context,
                                                  //                 int index) {
                                                  //           return CommentWidget(
                                                  //             userName:
                                                  //                 "Za Khiing",
                                                  //             userComment: postController
                                                  //                     .postModel
                                                  //                     .data![
                                                  //                         index]
                                                  //                     .product!
                                                  //                     .comments![index]! ??
                                                  //                 "Nuffin",
                                                  //           );
                                                  //         })),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                    //height: 43,
                                                    child: TextField(
                                                        // expands: true,
                                                        minLines: null,
                                                        maxLines: null,
                                                        controller:
                                                            commentController,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon: InkWell(
                                                              onTap: () {
                                                                log("Commentted");
                                                              },
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            15.0),
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    bool
                                                                        commented;
                                                                    setState(
                                                                        () {
                                                                      isCommentLoading =
                                                                          true;
                                                                    });
                                                                    commented = await postController.makeComment(
                                                                        postController
                                                                            .postModel
                                                                            .data![
                                                                                index]
                                                                            .product!
                                                                            .id!,
                                                                        commentController
                                                                            .text,
                                                                        context);
                                                                    if (commented) {
                                                                      commentController
                                                                          .clear();
                                                                      setState(
                                                                          () {
                                                                        isCommentLoading =
                                                                            false;
                                                                      });
                                                                    } else {
                                                                      setState(
                                                                          () {
                                                                        isCommentLoading =
                                                                            false;
                                                                      });
                                                                    }
                                                                  },
                                                                  child: isCommentLoading
                                                                      ? Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              15.0),
                                                                          child: Container(
                                                                              height: 25,
                                                                              width: 25,
                                                                              child: const CircularProgressIndicator(
                                                                                color: Color.fromRGBO(41, 132, 75, 1),
                                                                              )),
                                                                        )
                                                                      : const Text('Post',
                                                                          style: TextStyle(
                                                                            color:
                                                                                greenColor,
                                                                          )),
                                                                ),
                                                              )),
                                                          hintText:
                                                              'Add a comment',
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          focusedBorder:
                                                              const OutlineInputBorder(
                                                            //<-- SEE HERE
                                                            borderSide: BorderSide(
                                                                width: 2,
                                                                color:
                                                                    greenColor),
                                                          ),
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: const Divider(
                                                      thickness: 2,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      ),
                                      sizeVer(10),
                                      !loading
                                          ? Container(height: 1)
                                          : const SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: CircularProgressIndicator(
                                                color: Color.fromRGBO(
                                                    41, 132, 75, 1),
                                              ))
                                    ],
                                  ),
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

  Future<void> _makeComment(context, int index) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: const Color(0xffF9F9F9),
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Text(
                        'Comments',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                FutureBuilder<bool>(
                  future: postController.getCommentsForPost(
                    "${postController.postModel.data![index].product!.id}",
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator(
                                color: Color.fromRGBO(41, 132, 75, 1),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError || !snapshot.data!) {
                      return const Text('Failed to load comments.');
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: ListView.builder(
                          itemCount:
                              postController.commentModel!.comments?.length ??
                                  0,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 8),
                              child: Row(children: [
                                postController.commentModel != null &&
                                        (postController
                                                    .commentModel!.comments !=
                                                null ||
                                            postController.commentModel!
                                                .comments!.isNotEmpty)
                                    ? (postController
                                                .commentModel!
                                                .comments![index]
                                                .image
                                                ?.isNotEmpty ??
                                            true)
                                        ? Container(
                                            height: 25,
                                            width: 25,
                                            child: ClipOval(
                                              child: getImageWidget(
                                                "${postController.commentModel!.comments![index].image}",
                                              ),
                                            ),
                                          )
                                        : Obx(() {
                                            return Container(
                                              height: 25,
                                              width: 25,
                                              child: ClipOval(
                                                child: FadeInImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    "${postController.commentModel!.comments![index].image}",
                                                  ),
                                                  placeholder: const AssetImage(
                                                    "assets/images/gonanas_profile.png",
                                                  ),
                                                ),
                                              ),
                                            );
                                          })
                                    : Container(),
                                // Handle the case when userModel.value is null
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                postController.commentModel != null &&
                                        (postController
                                                    .commentModel!.comments !=
                                                null &&
                                            postController.commentModel!
                                                .comments!.isNotEmpty)
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Text(
                                          postController.commentModel!
                                                  .comments![index].username ??
                                              '',
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Flexible(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                      ),
                                      postController.commentModel != null &&
                                              (postController.commentModel!
                                                          .comments !=
                                                      null &&
                                                  postController.commentModel!
                                                      .comments!.isNotEmpty)
                                          ? Text(
                                              "${postController.commentModel!.comments![index].comment}")
                                          : Container()
                                    ],
                                  ),
                                ),
                              ]),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CommentWidget extends StatelessWidget {
  final String userName;
  final String userComment;
  const CommentWidget({
    super.key,
    required this.userName,
    required this.userComment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Daniel Cho',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
        sizeHor(8),
        const Text('I love these',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400))
      ],
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
        Get.to(() => const StoryView());
      },
      child: Container(
        height: 67,
        width: 67,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff29844B),
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
        Get.to(() => const StoryView());
      },
      child: Container(
        height: 67,
        width: 67,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff29844B),
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
