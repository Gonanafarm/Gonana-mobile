import 'dart:ui';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/controllers/order/order_controller.dart';
import 'package:gonana/features/data/models/get_order_model.dart';
import 'package:gonana/features/presentation/page/market/cart_page.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../../consts.dart';
import '../home.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  late Future<bool> fetchData;
  late Future<bool> fetchData2;
  OrderController getOrdersController = Get.find<OrderController>();
  @override
  void initState() {
    super.initState();
    fetchData = getOrdersController.getOrders();
    fetchData2 = getOrdersController.getOutGoingOrders();
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
                                  orderController.getOrderModel.value.data !=
                                              null &&
                                          orderController.getOrderModel.value
                                              .data!.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: orderController
                                              .getOrderModel.value.data!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                                  "${orderController.getOrderModel.value.data![index].image![0]}")),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          10.0),
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
                                                                      Flexible(
                                                                        child:
                                                                            Text(
                                                                          '${orderController.getOrderModel.value.data![index].productName}',
                                                                          style: const TextStyle(
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Colors.black),
                                                                        ),
                                                                      ),
                                                                      sizeHor(
                                                                          5),
                                                                      Flexible(
                                                                        child:
                                                                            Text(
                                                                          '${orderController.getOrderModel.value.data![index].status}',
                                                                          style:
                                                                              TextStyle(
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            color: orderController.getOrderModel.value.data![index].status == "pending"
                                                                                ? Colors.yellow.shade700
                                                                                : Color(0xFF31DE72),
                                                                            fontSize:
                                                                                14,
                                                                            fontFamily:
                                                                                'Proxima Nova',
                                                                            fontWeight:
                                                                                FontWeight.w800,
                                                                          ),
                                                                        ),
                                                                      )
                                                                      // orderController.getOrderModel.value.data![index].selfShipping ??
                                                                      //         false
                                                                      //     ? Flexible(
                                                                      //         child: Text(
                                                                      //           'Confirm order',
                                                                      //           style: TextStyle(
                                                                      //             overflow: TextOverflow.ellipsis,
                                                                      //             color: Color(0xFF31DE72),
                                                                      //             fontSize: 14,
                                                                      //             fontFamily: 'Proxima Nova',
                                                                      //             fontWeight: FontWeight.w800,
                                                                      //           ),
                                                                      //         ),
                                                                      //       )
                                                                      //     : Container()
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    'X${orderController.getOrderModel.value.data![index].quantity}',
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
                                                                    '${orderController.getOrderModel.value.data![index].productDescription}',
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
                                                                      height:
                                                                          10),
                                                                  Text(
                                                                    "NGN ${orderController.getOrderModel.value.data![index].productAmount}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Color(
                                                                            0xff29844B)),
                                                                  ),
//                                                                   Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     children: [
//                                                                       Flexible(
//                                                                         child:
//                                                                             Column(
//                                                                           mainAxisAlignment:
//                                                                               MainAxisAlignment.spaceEvenly,
//                                                                           children: [
// // Text(
// //   "NGN 30,000",
// //   style: TextStyle(
// //       decoration:
// //           TextDecoration.lineThrough,
// //       fontSize: 10,
// //       fontWeight: FontWeight.w400,
// //       color: Color(0xff444444)),
// // ),
// // FutureBuilder<
// //     String?>(
// //   future: marketController
// //       .userProductAddress(
// //       index),
// //   builder: (BuildContext
// //   context,
// //       AsyncSnapshot<
// //           String?>
// //       snapshot) {
// //     if (snapshot
// //         .connectionState ==
// //         ConnectionState
// //             .waiting) {
// //       return CircularProgressIndicator();
// //     } else if (snapshot
// //         .hasError) {
// //       return Text(
// //           "Error: ${snapshot.error}");
// //     } else {
// //       return Text(
// //           snapshot.data ??
// //               "");
// //     }
// //   },
// // ),
// //                                                                         Row(
// //                                                                           mainAxisAlignment:
// //                                                                               MainAxisAlignment.spaceBetween,
// //                                                                           children: [
// //                                                                             Text("Plateau state"),
// //                                                                           ],
// //                                                                         )
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   )
                                                                  sizeVer(10),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      TinyButton(
                                                                        isLoading:
                                                                            false,
                                                                        title:
                                                                            "Complain",
                                                                        onPressed:
                                                                            () async {
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            barrierDismissible:
                                                                                true, // Set to true if you want to allow dismissing the dialog by tapping outside it
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              bool isLoadingComplain = false;
                                                                              return BackdropFilter(
                                                                                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Adjust the blur intensity as needed
                                                                                child: Container(
                                                                                  // height: 100,
                                                                                  child: StatefulBuilder(builder: (context, setState) {
                                                                                    return AlertDialog(
                                                                                      title: const Center(
                                                                                        child: Icon(
                                                                                          size: 60,
                                                                                          Icons.warning_amber,
                                                                                          color: redColor,
                                                                                        ),
                                                                                      ),
                                                                                      content: Padding(
                                                                                        padding: EdgeInsets.only(left: 0.0),
                                                                                        child: Container(
                                                                                          height: 80,
                                                                                          child: const Column(
                                                                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Center(
                                                                                                child: Text(
                                                                                                  'Note: You are prompting for this because you haven\'t received this item in 5 days?',
                                                                                                  textAlign: TextAlign.center,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      actions: [
                                                                                        Center(
                                                                                            child: DialogGradientButton(
                                                                                                color: const LinearGradient(colors: [Colors.red, Colors.redAccent]),
                                                                                                title: 'Proceed',
                                                                                                onPressed: () async {
                                                                                                  setState(() {
                                                                                                    isLoadingComplain = true;
                                                                                                  });
                                                                                                  bool success = await orderController.complain(orderController.getOrderModel.value.data![index].id, context);
                                                                                                  if (success) {
                                                                                                    setState(() {
                                                                                                      isLoadingComplain = false;
                                                                                                    });
                                                                                                    Navigator.pop(context);
                                                                                                  } else {
                                                                                                    setState(() {
                                                                                                      isLoadingComplain = false;
                                                                                                    });
                                                                                                    Navigator.pop(context);
                                                                                                  }
                                                                                                },
                                                                                                isLoading: isLoadingComplain)),
                                                                                        // Padding(
                                                                                        //   padding: const EdgeInsets.only(bottom: 10, top: 20),
                                                                                        //   child: Center(
                                                                                        //     child: DialogWhiteButton(
                                                                                        //       title: 'No, go back',
                                                                                        //       onPressed: () {
                                                                                        //         Get.back();
                                                                                        //       },
                                                                                        //     ),
                                                                                        //   ),
                                                                                        // ),
                                                                                      ],
                                                                                    );
                                                                                  }),
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        borderColor:
                                                                            true,
                                                                        textColor:
                                                                            Colors.redAccent,
                                                                      ),
                                                                      TinyButton(
                                                                        isLoading:
                                                                            false,
                                                                        title:
                                                                            "Received?",
                                                                        onPressed:
                                                                            () async {
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            barrierDismissible:
                                                                                true, // Set to true if you want to allow dismissing the dialog by tapping outside it
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              bool isLoadingReceived = false;
                                                                              return BackdropFilter(
                                                                                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Adjust the blur intensity as needed
                                                                                child: Container(
                                                                                  height: 100,
                                                                                  child: StatefulBuilder(builder: (context, setState) {
                                                                                    return AlertDialog(
                                                                                      title: const Center(
                                                                                        child: Icon(
                                                                                          size: 60,
                                                                                          Icons.check,
                                                                                          color: greenColor,
                                                                                        ),
                                                                                      ),
                                                                                      content: Padding(
                                                                                        padding: EdgeInsets.only(left: 0.0),
                                                                                        child: Container(
                                                                                          height: 80,
                                                                                          child: const Column(
                                                                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Center(
                                                                                                child: Text(
                                                                                                  'Note: You are prompting this to confirm that you have received this item',
                                                                                                  textAlign: TextAlign.center,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      actions: [
                                                                                        Center(
                                                                                            child: DialogGradientButton(
                                                                                          title: "Proceed",
                                                                                          onPressed: () async {
                                                                                            setState(() {
                                                                                              isLoadingReceived = true;
                                                                                            });
                                                                                            bool success = await orderController.confirmOrderReceived(orderController.getOrderModel.value.data![index].id, context);
                                                                                            if (success) {
                                                                                              setState(() {
                                                                                                isLoadingReceived = false;
                                                                                              });
                                                                                              Navigator.pop(context);
                                                                                            } else {
                                                                                              setState(() {
                                                                                                isLoadingReceived = false;
                                                                                              });
                                                                                              Navigator.pop(context);
                                                                                            }
                                                                                          },
                                                                                          isLoading: isLoadingReceived,
                                                                                        )),
                                                                                        // Padding(
                                                                                        //   padding: const EdgeInsets.only(bottom: 10, top: 20),
                                                                                        //   child: Center(
                                                                                        //     child: DialogWhiteButton(
                                                                                        //       title: 'No, go back',
                                                                                        //       onPressed: () {
                                                                                        //         Get.back();
                                                                                        //       },
                                                                                        //     ),
                                                                                        //   ),
                                                                                        // ),
                                                                                      ],
                                                                                    );
                                                                                  }),
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        borderColor:
                                                                            false,
                                                                        textColor:
                                                                            Colors.white,
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
                                          })
                                      : Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              sizeVer(MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1),
                                              SvgPicture.asset(
                                                "assets/svgs/empty_product.svg",
                                                width: 189.71,
                                                height: 156.03,
                                              ),
                                              const Text(
                                                'Sorry! no product bought yet',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                  fontFamily: 'Proxima Nova',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const Text(
                                                'All bought products would be visible here',
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
                                  orderController.getOutGoingOrderModel.value
                                                  .data !=
                                              null &&
                                          orderController.getOutGoingOrderModel
                                              .value!.data!.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: orderController
                                              .getOutGoingOrderModel
                                              .value!
                                              .data!
                                              .length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                                  "${orderController.getOutGoingOrderModel.value!.data![index].image![0]}")),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          10.0),
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
                                                                        '${orderController.getOutGoingOrderModel.value!.data![index].productName}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: Colors.black),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    'X${orderController.getOutGoingOrderModel.value!.data![index].quantity}',
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
                                                                    '${orderController.getOutGoingOrderModel.value!.data![index].productDescription}',
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
                                                                      height:
                                                                          10),
                                                                  Text(
                                                                    "NGN ${orderController.getOutGoingOrderModel.value!.data![index].productAmount}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Color(
                                                                            0xff29844B)),
                                                                  ),
//                                                                   Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     children: [
//                                                                       Flexible(
//                                                                         child:
//                                                                             Column(
//                                                                           mainAxisAlignment:
//                                                                               MainAxisAlignment.spaceEvenly,
//                                                                           children: [
// // Text(
// //   "NGN 30,000",
// //   style: TextStyle(
// //       decoration:
// //           TextDecoration.lineThrough,
// //       fontSize: 10,
// //       fontWeight: FontWeight.w400,
// //       color: Color(0xff444444)),
// // ),
// // FutureBuilder<
// //     String?>(
// //   future: marketController
// //       .userProductAddress(
// //       index),
// //   builder: (BuildContext
// //   context,
// //       AsyncSnapshot<
// //           String?>
// //       snapshot) {
// //     if (snapshot
// //         .connectionState ==
// //         ConnectionState
// //             .waiting) {
// //       return CircularProgressIndicator();
// //     } else if (snapshot
// //         .hasError) {
// //       return Text(
// //           "Error: ${snapshot.error}");
// //     } else {
// //       return Text(
// //           snapshot.data ??
// //               "");
// //     }
// //   },
// // ),
// //                                                                         Row(
// //                                                                           mainAxisAlignment:
// //                                                                               MainAxisAlignment.spaceBetween,
// //                                                                           children: [
// //                                                                             Text("Plateau state"),
// //                                                                           ],
// //                                                                         )
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   )
                                                                  sizeVer(10),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      TinyButton(
                                                                        title:
                                                                            "Sent order?",
                                                                        onPressed:
                                                                            () async {
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            barrierDismissible:
                                                                                true, // Set to true if you want to allow dismissing the dialog by tapping outside it
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              bool isLoadingSent = false;
                                                                              return BackdropFilter(
                                                                                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Adjust the blur intensity as needed
                                                                                child: Container(
                                                                                  height: 100,
                                                                                  child: StatefulBuilder(builder: (context, setState) {
                                                                                    return AlertDialog(
                                                                                      title: const Center(
                                                                                        child: Icon(
                                                                                          size: 60,
                                                                                          Icons.check,
                                                                                          color: greenColor,
                                                                                        ),
                                                                                      ),
                                                                                      content: Padding(
                                                                                        padding: EdgeInsets.only(left: 0.0),
                                                                                        child: Container(
                                                                                          height: 80,
                                                                                          child: const Column(
                                                                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Center(
                                                                                                child: Text(
                                                                                                  'Note: You are prompting this to confirm that you have sent this item',
                                                                                                  textAlign: TextAlign.center,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      actions: [
                                                                                        Center(
                                                                                            child: DialogGradientButton(
                                                                                          title: "Proceed",
                                                                                          onPressed: () async {
                                                                                            setState(() {
                                                                                              isLoadingSent = true;
                                                                                            });
                                                                                            bool success = await orderController.confirmOrderSent(orderController.getOutGoingOrderModel.value.data![index].id, context);
                                                                                            if (success) {
                                                                                              setState(() {
                                                                                                isLoadingSent = false;
                                                                                              });
                                                                                              Navigator.pop(context);
                                                                                            } else {
                                                                                              setState(() {
                                                                                                isLoadingSent = false;
                                                                                              });
                                                                                              Navigator.pop(context);
                                                                                            }
                                                                                          },
                                                                                          isLoading: isLoadingSent,
                                                                                        )),
                                                                                        // Padding(
                                                                                        //   padding: const EdgeInsets.only(bottom: 10, top: 20),
                                                                                        //   child: Center(
                                                                                        //     child: DialogWhiteButton(
                                                                                        //       title: 'No, go back',
                                                                                        //       onPressed: () {
                                                                                        //         Get.back();
                                                                                        //       },
                                                                                        //     ),
                                                                                        //   ),
                                                                                        // ),
                                                                                      ],
                                                                                    );
                                                                                  }),
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        borderColor:
                                                                            false,
                                                                        textColor:
                                                                            Colors.white,
                                                                        isLoading:
                                                                            false,
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
                                          })
                                      : Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                sizeVer(MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1),
                                                SvgPicture.asset(
                                                  "assets/svgs/empty_product.svg",
                                                  width: 189.71,
                                                  height: 156.03,
                                                ),
                                                const Text(
                                                  'Sorry! non of your products have been bought yet ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 24,
                                                    fontFamily: 'Proxima Nova',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const Text(
                                                  'All bought products would be visible here',
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
