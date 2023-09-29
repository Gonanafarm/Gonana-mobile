import 'package:flutter/material.dart';
import 'package:gonana/features/presentation/page/messages/chat_bottomsheet.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
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
            children: [
              Expanded(
                  child: ListView(
                children: [
                  const Text(
                    'Mamdam Loe',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Proxima Nova',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Dec 23',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        // height: 55,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF29844B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 20, bottom: 20, left: 10, right: 10),
                          child: Text(
                            'When did you buy the those chickens',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '09: 34 PM',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Today',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        // height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Color(0xFF29844B))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 20, bottom: 20, left: 10, right: 10),
                          child: Text(
                            'Earlier this year',
                            style: TextStyle(
                              color: Color(0xFF29844B),
                              fontSize: 12,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '09: 34 PM',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        // height: 55,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF29844B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 20, bottom: 20, left: 10, right: 10),
                          child: Text(
                            'I bought some corn from you last yeear. Do you remember?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '09: 34 PM',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 9,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              const Flexible(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: TextField(
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Type here",
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
                                      onPressed: () {}, icon: Icon(Icons.send)))
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {
                              chat(context);
                            },
                            icon: Icon(Icons.add_circle_outline)),
                      )
                    ],
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
