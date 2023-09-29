import 'package:flutter/material.dart';

class StoryView extends StatelessWidget {
  const StoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Image.asset(
                        height: 30,
                        width: 30,
                        "assets/images/john_david_photo.png"),
                    title: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "John David",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Vegetable farmer",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(height: 100),
                  Image.asset(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.8,
                      "assets/images/male_farmer.png"),
                ],
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 6,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: TextField(
                                autofocus: false,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Add comment",
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                          ),
                          Flexible(
                              flex: 1,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(color: Colors.white, Icons.send)))
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          size: 30,
                          Icons.favorite_border,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
