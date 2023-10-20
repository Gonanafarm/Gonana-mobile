import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/controllers/fiat_wallet/transaction_controller.dart';
import 'package:gonana/features/controllers/user/user_controller.dart';
import 'package:gonana/features/presentation/widgets/warning_widget.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/geolocator/geoservices.dart';
import '../../../controllers/market/market_controllers.dart';
import '../store/store_add_poduct.dart';
import '../store/store_logistics.dart';
import '../store/store_view-product.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  final marketController = Get.put(ProductController());
  final userController = Get.find<UserController>();
  TransactionController transactionController =
      Get.put(TransactionController());
  bool? BVNisSubmited = false;
  getBVNStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BVNisSubmited = prefs.getBool('bvnSubmission');
    if (BVNisSubmited == null) {
      BVNisSubmited = false;
    }
  }

  @override
  void initState() {
    super.initState();
    getBVNStatus();
  }

  String produceImage =
      'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Ffarm-produce&psig=AOvVaw3UESSS4OmdGAYQoRSD5Nmd&ust=1683293590093000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCNC2o7bj2_4CFQAAAAAdAAAAABAE';
  @override
  Widget build(BuildContext context) {
    // var userModelPost = marketController.userMarketModel!.data;
    return Center(
      child: Column(children: [
        //White button
        Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
          ),
          child: SizedBox(
            // width: 342,
            height: 56,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: () async {
                  print(BVNisSubmited);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  BVNisSubmited = prefs.getBool('bvnSubmission');
                  if (userController.userModel.value.virtualAccountNumber !=
                      null) {
                    Get.to(() => AddProduct());
                  } else if ((userController
                              .userModel.value.virtualAccountNumber ==
                          null) &&
                      BVNisSubmited != null) {
                    if (BVNisSubmited!) {
                      ErrorSnackbar.show(
                          context, "Your BVN is awaiting verification");
                    } else {
                      ErrorSnackbar.show(context,
                          "Please kindly go to verifications and submit your BVN for verification to create your virtual account ");
                    }
                  }
                },
                child: const Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add Product',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.add,
                          color: Colors.black,
                        )
                      ]),
                )),
          ),
        ),
        sizeVer(10),
        (BVNisSubmited != null && BVNisSubmited!) ||
                (userController.userModel != null &&
                    userController.userModel.value.virtualAccountNumber !=
                        null &&
                    userController
                        .userModel.value.virtualAccountNumber!.isNotEmpty)
            ? Container(height: 1)
            : WarningWidget(),
        marketController.userMarketModel == null ||
                marketController.userMarketModel?.data == null ||
                marketController.userMarketModel!.data!.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sizeVer(MediaQuery.of(context).size.height * 0.05),
                    SvgPicture.asset(
                      "assets/svgs/user_product_empty.svg",
                      width: 189.71,
                      height: 156.03,
                    ),
                    const Text(
                      'Product you Post will\nappear here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'Refresh your network or switch to\nyour wifi.',
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
              )
            : Container(
                height: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount:
                        marketController.userMarketModel?.data?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return marketController.userMarketModel!.data!.isNotEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  // width: MediaQuery.of(context).size.width * 0.8,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            width: 129,
                                            height: 108,
                                            child: Image.network(marketController
                                                            .userMarketModel!
                                                            .data![index] !=
                                                        [] &&
                                                    marketController
                                                        .userMarketModel!
                                                        .data![index]
                                                        .images!
                                                        .isNotEmpty
                                                ? "${marketController.userMarketModel!.data![index].images![0]}"
                                                : produceImage)),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${marketController.userMarketModel!.data![index].body}',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff444444)),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  "NGN ${marketController.userMarketModel!.data![index].amount}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff29844B)),
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
                                                          FutureBuilder<
                                                              String?>(
                                                            future: marketController
                                                                .userProductAddress(
                                                                    index),
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot<
                                                                        String?>
                                                                    snapshot) {
                                                              if (snapshot
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .waiting) {
                                                                return CircularProgressIndicator();
                                                              } else if (snapshot
                                                                  .hasError) {
                                                                return Text(
                                                                    "Error: ${snapshot.error}");
                                                              } else {
                                                                return Text(
                                                                    snapshot.data ??
                                                                        "");
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 40,
                                                        width: 55,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            Get.to(() =>
                                                                StoreViewProducts(
                                                                  index: index,
                                                                  userPostModel:
                                                                      marketController
                                                                          .userMarketModel!
                                                                          .data![index],
                                                                ));
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                const Color(
                                                                    0xff29844B),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                          ),
                                                          child: const Center(
                                                            child: Text(
                                                              "View",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xffFFFFFF)),
                                                            ),
                                                          ),
                                                        ),
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
                            )
                          : Container(
                              child: Text("No Data"),
                            );
                    }),

                // SingleChildScrollView(
                //   child: Column(
                //     children: [
                //       SizedBox(
                //         // width: MediaQuery.of(context).size.width * 0.8,
                //         child: Padding(
                //           padding: const EdgeInsets.only(top: 20.0),
                //           child: Row(
                //             children: [
                //               SizedBox(
                //                   width: 129,
                //                   height: 108,
                //                   child: Image.asset("assets/images/image 6.png")),
                //               Flexible(
                //                 child: Column(
                //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       'The product is natural with no chemicals, planted, and freshly harvested from farm with no artificial processing.',
                //                       style: TextStyle(
                //                           fontSize: 12,
                //                           fontWeight: FontWeight.w400,
                //                           color: Color(0xff444444)),
                //                     ),
                //                     SizedBox(height: 10),
                //                     Text(
                //                       "NGN 10,000",
                //                       style: TextStyle(
                //                           fontSize: 16,
                //                           fontWeight: FontWeight.w600,
                //                           color: Color(0xff29844B)),
                //                     ),
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Column(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceEvenly,
                //                           children: [
                //                             Text(
                //                               "NGN 30,000",
                //                               style: TextStyle(
                //                                   decoration:
                //                                       TextDecoration.lineThrough,
                //                                   fontSize: 10,
                //                                   fontWeight: FontWeight.w400,
                //                                   color: Color(0xff444444)),
                //                             ),
                //                             Text(
                //                               "Plateau state",
                //                               style: TextStyle(
                //                                   fontSize: 10,
                //                                   fontWeight: FontWeight.w400,
                //                                   color: Color(0xff444444)),
                //                             ),
                //                           ],
                //                         ),
                //                         Container(
                //                           height: 40,
                //                           width: 55,
                //                           child: ElevatedButton(
                //                             onPressed: () {
                //                               Get.to(() => StoreViewProducts());
                //                             },
                //                             style: ElevatedButton.styleFrom(
                //                               backgroundColor:
                //                                   const Color(0xff29844B),
                //                               shape: RoundedRectangleBorder(
                //                                 borderRadius:
                //                                     BorderRadius.circular(5.0),
                //                               ),
                //                             ),
                //                             child: Center(
                //                               child: Text(
                //                                 "View",
                //                                 style: TextStyle(
                //                                     fontSize: 10,
                //                                     fontWeight: FontWeight.w400,
                //                                     color: Color(0xffFFFFFF)),
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       ],
                //                     )
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //
                //     ],
                //   ),
                // ),
              )
      ]),
    );
  }
}
