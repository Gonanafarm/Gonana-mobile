import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/data/models/user_post_model.dart';
import 'package:gonana/features/presentation/page/settings/settiings_profile.dart';
import 'package:gonana/features/presentation/page/store/store_edit_product.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../controllers/market/market_controllers.dart';
import '../../widgets/image_slider_discount.dart';
import '../../widgets/image_slider_user.dart';

late Datum imageUserModel;
late Datum usrPostModel;
final marketController = Get.put(ProductController());

class StoreViewProducts extends StatefulWidget {
  final Datum userPostModel;
  final int index;
  const StoreViewProducts(
      {super.key, required this.userPostModel, required this.index});

  @override
  State<StoreViewProducts> createState() => _StoreViewProductsState();
}

class _StoreViewProductsState extends State<StoreViewProducts> {
  CarouselController customCarouselController = CarouselController();
  int activeIndex = 0;
  final cardList = [
    const Card1(),
    const Card2(),
    const Card3(),
  ];

  List<Widget> productRating(int count) {
    List<Widget> svgImages = [];
    for (int i = 0; i < count; i++) {
      const String assetName = 'assets/svgs/rating_star.svg';
      final Widget svg = SvgPicture.asset(
        assetName,
        width: 18,
        height: 18,
      );
      svgImages.add(svg);
    }
    return svgImages;
  }

  String src =
      'https://guardian.ng/wp-content/uploads/2019/08/farm-products.jpg';

  @override
  Widget build(BuildContext context) {
    imageUserModel = widget.userPostModel;
    usrPostModel = widget.userPostModel;
    var userModelPost = widget.userPostModel;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          // actions: <Widget>[
          //   Padding(
          //     padding: const EdgeInsets.only(right: 24),
          //     child: GestureDetector(
          //         onTap: () {},
          //         child: SvgPicture.asset('assets/svgs/send_icon.svg',
          //             height: 24, width: 24, fit: BoxFit.contain)),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.only(right: 24),
          //     child: GestureDetector(
          //         onTap: () {},
          //         child: SvgPicture.asset('assets/svgs/cart_icon.svg',
          //             height: 24, width: 24, fit: BoxFit.contain)),
          //   )
          // ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ImageSliderUserProducts(
                    imageProductModel: widget.userPostModel),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    //Price and location
                    children: [
                      SizedBox(
                        // height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 140,
                              child: RichText(
                                  text: TextSpan(
                                      text: widget.userPostModel!.amount != null
                                          ? "NGN ${widget.userPostModel!.amount}"
                                          : "NGN ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff29844B)),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text: '/Piece',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400))
                                  ])),
                            ),
                            SizedBox(
                              // height: 82,
                              width: 170,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // GestureDetector(
                                  //   onTap: () {},
                                  //   child: SizedBox(
                                  //     height: 24,
                                  //     width: 57,
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         SvgPicture.asset(
                                  //             'assets/svgs/emails_messages_icon.svg',
                                  //             height: 24,
                                  //             width: 24,
                                  //             fit: BoxFit.contain),
                                  //         const Text('Chat',
                                  //             style: TextStyle(
                                  //                 fontSize: 10,
                                  //                 fontWeight: FontWeight.w400))
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Text(
                          //   'Location: ',
                          //   style: TextStyle(
                          //       color: Colors.grey,
                          //       fontSize: 10,
                          //       fontWeight: FontWeight.w600),
                          // ),
                          Flexible(
                            child: Container(
                              child: FutureBuilder<String?>(
                                future: marketController
                                    .productAddress(widget.index),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String?> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text("Error: ${snapshot.error}",
                                        style: TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700));
                                  } else {
                                    return Text(
                                      snapshot.data ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Proxima Nova',
                                        fontWeight: FontWeight.w400,
                                        height: 0.92,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          )
                          // RichText(
                          //     text: TextSpan(
                          //         text: 'Location:',
                          //         style: TextStyle(
                          //             color: Color(0xffD9D9D9),
                          //             fontSize: 10,
                          //             fontWeight: FontWeight.w600),
                          //         children: <TextSpan>[
                          //       TextSpan(
                          //           text: widget
                          //                   .userPostModel!
                          //                   .location!
                          //                   .coordinates!
                          //                   .isEmpty
                          //               ? ""
                          //               : '${widget.userPostModel!.location!.coordinates}',
                          //           style: TextStyle(
                          //               color: Color(0xff000000),
                          //               fontSize: 14,
                          //               fontWeight:
                          //                   FontWeight.w700))
                          //     ])),
                        ],
                      ),
                      const Divider(),
                      SizedBox(
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text(
                                  widget.userPostModel!.title!.isNotEmpty
                                      ? "${widget.userPostModel!.title}"
                                      : "",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: SizedBox(
                                      height: 36,
                                      child: Text(
                                        widget.userPostModel!.body!.isNotEmpty
                                            ? "  ${widget.userPostModel!.body}"
                                            : "",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      )),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // SizedBox(
                                //     height: 18,
                                //     width: 150,
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.start,
                                //       children: productRating(5),
                                //     )),
                                Text(
                                  widget.userPostModel!.quantity! != null
                                      ? "${widget.userPostModel!.quantity} pieces available"
                                      : "0 pieces available",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      // SizedBox(
                      //   // height: 70,
                      //   child: Column(
                      //     //mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       const SizedBox(
                      //         width: double.infinity,
                      //         child: Text(
                      //           'Delivery',
                      //           style: TextStyle(
                      //               fontSize: 16, fontWeight: FontWeight.w600),
                      //           textAlign: TextAlign.left,
                      //         ),
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Flexible(
                      //             flex: 1,
                      //             child: Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: BlackBorderButton(
                      //                 title: widget.userPostModel!
                      //                             .deliveryCompany !=
                      //                         null
                      //                     ? " ${widget.userPostModel!.deliveryCompany}"
                      //                     : "",
                      //                 onPressed: () {},
                      //               ),
                      //             ),
                      //           ),
                      //           Flexible(
                      //             flex: 1,
                      //             child: Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: BlackBorderButton(
                      //                 title: 'My own logistics',
                      //                 onPressed: () {},
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const Divider(),
                      // SizedBox(
                      //   // height: 75,
                      //   child: Column(
                      //     children: [
                      //       const Padding(
                      //         padding: EdgeInsets.only(bottom: 8),
                      //         child: SizedBox(
                      //           width: double.infinity,
                      //           child: Text('Reviews(10)',
                      //               style: TextStyle(
                      //                   fontSize: 16,
                      //                   fontWeight: FontWeight.w600),
                      //               textAlign: TextAlign.left),
                      //         ),
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         children: [
                      //           SizedBox(
                      //             width: 130,
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               children: [
                      //                 const Text('Grogoryx',
                      //                     style: TextStyle(
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.w400),
                      //                     textAlign: TextAlign.left),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceEvenly,
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                         'assets/svgs/rating_star.svg',
                      //                         height: 10,
                      //                         width: 10,
                      //                         fit: BoxFit.contain),
                      //                     SvgPicture.asset(
                      //                         'assets/svgs/rating_star.svg',
                      //                         height: 10,
                      //                         width: 10,
                      //                         fit: BoxFit.contain),
                      //                     SvgPicture.asset(
                      //                         'assets/svgs/rating_star.svg',
                      //                         height: 10,
                      //                         width: 10,
                      //                         fit: BoxFit.contain),
                      //                     SvgPicture.asset(
                      //                         'assets/svgs/rating_star.svg',
                      //                         height: 10,
                      //                         width: 10,
                      //                         fit: BoxFit.contain),
                      //                     SvgPicture.asset(
                      //                         'assets/svgs/rating_star.svg',
                      //                         height: 10,
                      //                         width: 10,
                      //                         fit: BoxFit.contain)
                      //                   ],
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       const SizedBox(
                      //         width: double.infinity,
                      //         child: Padding(
                      //           padding: EdgeInsets.only(top: 8),
                      //           child: Text(
                      //             'The corn is the best ive ever bought, ive also gotten the best review.',
                      //             style: TextStyle(
                      //                 fontSize: 12,
                      //                 fontWeight: FontWeight.w400),
                      //             textAlign: TextAlign.left,
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // const Divider(),
                      // SizedBox(
                      //     height: 250,
                      //     child: Column(
                      //       children: [
                      //         const Padding(
                      //           padding: EdgeInsets.all(8.0),
                      //           child: SizedBox(
                      //             width: double.infinity,
                      //             child: Text('Related items',
                      //                 style: TextStyle(
                      //                     fontSize: 16,
                      //                     fontWeight: FontWeight.w600),
                      //                 textAlign: TextAlign.left),
                      //           ),
                      //         ),
                      //         Row(children: [
                      //           SizedBox(
                      //               height: 175,
                      //               width: 128,
                      //               child: Column(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.spaceEvenly,
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   ClipRRect(
                      //                     borderRadius:
                      //                         BorderRadius.circular(4.59),
                      //                     child: Image.network(
                      //                       src,
                      //                       width: 115,
                      //                       height: 103,
                      //                       fit: BoxFit.cover,
                      //                     ),
                      //                   ),
                      //                   const Text(
                      //                     'Layer Chickens',
                      //                     style: TextStyle(
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.w400),
                      //                     textAlign: TextAlign.left,
                      //                   ),
                      //                   const Text(
                      //                     'NGN 20,000',
                      //                     style: TextStyle(
                      //                         color: Color(0xff29844B),
                      //                         fontSize: 14,
                      //                         fontWeight: FontWeight.w600),
                      //                     textAlign: TextAlign.left,
                      //                   ),
                      //                   const Text(
                      //                     'NGN 20,000',
                      //                     style: TextStyle(
                      //                         decoration:
                      //                             TextDecoration.lineThrough,
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.w500),
                      //                     textAlign: TextAlign.left,
                      //                   ),
                      //                   const Text(
                      //                     'Plateau State',
                      //                     style: TextStyle(
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.w400),
                      //                     textAlign: TextAlign.left,
                      //                   )
                      //                 ],
                      //               )),
                      //           SizedBox(
                      //               height: 175,
                      //               width: 128,
                      //               child: Column(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.spaceEvenly,
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   ClipRRect(
                      //                     borderRadius:
                      //                         BorderRadius.circular(4.59),
                      //                     child: Image.network(
                      //                       src,
                      //                       width: 115,
                      //                       height: 103,
                      //                       fit: BoxFit.cover,
                      //                     ),
                      //                   ),
                      //                   const Text(
                      //                     'Layer Chickens',
                      //                     style: TextStyle(
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.w400),
                      //                     textAlign: TextAlign.left,
                      //                   ),
                      //                   const Text(
                      //                     'NGN 20,000',
                      //                     style: TextStyle(
                      //                         color: Color(0xff29844B),
                      //                         fontSize: 14,
                      //                         fontWeight: FontWeight.w600),
                      //                     textAlign: TextAlign.left,
                      //                   ),
                      //                   const Text(
                      //                     'NGN 20,000',
                      //                     style: TextStyle(
                      //                         decoration:
                      //                             TextDecoration.lineThrough,
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.w500),
                      //                     textAlign: TextAlign.left,
                      //                   ),
                      //                   const Text(
                      //                     'Plateau State',
                      //                     style: TextStyle(
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.w400),
                      //                     textAlign: TextAlign.left,
                      //                   )
                      //                 ],
                      //               )),
                      //         ])
                      //       ],
                      //     )),
                      SizedBox(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                            Expanded(
                              child: ShortBorderButton(
                                  title: 'Delete',
                                  icon: const Icon(Icons.close,
                                      color: Color(0xff29844B)),
                                  onPressed: () {
                                    deleteDialog(context);
                                  }),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: ShortGradientButton(
                                  title: 'Edit Price',
                                  onPressed: () {
                                    Get.to(() => StoreEditProduct(
                                          userPostModel: userModelPost,
                                        ));
                                  }),
                            )
                          ]))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

Widget buildItem(cardItem, index) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 342.0,
        width: 342.0,
        child: cardItem,
      ),
    );

class Card1 extends StatelessWidget {
  const Card1({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.59),
      child: Image.network(
        imageUserModel!.images![0],
        fit: BoxFit.cover,
      ),
    );
  }
}

class Card2 extends StatelessWidget {
  const Card2({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(4.59),
        child: imageUserModel!.images![1] == null
            ? Image.network(
                imageUserModel!.images![1], // height: 341,
                // width: 341,
                fit: BoxFit.fill,
              )
            : Container());
  }
}

class Card3 extends StatelessWidget {
  const Card3({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.59),
      child: Image.network(
        imageUserModel!.images![2],
        height: 341,
        width: 341,
        fit: BoxFit.fill,
      ),
    );
  }
}

Future<dynamic> deleteDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    // Set to true if you want to allow dismissing the dialog by tapping outside it
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 20, sigmaY: 20), // Adjust the blur intensity as needed
        child: Container(
          height: 100,
          child: AlertDialog(
            title: const Center(
              child: Icon(
                size: 60,
                Icons.check_circle_outlined,
              ),
            ),
            content: Padding(
              padding: EdgeInsets.only(left: 0.0),
              child: Container(
                height: 50,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Are you sure you want to delete this item',
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
                  title: 'Yes, delete this item',
                  onPressed: () async {
                    bool created = false;
                    created = await marketController
                        .deleteProductItem(usrPostModel!.id);
                    if (created) {
                      await marketController.fetchUserProduct();
                      await marketController.fetchProduct();
                      await marketController.fetchDiscountedProducts();
                      Get.to(() => const SettingsProfile());
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 20),
                child: Center(
                  child: DialogWhiteButton(
                    title: 'No, Keep this item',
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
