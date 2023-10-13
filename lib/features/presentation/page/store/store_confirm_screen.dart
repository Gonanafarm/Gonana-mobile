import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/cart/cart_controller.dart';
import 'package:gonana/features/controllers/market/market_controllers.dart';
import 'package:gonana/features/presentation/page/settings/settiings_profile.dart';
import 'package:gonana/features/presentation/page/store/store_logistics.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../../consts.dart';
import '../../../controllers/taxonomy/taxonomy_controller.dart';
import '../market/cart_page.dart';
// import 'package:gonana/features/presentation/page/store/store_view-product.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({super.key});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final taxonomyController = Get.put(TaxonomyController());
  CarouselController customCarouselController = CarouselController();
  ProductController productController = Get.put(ProductController());
  int activeIndex = 0;
  bool isLoading = false;
  final cardList = [
    const Card1(),
    const Card2(),
    const Card3(),
  ];

  @override
  void initState() {
    super.initState();
  }

  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            )),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 24, top: 17),
            child: GestureDetector(
              onTap: () {
                Get.to(() => CartPage());
              },
              child: Stack(
                children: [
                  SvgPicture.asset(
                      height: 40, width: 40, "assets/svgs/cart.svg"),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      // width: 15,
                      // height: 15,
                      decoration: BoxDecoration(
                        color: Colors.red[500],
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Center(
                          child: Obx(() {
                            return Text(
                              cartController
                                          .cartModel!.value.products!.length !=
                                      null
                                  ? "${cartController.cartItems}"
                                  : "",
                              style: const TextStyle(
                                color: primaryColor,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    // color: Colors.green,
                    width: MediaQuery.of(context).size.width * 1,
                    // height: 342,
                    child: Stack(children: <Widget>[
                      CarouselSlider.builder(
                        carouselController: customCarouselController,
                        itemCount: cardList.length,
                        options: CarouselOptions(
                            height: 341,
                            viewportFraction: 1,
                            autoPlay: false,
                            enableInfiniteScroll: false,
                            onPageChanged: ((index, reason) =>
                                setState(() => activeIndex = index))),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          final cardItem = cardList[index];
                          return buildItem(cardItem, index);
                        },
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.17,
                        left: MediaQuery.of(context).size.width * 0.11,
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    customCarouselController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.linear);
                                  },
                                  child: Container(
                                    height: 42,
                                    width: 42,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(171, 44, 44, 44),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                        child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 18.0,
                                    )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    customCarouselController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.linear);
                                  },
                                  child: Container(
                                    height: 42,
                                    width: 42,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(171, 44, 44, 44),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                        child: Icon(Icons.arrow_forward_ios,
                                            color: Colors.white, size: 18.0)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              // width: 140,
                              child: Obx(() {
                                return RichText(
                                    text: TextSpan(
                                        text:
                                            'NGN ${productController.amount.value}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff29844B)),
                                        children: const <TextSpan>[
                                      TextSpan(
                                          text: '/Piece',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400))
                                    ]));
                              }),
                            ),
                            // SizedBox(
                            //   // height: 24,
                            //   width: 57,
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       SvgPicture.asset(
                            //           'assets/svgs/emails_messages_icon.svg',
                            //           height: 24,
                            //           width: 24,
                            //           fit: BoxFit.contain),
                            //       const Text('Chat',
                            //           style: TextStyle(
                            //               fontSize: 12,
                            //               fontWeight: FontWeight.w400))
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(() {
                            return Flexible(
                              child: RichText(
                                  text: TextSpan(
                                      text: 'Location:',
                                      style: const TextStyle(
                                          color: Color(0xff000000),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            ' ${productController.address.value}',
                                        style: const TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600))
                                  ])),
                            );
                          })
                        ],
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productController.title.value,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        Obx(() {
                          return Text(productController.body.value,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400));
                        }),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx(() {
                              return Text(
                                  "${productController.quantity.value} available",
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600));
                            }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx(() {
                              return Text(
                                  "${productController.weight.value} KG",
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600));
                            }),
                          ],
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        // const SizedBox(height: 10),
                        // const Text('Delivery',
                        //     style: TextStyle(
                        //         fontSize: 16, fontWeight: FontWeight.w600)),
                        // const SizedBox(height: 10),
                        // Container(
                        //   // height: 100,
                        //   width: 130,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       border: Border.all(color: Color(0xff1E1E1E))),
                        //   child: Center(
                        //     child: Padding(
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 20.0, horizontal: 8),
                        //       child: Obx(() {
                        //         return Text(
                        //             productController.logisticsMerchant.value,
                        //             style: const TextStyle(
                        //                 fontSize: 12,
                        //                 fontWeight: FontWeight.w400));
                        //       }),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                    child: LongGradientButton(
                        isLoading: isLoading,
                        title: "Confirm details",
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          bool created = false;
                          try {
                            created = await productController.createProduct(
                                productController.title.value,
                                productController.body.value,
                                productController.image.value,
                                productController.image2.value,
                                productController.image3.value,
                                taxonomyController.id.value,
                                productController.amount.value,
                                productController.quantity.value,
                                productController.weight.value,
                                productController.geoLong.value,
                                productController.geoLat.value,
                                productController.logisticsMerchant.value,
                                productController.address.value);
                            log("id: ${taxonomyController.id}");
                          } catch (e, s) {
                            log("e=> $e");
                            log("s=> $s");
                          }
                          if (created) {
                            setState(() {
                              isLoading = false;
                            });
                            await productController.fetchProduct();
                            await productController.fetchUserProduct();
                            successDialog(context);
                          }
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> successDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible:
          false, // Set to true if you want to allow dismissing the dialog by tapping outside it
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
                padding: EdgeInsets.only(left: 30.0),
                child: Container(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Product post succesful'),
                      Container(height: 10),
                      const Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            // width: 185,
                            // height: 82,
                            child: Text(
                              'Note:\n\nFor Every succesful transaction there would be 1.5% charge',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF444444),
                                fontSize: 14,
                                fontFamily: 'Proxima Nova',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: DialogGradientButton(
                    title: 'Proceed',
                    onPressed: () {
                      Get.to(() => const SettingsProfile());
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
      child: Obx(() {
        return productController.image.value != null
            ? Container(
                height: 341,
                width: 341,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  image: DecorationImage(
                      image: FileImage(productController.image.value),
                      fit: BoxFit.cover),
                ),
              )
            : Container(
                height: 341,
                width: 341,
                decoration: const BoxDecoration(
                  color: Colors.pink,
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://images.pexels.com/photos/1496373/pexels-photo-1496373.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      ),
                      fit: BoxFit.cover),
                ),
              );
      }),
    );
  }
}

class Card2 extends StatelessWidget {
  const Card2({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.59),
      child: Obx(() {
        return productController.image2.value != null
            ? Container(
                height: 341,
                width: 341,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  image: DecorationImage(
                      image: FileImage(productController.image2.value),
                      fit: BoxFit.cover),
                ),
              )
            : Container(
                height: 341,
                width: 341,
                decoration: const BoxDecoration(
                  color: Colors.pink,
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://images.pexels.com/photos/1496373/pexels-photo-1496373.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      ),
                      fit: BoxFit.cover),
                ),
              );
      }),
    );
  }
}

class Card3 extends StatelessWidget {
  const Card3({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.59),
      child: Obx(() {
        return productController.image3.value != null
            ? Container(
                height: 341,
                width: 341,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  image: DecorationImage(
                      image: FileImage(productController.image3.value),
                      fit: BoxFit.cover),
                ),
              )
            : Container(
                height: 341,
                width: 341,
                decoration: const BoxDecoration(
                  color: Colors.pink,
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://images.pexels.com/photos/1496373/pexels-photo-1496373.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      ),
                      fit: BoxFit.cover),
                ),
              );
      }),
    );
  }
}
