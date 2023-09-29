import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/market/market_controllers.dart';
import 'package:gonana/features/presentation/page/market/hot_deals_item.dart';
import 'package:gonana/features/presentation/page/messages/message.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../consts.dart';
import '../../../controllers/auth/get_details.dart';
import '../../../controllers/post/post_controllers.dart';
import '../../widgets/search_page.dart';
import '../../widgets/warning_widget.dart';
import 'buy_now.dart';
import 'cart_page.dart';
import 'hot_deals.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  final TextEditingController _searchController = TextEditingController();
  PostController postController = Get.put(PostController());

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // GestureDetector(
                      //     onTap: () {
                      //       Get.to(() => Message());
                      //     },
                      //     child: SvgPicture.asset(
                      //         "assets/svgs/Emails, Messages.svg")),
                      // sizeHor(20.0),
                      GestureDetector(
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
                                        cartController.cartModel!.value
                                                    .products!.isNotEmpty ||
                                                cartController.cartModel! ==
                                                    null
                                            ? "${cartController.cartModel!.value.products!.length}"
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
                      )
                    ],
                  ),
                ),
                sizeVer(15.0),
                SearchWidget(
                  controller: _searchController,
                ),
                sizeVer(10.0),
                marketController.discountMarketModel?.data!.length == 0
                    ? sizeVer(10)
                    : InkWell(
                        onTap: () {
                          Get.to(() => const HotDealsPage());
                        },
                        child: Row(
                          children: [
                            const Text(
                              "Hot Deals",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor),
                            ),
                            sizeHor(10.0),
                            const Icon(
                              Icons.arrow_forward,
                              color: greenColor,
                              size: 32,
                            )
                          ],
                        ),
                      ),
                SizedBox(
                  height:
                      marketController.discountMarketModel?.data!.length == 0
                          ? 0
                          : 190,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        marketController.discountMarketModel?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final reversedIndex =
                          (marketController.discountMarketModel!.data!.length -
                                  1) -
                              index;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: HotDealsCard(
                          index: reversedIndex,
                        ),
                      );
                    },
                  ),
                ),
                const WarningWidget(),
                sizeVer(15),
                marketController.marketModel?.data!.length == 0
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            sizeVer(MediaQuery.of(context).size.height * 0.1),
                            SvgPicture.asset(
                              "assets/svgs/empty_product.svg",
                              width: 189.71,
                              height: 156.03,
                            ),
                            const Text(
                              'Sorry! no product yet',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: 'Proxima Nova',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              'All products will be visible here',
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
                    : InkWell(
                        onTap: () {
                          // Get.to(() => const BuyNowPage());
                        },
                        child: const Row(
                          children: [
                            Text(
                              "Buy Now",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor),
                            ),
                            // sizeHor(10.0),
                            // const Icon(
                            //   Icons.arrow_forward,
                            //   color: greenColor,
                            //   size: 32,
                            // )
                          ],
                        ),
                      ),
                sizeVer(15),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.72,
                  child: GridView.builder(
                    // scrollDirection: Axis.horizontal,
                    itemCount: marketController.marketModel?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final reversedIndex =
                          (marketController.marketModel!.data!.length - 1) -
                              index;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: BuyNowCard(
                          index: reversedIndex,
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of columns
                      mainAxisExtent: 140, // Maximum width of each item
                      mainAxisSpacing: 30,
                      childAspectRatio:
                          11 / 13, // Width-to-height ratio of each item
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      //bottomNavigationBar: NavigationBar(),
    );
  }
}

final marketController = Get.put(ProductController());

class HotDealsCard extends StatelessWidget {
  final int index;
  const HotDealsCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productModel = marketController.discountMarketModel!.data;
    return InkWell(
      onTap: () {
        Get.to(() => HotDealsItem(
              productModel: productModel![index],
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 115,
                height: 103,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // image: const DecorationImage(
                  //   image: AssetImage('assets/images/image 4.png'),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: marketController
                            .discountMarketModel!.data![index].images![0] !=
                        null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "${marketController.discountMarketModel!.data![index].images![0]}",
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(),
              ),
              // Container(
              //   width: 50,
              //   height: 26.6,
              //   decoration: BoxDecoration(
              //     color: Colors.red[500],
              //     borderRadius: BorderRadius.circular(5),
              //   ),
              //   child: Center(
              //     child: Text(
              //       "-20%",
              //       style: GoogleFonts.montserrat(
              //           color: primaryColor,
              //           fontSize: 13,
              //           fontWeight: FontWeight.w400),
              //     ),
              //   ),
              // )
            ],
          ),
          sizeVer(5),
          Text(
            "${marketController.discountMarketModel!.data![index].title}",
            style: GoogleFonts.montserrat(
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontSize: 10,
                fontWeight: FontWeight.w400),
          ),
          Text(
            "NGN ${marketController.discountMarketModel!.data![index].amount}",
            style: const TextStyle(
                fontSize: 14, color: greenColor, fontWeight: FontWeight.w600),
          ),
          // sizeVer(8.0),
          // Text("NGN 30000",
          //     style: GoogleFonts.montserrat(
          //       color: const Color.fromRGBO(0, 0, 0, 1),
          //       fontSize: 10,
          //       decoration: TextDecoration.lineThrough,
          //       decorationColor: Colors.black,
          //       decorationThickness: 2.0,
          //     )),
          sizeVer(8.0),
          FutureBuilder<String>(
            future: marketController.convertCoordinatesToAddress([
              double.parse(
                  "${marketController.discountMarketModel!.data![index].location!.coordinates![0]}"),
              double.parse(
                  "${marketController.discountMarketModel!.data![index].location!.coordinates![1]}")
            ]),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
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
                  style: GoogleFonts.sourceSansPro(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 12,
                  ),
                );
              }
            },
          )
        ],
      ),
    );
    ;
  }
}

class BuyNowCard extends StatelessWidget {
  final int index;
  const BuyNowCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productModel = marketController.marketModel!.data;
    return InkWell(
      onTap: () {
        Get.to(() => BuyNowPage(
              productModel: productModel![index],
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 115,
                  height: 103,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // image: const DecorationImage(
                    //   image: AssetImage('assets/images/image 4.png'),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: marketController.marketModel!.data != null &&
                          index >= 0 &&
                          index < marketController.marketModel!.data!.length &&
                          marketController
                                  .marketModel!.data![index].product!.images !=
                              null &&
                          marketController.marketModel!.data![index].product!
                              .images!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            width: 115,
                            height: 103,
                            "${marketController.marketModel!.data![index].product!.images![0]}",
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(),
                ),
                // Container(
                //   width: 50,
                //   height: 26.6,
                //   decoration: BoxDecoration(
                //     color: Colors.red[500],
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   child: Center(
                //     child: Text(
                //       "-20%",
                //       style: GoogleFonts.montserrat(
                //           color: primaryColor,
                //           fontSize: 13,
                //           fontWeight: FontWeight.w400),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          sizeVer(5),
          Text(
            "${marketController.marketModel!.data![index].product!.title}",
            style: GoogleFonts.montserrat(
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontSize: 10,
                fontWeight: FontWeight.w400),
          ),
          Text(
            "${marketController.marketModel!.data![index].product!.amount}",
            style: GoogleFonts.montserrat(
                fontSize: 14,
                color: const Color.fromRGBO(41, 132, 75, 1),
                fontWeight: FontWeight.w600),
          ),
          // sizeVer(8.0),
          // Text("NGN 30000",
          //     style: GoogleFonts.montserrat(
          //       color: const Color.fromRGBO(0, 0, 0, 1),
          //       fontSize: 10,
          //       decoration: TextDecoration.lineThrough,
          //       decorationColor: Colors.black,
          //       decorationThickness: 2.0,
          //     )),
          sizeVer(8.0),
          FutureBuilder<String>(
            future: marketController.convertCoordinatesToAddress([
              double.parse(
                  "${marketController.marketModel!.data![index].product!.location!.coordinates![0]}"),
              double.parse(
                  "${marketController.marketModel!.data![index].product!.location!.coordinates![1]}")
            ]),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
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
                  style: GoogleFonts.sourceSansPro(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 12,
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
