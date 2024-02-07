import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/controllers/order/order_controller.dart';
import 'package:gonana/features/data/models/get_order_model.dart';
import 'package:gonana/features/presentation/page/market/cart_page.dart';

import '../home.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  late Future<bool> fetchData;
  OrderController getOrdersController = Get.find<OrderController>();
  @override
  void initState() {
    super.initState();
    fetchData = getOrdersController.getOrders();
  }

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
                      child: FutureBuilder<bool>(
                          future: fetchData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                color: Colors.white,
                                child: Center(
                                  child: Container(
                                    height: 75,
                                    width: 75,
                                    child: CircularProgressIndicator(
                                      color: Color.fromRGBO(41, 132, 75, 1),
                                    ),
                                  ),
                                ),
                              );
                              // Show a loading indicator while waiting
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.data!) {
                              return Container(
                                color: Colors.white,
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'No network connection. Please check your internet connection.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return TabBarView(
                                children: [
                                  ListView.builder(
                                      itemCount: orderController
                                          .getOrderModel.value.orders!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
// width: MediaQuery.of(context).size.width * 0.8,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20.0),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                          width: 129,
                                                          height: 108,
                                                          child: Image.network(
                                                              "${orderController.getOrderModel.value.orders![index].image![0]}")),
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    '${orderController.getOrderModel.value.orders![index].productName}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  Text(
                                                                    'Confirm order',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFF31DE72),
                                                                      fontSize:
                                                                          15,
                                                                      fontFamily:
                                                                          'Proxima Nova',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Text(
                                                                'X${orderController.getOrderModel.value.orders![index].quantity}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Color(
                                                                        0xff444444)),
                                                              ),
                                                              Text(
                                                                'The product is natural with',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Color(
                                                                        0xff444444)),
                                                              ),
                                                              SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                "NGN ${orderController.getOrderModel.value.orders![index].amount}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xff29844B)),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Flexible(
                                                                    child:
                                                                        Column(
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
//                                                                         Row(
//                                                                           mainAxisAlignment:
//                                                                               MainAxisAlignment.spaceBetween,
//                                                                           children: [
//                                                                             Text("Plateau state"),
//                                                                           ],
//                                                                         )
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
                              );
                            }
                          }))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
