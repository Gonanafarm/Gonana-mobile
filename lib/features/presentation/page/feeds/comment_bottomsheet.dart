import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/widgets.dart';

comment(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            color: const Color(0xffF1F1F1),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.close, color: Colors.black),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        ListTile(
                          leading: Image.asset(
                              height: 30,
                              width: 30,
                              "assets/images/john_david_photo.png"),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "John David",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Vegetable farmer",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ],
                          ),
                          trailing: SizedBox(
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
                        ),
                        CommentContainers(
                            name: 'Daniel Cho', text: 'I love these'),
                        CommentContainers(
                            name: 'John Donny',
                            text: '@John david can i get this for NGN200?'),
                        CommentContainers(
                            name: 'Amos Choji', text: 'Wow amazing harvest'),
                        CommentContainers(
                            name: 'Nambam Joseph',
                            text: 'Where is your farm located'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text('Daniel jim and 38 others',
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(height: 5),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    icon: const Icon(
                                        size: 30, Icons.favorite_outline),
                                    onPressed: () {}),
                                GestureDetector(
                                  onTap: () {},
                                  child: SvgPicture.asset(
                                    "assets/svgs/emails_messages_icon.svg",
                                    width: 45,
                                    height: 30,
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {},
                                  child: SvgPicture.asset(
                                    "assets/svgs/send_icon.svg",
                                    width: 45,
                                    height: 30,
                                  ),
                                ),
                              ]),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: TextField(
                                        autofocus: false,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Add comment",
                                            hintStyle: TextStyle(
                                                color: Color(0xff444444),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.send)))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
      });
}

class CommentContainers extends StatelessWidget {
  final String name;
  final String text;
  const CommentContainers({Key? key, required this.name, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
                fit: BoxFit.cover,
                height: 30,
                width: 30,
                "assets/images/story_profile_photo.png"),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RichText(
                  text: TextSpan(
                      text: name,
                      style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                            text: text,
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 12,
                                fontWeight: FontWeight.w400))
                      ]),
                ),
              ),
              SizedBox(width: 5),
              Text(
                "8h ago",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          trailing: Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(size: 30, Icons.favorite_border_outlined),
              ),
              // SizedBox(height: 5),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text(
                "5 likes  1 reply",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 1),
              Text(
                "view replies",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
