import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../consts.dart';
import '../../widgets/search_page.dart';
import 'chats.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final TextEditingController _searchController = TextEditingController();
  String get searchItem => _searchController.text;
  List name = ["Jake Doe", "Madam Loe"];
  List image = ["story_profile_photo", "john_david_photo"];
  List message = [
    "Hello i need those chickens",
    "I bough some corn from you last year... jsdbsdahknsdhsndnjk asdasdasadsdds"
  ];
  List time = ["10: 24 PM", "09: 34 PM"];
  List messageIndicator = [
    Container(),
    Container(
      width: 30,
      height: 30,
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Color(0xFF29844B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Center(
        child: Text(
          '1',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontFamily: 'Proxima Nova',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Messages',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Proxima Nova',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              SearchWidget(
                  controller: _searchController, onChanged: (searchItem) {}),
              SizedBox(height: 20),
              SizedBox(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: name.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => Chats());
                            },
                            child: MessageTile(
                              name: name[index],
                              message: message[index],
                              time: time[index],
                              image: image[index],
                              messageIndicator: messageIndicator[index],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Divider(thickness: 1),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String name;
  final String image;
  final String message;
  final String time;
  final Widget messageIndicator;
  const MessageTile(
      {Key? key,
      required this.name,
      required this.message,
      required this.time,
      required this.image,
      required this.messageIndicator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors
                      .transparent, // Set the desired background color or leave it transparent
                ),
                child:
                    ClipOval(child: Image.asset('assets/images/$image.png'))),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(message,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ]),
            ),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  )),
              messageIndicator,
            ],
          )
        ],
      ),
    ));
  }
}
