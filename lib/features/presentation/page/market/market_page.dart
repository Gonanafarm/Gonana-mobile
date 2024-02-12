import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/fiat_wallet/transaction_controller.dart';
import 'package:gonana/features/controllers/market/market_controllers.dart';
import 'package:gonana/features/presentation/page/market/hot_deals_item.dart';
import 'package:gonana/features/presentation/page/market/orders.dart';
import 'package:gonana/features/presentation/page/market/searchedProducts.dart';
import 'package:gonana/features/presentation/page/messages/message.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../consts.dart';
import '../../../controllers/auth/get_details.dart';
import '../../../controllers/order/order_controller.dart';
import '../../../controllers/post/post_controllers.dart';
import '../../../controllers/user/user_controller.dart';
import '../../../data/models/post_model.dart';
import '../../../utilities/network.dart';
import '../../widgets/search_page.dart';
import '../../widgets/warning_widget.dart';
import 'buy_now.dart';
import 'cart_page.dart';
import 'hot_deals.dart';

GetDetailsController detailsController = Get.put(GetDetailsController());

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  final TextEditingController searchController = TextEditingController();
  String get searchItem => searchController.text;
  PostController postController = Get.put(PostController());
  TransactionController transactionController =
      Get.put(TransactionController());
  final userController = Get.find<UserController>();
  ProductController marketController = Get.put(ProductController());

  late Future<bool> fetchData;
  GetDetailsController detailsController = Get.put(GetDetailsController());
  ScrollController scrollController = ScrollController();
  List filteredItems = [];
  OrderController orderController = Get.put(OrderController());

  // bool isLoadingMoreRunning = false;
  int page = 0;
  PostModel? marketModel;
  bool loading = false;
  getMoreData() async {
    setState(() {
      loading = true;
    });
    await marketController.fetchMoreProducts();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setStage();
    getBVNStatus();
    fetchData = detailsController.getUserDetails();
    transactionController.fetchTransactions();
    orderController.getOrders();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreData();
      }
    });
  }

  setStage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('registrationStage', 5);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  bool? BVNisSubmited = false;
  getBVNStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BVNisSubmited = prefs.getBool('bvnSubmission');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: fetchData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
          return Scaffold(
            backgroundColor: const Color(0xffF1F1F1),
            body: SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const Orders());
                                },
                                child: Stack(
                                  children: [
                                    SvgPicture.asset(
                                        height: 40,
                                        width: 40,
                                        "assets/svgs/order.svg"),
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
                                              final orders = orderController
                                                      .getOrderModel
                                                      ?.value
                                                      ?.data ??
                                                  [];
                                              final outgoingOrders =
                                                  orderController
                                                          .getOutGoingOrderModel
                                                          ?.value
                                                          ?.data ??
                                                      [];
                                              final totalLength =
                                                  orders.length +
                                                      outgoingOrders.length;
                                              return Text(
                                                '$totalLength',
                                                style: TextStyle(
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
                              sizeHor(10),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => CartPage());
                                },
                                child: Stack(
                                  children: [
                                    SvgPicture.asset(
                                        height: 40,
                                        width: 40,
                                        "assets/svgs/cart.svg"),
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
                                                            .cartModel!
                                                            .value
                                                            .products!
                                                            .isNotEmpty ||
                                                        cartController
                                                                .cartModel! ==
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
                          controller: searchController,
                          onChanged: (String sumn) async {
                            var search = await marketController
                                .searchProduct(searchController.text);
                            if (search.isNotEmpty) {
                              Get.to(
                                  () => AllSearchedProducts(
                                        searchResults: search,
                                      ),
                                  arguments: {
                                    "searchData": search,
                                    "searchQuery": searchController.text
                                  });
                              searchController.clear();
                            } else {
                              ErrorSnackbar.show(context,
                                  "Sorry, no product matching your search");
                            }
                          },
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
                          height: marketController
                                      .discountMarketModel?.data!.length ==
                                  0
                              ? 0
                              : 190,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: marketController
                                        .discountMarketModel?.data?.length ==
                                    7
                                ? 6
                                : marketController
                                        .discountMarketModel?.data?.length ??
                                    0,
                            itemBuilder: (context, index) {
                              final reversedIndex = (marketController
                                          .discountMarketModel!.data!.length -
                                      1) -
                                  index;
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: HotDealsCard(
                                  index: index,
                                ),
                              );
                            },
                          ),
                        ),
                        ((BVNisSubmited != null && BVNisSubmited!) ||
                                    (userController.userModel != null &&
                                        userController.userModel.value
                                                .virtualAccountNumber !=
                                            null &&
                                        userController
                                            .userModel
                                            .value
                                            .virtualAccountNumber!
                                            .isNotEmpty)) ||
                                (userController.userModel != null &&
                                    userController.userModel.value.country !=
                                        null &&
                                    !userController.userModel.value.country!
                                        .contains("Nigeria"))
                            ? Container(height: 1)
                            : WarningWidget(),
                        sizeVer(15),
                        marketController.marketModel.value.data!.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    sizeVer(MediaQuery.of(context).size.height *
                                        0.1),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Buy now",
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: secondaryColor),
                                    ),
                                  ],
                                ),
                              ),
                        sizeVer(15),
                        SizedBox(
                          // ignore: prefer_is_empty
                          height: marketController
                                      .discountMarketModel?.data!.length ==
                                  0
                              ? MediaQuery.of(context).size.height * 0.72
                              : MediaQuery.of(context).size.height * 0.31,
                          child: Column(
                            children: [
                              Expanded(
                                child: GridView.builder(
                                  // scrollDirection: Axis.horizontal,
                                  controller: scrollController,
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics(),
                                  ),
                                  itemCount: marketController
                                          .marketModel.value.data?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    final reversedIndex = (marketController
                                                .marketModel
                                                .value
                                                .data!
                                                .length -
                                            1) -
                                        index;
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: BuyNowCard(
                                        index: index,
                                      ),
                                    );
                                  },
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, // Number of columns
                                    mainAxisExtent:
                                        140, // Maximum width of each item
                                    mainAxisSpacing: 30,
                                    childAspectRatio: 11 /
                                        13, // Width-to-height ratio of each item
                                  ),
                                ),
                              ),
                              !loading
                                  ? Container(height: 1)
                                  : const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: Color.fromRGBO(41, 132, 75, 1),
                                      ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //bottomNavigationBar: NavigationBar(),
          );
        }
      },
    );
  }

  // void searchBook(String query) {
  //   final marketData = marketController.marketModel.value.data;
  //   final input = query.toLowerCase();
  //   final title = marketData![widget.index].product!.title!.toLowerCase();
  //   final suggestions = marketData.where((data) {
  //     return title.contains(query.toLowerCase());
  //   });
  // }
}

class HotDealsCard extends StatefulWidget {
  final int index;
  HotDealsCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<HotDealsCard> createState() => _HotDealsCardState();
}

class _HotDealsCardState extends State<HotDealsCard> {
  final marketController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    var productModel = marketController.discountMarketModel!.data;
    return InkWell(
      onTap: () {
        Get.to(() => HotDealsItem(
              index: widget.index,
              productModel: productModel![widget.index],
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 115,
                // height: 103,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // image: const DecorationImage(
                  //   image: AssetImage('assets/images/image 4.png'),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: (marketController.discountMarketModel != null &&
                        marketController.discountMarketModel!.data != null &&
                        marketController
                            .discountMarketModel!.data!.isNotEmpty &&
                        marketController.discountMarketModel!
                                .data![widget.index].images !=
                            null &&
                        marketController.discountMarketModel!
                            .data![widget.index].images!.isNotEmpty)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          marketController.discountMarketModel!
                              .data![widget.index].images![0],
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            // Handle the error, log it, or show a placeholder image.
                            return Center(child: const Icon(Icons.error));
                          },
                        ),
                      )
                    : Container(), // Handle the case where data is empty or images are missing
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
            "${marketController.discountMarketModel!.data![widget.index].title}",
            style: GoogleFonts.montserrat(
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontSize: 10,
                fontWeight: FontWeight.w400),
          ),
          Text(
            "NGN ${marketController.discountMarketModel!.data![widget.index].amount}",
            style: const TextStyle(
                fontSize: 14, color: greenColor, fontWeight: FontWeight.w600),
          ),
          Text(
            "\$ ${marketController.discountMarketModel!.data![widget.index].usd_price}",
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
          FutureBuilder<String?>(
            future: marketController.discountedProductAddress(widget.index),
            builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}",
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 14,
                        fontWeight: FontWeight.w700));
              } else {
                return Flexible(
                  child: Text(
                    snapshot.data ?? "",
                    style: GoogleFonts.sourceSansPro(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 12,
                    ),
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

class BuyNowCard extends StatefulWidget {
  final int index;
  BuyNowCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<BuyNowCard> createState() => _BuyNowCardState();
}

class _BuyNowCardState extends State<BuyNowCard> {
  final marketController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    var productModel = marketController.marketModel.value.data;
    return InkWell(
      onTap: () {
        Get.to(() => BuyNowPage(
              index: widget.index,
              productModel: productModel![widget.index],
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
                  child: marketController.marketModel.value.data != null &&
                          widget.index >= 0 &&
                          widget.index <
                              marketController.marketModel.value.data!.length &&
                          marketController.marketModel.value.data![widget.index]
                                  .product!.images !=
                              null &&
                          marketController.marketModel.value.data![widget.index]
                              .product!.images!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            width: 115,
                            height: 103,
                            "${marketController.marketModel.value.data![widget.index].product!.images![0]}",
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
          sizeVer(5),
          Text(
            "${marketController.marketModel.value.data![widget.index].product!.title}",
            style: GoogleFonts.montserrat(
                color: const Color.fromRGBO(0, 0, 0, 1),
                fontSize: 10,
                fontWeight: FontWeight.w400),
          ),
          Text(
            "NGN ${marketController.marketModel.value.data![widget.index].product!.amount}",
            style: GoogleFonts.montserrat(
                fontSize: 14,
                color: const Color.fromRGBO(41, 132, 75, 1),
                fontWeight: FontWeight.w600),
          ),
          Text(
            "\$ ${marketController.marketModel.value.data![widget.index].product!.usd_price}",
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
          FutureBuilder<String?>(
            future: marketController.productAddress(widget.index),
            builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
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
