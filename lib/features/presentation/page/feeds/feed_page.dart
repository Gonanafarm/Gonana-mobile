// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/post/post_controllers.dart';
import 'package:gonana/features/data/models/post_model.dart';
import 'package:gonana/features/presentation/page/feeds/story_view.dart';
import 'package:gonana/features/presentation/page/feeds/user_store.dart';
import 'package:gonana/features/presentation/page/market/cart_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final TextEditingController commentController = TextEditingController();
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
  }

  bool postLiked = false;
  final Map<int, bool> isPostLiked = {};

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
                              (BVNisSubmited != null && BVNisSubmited!) || (userController.userModel != null &&
                                userController.userModel.value.virtualAccountNumber != null &&
                                userController.userModel.value.virtualAccountNumber!.isNotEmpty
                              ) ? Container(height: 1) : const WarningWidget(),
                              sizeVer(MediaQuery.of(context).size.height * 0.1),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                (userController.userModel != null && userController.userModel.value.virtualAccountNumber != null &&
                                  userController.userModel.value.virtualAccountNumber!.isNotEmpty
                                ) ? Container(height: 1) : const WarningWidget(),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.7,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          controller: scrollController,
                                          itemCount: postController.postModel.data!.length,
                                          // itemCount: postModel.body!.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            final reversedIndex = (postController.postModel!.data!.length - 1) - index;
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  //Posters name and profile pic
                                                  // height: 40,
                                                  child: ListTile(
                                                    contentPadding:const EdgeInsets.symmetric(horizontal: 15.0),
                                                    leading: postController.postModel.data?[index]?.ownerPhoto?.isEmpty ??
                                                      true
                                                      ? Container(
                                                          height: 30,
                                                          width: 30,
                                                          child: ClipOval(
                                                            child: getImageWidget(postController.postModel.data?[index]?.ownerPhoto ?? ''),
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 30,
                                                          width: 30,
                                                          child: ClipOval(
                                                            child: FadeInImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                postController.postModel.data?[index] ?.ownerPhoto ?? '',
                                                              ),
                                                              placeholder: const AssetImage("assets/images/gonanas_profile.png"),
                                                            ),
                                                          ),
                                                        ),
                                                    title: Row(
                                                      children: [
                                                        Flexible(
                                                          child: Column(
                                                            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Text(
                                                                postController.postModel.data![index].ownerName!,
                                                                style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w600
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(15.0, 0, 10, 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          text: postController.postModel.data![index].product!.body!.isEmpty ||
                                                            // ignore: unnecessary_null_comparison
                                                            postController.postModel.data![index] == null ||
                                                            postController.postModel == null
                                                              ? " "
                                                              : postController.postModel.data![index].product!.body,
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w400,
                                                            color: Colors.black
                                                          ),
                                                          children: const <TextSpan>[
                                                            TextSpan(
                                                              text: '',
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w400,
                                                                color: Color(0xff29844B),
                                                              )
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.8,
                                                  child: postController.postModel.data![index].product!.images!.isNotEmpty
                                                  ? Image.network(
                                                      postController.postModel.data![index].product!.images![0],
                                                      errorBuilder:(BuildContext context, Object  error, StackTrace? stackTrace) {
                                                        // Handle the error, log it, or show a placeholder image.
                                                        return const Center(
                                                          child: Icon(Icons.error)
                                                        );
                                                      },
                                                    ) 
                                                  : Container()
                                                ),
                                                sizeVer(10),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 90,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                try {
                                                                  var liked = await postController.likePost(
                                                                    postController.postModel.data![index].product!.id);
                                                                  if (liked[0] == true && liked[1] ==true) {
                                                                    setState(() {
                                                                      isPostLiked[index] = true;
                                                                    });
                                                                  } else if (liked[0] == false && liked[1] == true) {
                                                                    log('product was already LIKED');
                                                                    var unlike = await postController.unlikePost(postController.postModel.data![index].product!.id);
                                                                    if (unlike == true) {
                                                                      setState(() {
                                                                        isPostLiked[index] = false;
                                                                      });
                                                                    } else {
                                                                      log('error at line 412 while unliking');
                                                                    }
                                                                  } else {
                                                                    log('error, post not liked');
                                                                  }
                                                                  log('PostID: ${postController.postModel.data![index].product!.id}');
                                                                  log('isPostLiked: $isPostLiked');
                                                                } catch (e, s) {
                                                                  log('FeedspageLikeError: $e');
                                                                  log('FeedspageStack: $s');
                                                                }
                                                              },
                                                              child: isPostLiked[index] == true ? 
                                                                SvgPicture.asset(
                                                                  'assets/svgs/favourite.svg',
                                                                  height: 24,
                                                                  width: 24,
                                                                ): 
                                                                SvgPicture.asset(
                                                                  'assets/svgs/Heart.svg',
                                                                  height: 24,
                                                                  width: 24,
                                                                )
                                                            ),
                                                            InkWell(
                                                              onTap: (){

                                                              },
                                                              child: SvgPicture.asset(
                                                                'assets/svgs/emails_messages_icon.svg',
                                                                height: 24,
                                                                width: 24
                                                              )
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      //Visit Store button
                                                      SizedBox(
                                                        height: 30,
                                                        width: 92.5,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: const Color(0xff29844B),
                                                            shape:RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            bool created = false;
                                                            created = await postController.getPostsById(
                                                              postController.postModel.data![index].ownerId,
                                                              "product"
                                                            );
                                                            log("${postController.postModel.data![index].ownerId}");
                                                            if (created) {
                                                              log("${postController.idPostModel!.data!.length}");
                                                              Get.to(() => const UserStore());
                                                            }
                                                          },
                                                          child: const Text(
                                                            'Visit Store',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w600
                                                            )
                                                          )
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 45,
                                                  child: ListView.builder(
                                                    itemCount: 2,
                                                    itemBuilder: (BuildContext context, int index){
                                                      return CommentWidget(
                                                        userName: "Za Khiing",
                                                        userComment:  postController.postModel.data![index].product!.comments![index]! ?? "Nuffin",
                                                      );
                                                    }
                                                  )
                                                ),
                                                SizedBox(
                                                  width: 342,
                                                  //height: 43,
                                                  child: TextField(
                                                    // expands: true,
                                                    // minLines: null,
                                                    // maxLines: null,
                                                    
                                                    controller: commentController,
                                                    decoration:  InputDecoration(
                                                      suffixIcon: InkWell(
                                                        onTap: (){
                                                          log("Commentted");
                                                        },
                                                        child: const Text('Post',
                                                          style: TextStyle(
                                                            color: greenColor,
                                                          )
                                                        )
                                                      ),
                                                      hintText: 'Add a comment',
                                                      enabledBorder: const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          width: 1, color: Colors.black
                                                        ), 
                                                      ),
                                                      focusedBorder: const OutlineInputBorder( //<-- SEE HERE
                                                        borderSide: BorderSide(
                                                          width: 2, 
                                                          color: greenColor
                                                        ), 
                                                      ),
                                                    )
                                                  ),
                                                ),
                                                const Divider()
                                              ],
                                            );
                                          }
                                        ),
                                      ),
                                      sizeVer(10),
                                      !loading
                                        ? Container(height: 1)
                                        : const SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: CircularProgressIndicator(
                                              color: Color.fromRGBO(41, 132, 75, 1),
                                            )
                                          )
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

  _makeComment(context){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25))
      ),
      backgroundColor: const Color(0xffF9F9F9),
      builder: (BuildContext context){
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Padding(
            padding: EdgeInsets.all(20.0), 
            child: Column(
              children: [
                const Text('Comment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center
                ),
                Divider(),
                Row(
                  children: [
                    TextField(),
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: ElevatedButton.icon(
                        onPressed: (){}, 
                        icon: const Icon(Icons.send), 
                        label: const SizedBox()
                      ),
                    )
                  ],
                )
              ],
            )
          )
        );
      }
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
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700
          )
        ),
        sizeHor(8),
        const Text('I love these',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400
          )
        )
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
