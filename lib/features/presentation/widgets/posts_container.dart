import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../controllers/post/post_controllers.dart';
import '../page/feeds/share_post_bottomsheet.dart';

class PostsContainer extends StatefulWidget {
  final Function shareFunction;
  const PostsContainer({Key? key, required this.shareFunction})
      : super(key: key);

  @override
  State<PostsContainer> createState() => _PostsContainerState();
}

class _PostsContainerState extends State<PostsContainer> {
  final postController = Get.find<PostController>();
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
    TextEditingController controller = TextEditingController();
    return Center(
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
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  leading: Image.asset(
                      height: 30,
                      width: 30,
                      "assets/images/john_david_photo.png"),
                  title: const Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "John David",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Vegetable farmer",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 15),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          "8h ago",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  trailing: const Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: Icon(Icons.more_horiz),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 10, 10),
                child: RichText(
                  text: const TextSpan(
                    text:
                        'We just had the best harvest every, get your fresh, nice to vegetables while they last ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Read more.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff29844B),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                // height: 340,
                width: 340,
                child: Image.asset("assets/images/female_farmer.png"),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Daniel jim and 38 others',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w400)),
                      Text('12 Comments',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w400))
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                icon: const Icon(
                                    size: 30, Icons.favorite_outline),
                                onPressed: () {}),
                            SvgPicture.asset(
                              "assets/svgs/emails_messages_icon.svg",
                              width: 45,
                              height: 30,
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                widget.shareFunction;
                              },
                              child: SvgPicture.asset(
                                "assets/svgs/send_icon.svg",
                                width: 45,
                                height: 30,
                              ),
                            ),
                          ]),
                      //Like and Visit Store
                      SizedBox(
                        height: 30,
                        width: 92.5,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff29844B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text('Visit Store',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600))),
                      ),
                    ]),
              ),
              //Comment section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                            text: 'Daniel Cho',
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                  text: ' I love these',
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400))
                            ]),
                      ),
                      RichText(
                        text: const TextSpan(
                            text: 'John Donny',
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                  text:
                                      ' @john david Can i get these for NGN 2000 ?',
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400))
                            ]),
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10.0), // Set the desired border radius
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  child: Center(
                    child: TextField(
                      controller: controller,
                      autofocus: false,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Add a comment",
                          hintStyle: TextStyle(
                              color: Color(0xff444444),
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
