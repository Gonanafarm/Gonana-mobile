import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../home.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 20,
              color: Color(0xff292D32),
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Column(
                children: [
                  Center(
                    child: ButtonsTabBar(
                      backgroundColor: Color(0xff29844B),
                      unselectedBackgroundColor: Color(0xffF1F1F1),
                      unselectedLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                      tabs: const [
                        Tab(
                          text: "Incoming orders",
                        ),
                        Tab(
                          text: "Outgoing orders",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: TabBarView(
                      children: [
                        ListView.builder(
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  children: [
                                    SizedBox(
// width: MediaQuery.of(context).size.width * 0.8,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                width: 129,
                                                height: 108,
                                                child: Image.asset(
                                                    "assets/images/image 5.png")),
                                            Flexible(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Bag of corn',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Text(
                                                          'Complete',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF31DE72),
                                                            fontSize: 12.04,
                                                            fontFamily:
                                                                'Proxima Nova',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                      width: 150,
                                                      child: Text(
                                                        'The product is natural with',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xff444444)),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      "NGN 10,000",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color(
                                                              0xff29844B)),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
// Text(
//   "NGN 30,000",
//   style: TextStyle(
//       decoration:
//           TextDecoration.lineThrough,
//       fontSize: 10,
//       fontWeight: FontWeight.w400,
//       color: Color(0xff444444)),
// ),
// FutureBuilder<
//     String?>(
//   future: marketController
//       .userProductAddress(
//       index),
//   builder: (BuildContext
//   context,
//       AsyncSnapshot<
//           String?>
//       snapshot) {
//     if (snapshot
//         .connectionState ==
//         ConnectionState
//             .waiting) {
//       return CircularProgressIndicator();
//     } else if (snapshot
//         .hasError) {
//       return Text(
//           "Error: ${snapshot.error}");
//     } else {
//       return Text(
//           snapshot.data ??
//               "");
//     }
//   },
// ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "Plateau state"),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        Center(
                          child: Icon(Icons.directions_transit),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
