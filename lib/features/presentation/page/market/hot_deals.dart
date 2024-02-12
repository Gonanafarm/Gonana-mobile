import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/market/market_controllers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../consts.dart';
import '../../widgets/search_page.dart';
import '../../widgets/widgets.dart';
import 'cart_page.dart';

class HotDealsPage extends StatefulWidget {
  const HotDealsPage({Key? key}) : super(key: key);

  @override
  State<HotDealsPage> createState() => _HotDealsPageState();
}

class _HotDealsPageState extends State<HotDealsPage> {
  final TextEditingController _searchController = TextEditingController();
  String get searchItem => _searchController.text;

  @override
  void dispose() {
    _searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  final marketController = Get.find<ProductController>();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreData();
      }
    });
  }

  bool loading = false;
  getMoreData() async {
    print(loading);
    setState(() {
      loading = true;
    });
    await marketController.fetchMoreDiscountedProducts();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20.0, 25, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // SvgPicture.asset(
                          //   "assets/svgs/Emails, Messages.svg",
                          //   width: 45,
                          //   height: 30,
                          // ),
                          // sizeHor(20.0),
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
                    ],
                  ),
                ),
                sizeVer(15.0),
                SearchWidget(
                  controller: _searchController,
                  onChanged: (searchItem) {},
                ),
                sizeVer(10.0),
                const Text(
                  "Hot Deals",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: secondaryColor),
                ),
                sizeVer(10.0),
                const Text(
                  "These are rare deals, buy them quick because the done last.",
                  style: TextStyle(fontSize: 15.0, color: secondaryColor),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: marketController
                              .discountMarketModel!.data!.length,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return marketController
                                    .discountMarketModel!.data!.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HotDealsCard(
                                        index: index,
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color: Colors.grey[300],
                                      ),
                                    ],
                                  )
                                : Container();
                          },
                        ),
                      ),
                      !loading
                          ? Container(height: 1)
                          : const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Color.fromRGBO(41, 132, 75, 1),
                              )),
                      sizeVer(100)
                    ],
                  ),
                ),
                sizeVer(15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// ProductController productController = Get.put(ProductController());

class HotDealsCard extends StatefulWidget {
  final int index;
  const HotDealsCard({
    super.key,
    required this.index,
  });

  @override
  State<HotDealsCard> createState() => _HotDealsCardState();
}

class _HotDealsCardState extends State<HotDealsCard> {
  final marketController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, PageConst.checkoutPage);
                },
                child: Container(
                  width: 115,
                  height: 103,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // image: const DecorationImage(
                    //   image: AssetImage('assets/images/image 4.png'),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: marketController.discountMarketModel!.data != null &&
                          widget.index >= 0 &&
                          widget.index <
                              marketController
                                  .discountMarketModel!.data!.length &&
                          marketController.discountMarketModel!
                                  .data![widget.index].images !=
                              null &&
                          marketController.discountMarketModel!
                              .data![widget.index].images!.isNotEmpty
                      ? ClipRRect(
                          child: Image.network(
                            "${marketController.discountMarketModel!.data![widget.index].images![0]}",
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(),
                ),
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
          sizeHor(15.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${marketController.discountMarketModel!.data![widget.index].body}',
                  style: TextStyle(color: darkColor),
                ),
                sizeVer(10),
                Text(
                  "NGN ${marketController.discountMarketModel!.data![widget.index].amount}",
                  style: TextStyle(
                      fontSize: 20,
                      color: greenColor,
                      fontWeight: FontWeight.w600),
                ),
                sizeVer(4.0),
                Text(
                  "\$ ${marketController.discountMarketModel!.data![widget.index].usd_price}",
                  style: TextStyle(
                      fontSize: 20,
                      color: greenColor,
                      fontWeight: FontWeight.w600),
                ),
                sizeVer(4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          child: FutureBuilder<String?>(
                            future: marketController
                                .discountedProductAddress(widget.index),
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
                      ),
                    ),
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: ElevatedButton(
                        onPressed: () async {
                          bool created = false;
                          created = await cartController.addToCart(
                              marketController
                                  .discountMarketModel!.data![widget.index].id,
                              context);
                          if (created) {
                            await cartController.fetchCart();
                            SuccessSnackbar.show(context, "Item added to cart");
                            cartController.updateCartItems();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(greenColor),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 13.0),
                          child: Text('Add to cart'),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
