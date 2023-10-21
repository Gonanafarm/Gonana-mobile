import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/controllers/post/post_controllers.dart';
import 'package:gonana/features/data/models/post_model_id.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../consts.dart';
import '../../../../main.dart';
import '../../../controllers/cart/cart_controller.dart';
import '../../../controllers/market/market_controllers.dart';
import '../../widgets/search_page.dart';
import '../../widgets/widgets.dart';
import '../market/cart_page.dart';
import '../market/hot_deals.dart';

class UserStore extends StatefulWidget {
  const UserStore({Key? key}) : super(key: key);

  @override
  State<UserStore> createState() => _UserStoreState();
}

class _UserStoreState extends State<UserStore> {
  final TextEditingController _searchController = TextEditingController();
  PostController postController = Get.find<PostController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: SingleChildScrollView(
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
                      ],
                    ),
                  ),
                  sizeVer(15.0),
                  SearchWidget(
                    controller: _searchController,
                  ),
                  sizeVer(10.0),
                  const Text(
                    "User products",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor),
                  ),
                  sizeVer(10.0),
                  const Text(
                    "These are the farmers products.",
                    style: TextStyle(fontSize: 15.0, color: secondaryColor),
                  ),
                  postController.idPostModel!.data == null ||
                          postController.idPostModel!.data!.isEmpty ||
                          postController.idPostModel! == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              sizeVer(
                                  MediaQuery.of(context).size.height * 0.05),
                              SvgPicture.asset(
                                "assets/svgs/user_product_empty.svg",
                                width: 189.71,
                                height: 156.03,
                              ),
                              const Text(
                                'This user has no product yet',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontFamily: 'Proxima Nova',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              sizeVer(10),
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
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: postController.idPostModel!.data != null
                              ? postController.idPostModel!.data!.length
                              : 0,
                          itemBuilder: (context, index) {
                            return postController.idPostModel!.data!.isNotEmpty
                                ? Column(
                                    children: [
                                      HotDealsCard(
                                        index: index,
                                        productId: postController
                                            .idPostModel!.data![index].product!,
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
                  sizeVer(15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

ProductController productController = Get.put(ProductController());
PostController postController = Get.put(PostController());
CartController cartController = Get.put(CartController());

class HotDealsCard extends StatefulWidget {
  final int index;
  final Product productId;
  const HotDealsCard({
    super.key,
    required this.index,
    required this.productId,
  });

  @override
  State<HotDealsCard> createState() => _HotDealsCardState();
}

class _HotDealsCardState extends State<HotDealsCard> {
  PostController postController = Get.find<PostController>();
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
                  Navigator.pushNamed(context, PageConst.checkoutPage);
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
                  child: postController.idPostModel!.data != null &&
                          widget.index >= 0 &&
                          widget.index <
                              postController.idPostModel!.data!.length &&
                          postController.idPostModel!.data![widget.index]
                                  .product!.images !=
                              null &&
                          postController.idPostModel!.data!.isNotEmpty
                      ? ClipRRect(
                          child: Image.network(
                            widget.productId.images![0],
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
                  "${widget.productId.body}",
                  style: TextStyle(color: darkColor),
                ),
                sizeVer(10),
                Text(
                  "${widget.productId.amount}",
                  style: TextStyle(
                      fontSize: 20,
                      color: greenColor,
                      fontWeight: FontWeight.w600),
                ),
                sizeVer(4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text("NGN 30000",
                          //     style: GoogleFonts.montserrat(
                          //       color: const Color.fromRGBO(0, 0, 0, 1),
                          //       fontSize: 10,
                          //       decoration: TextDecoration.lineThrough,
                          //       decorationColor: Colors.black,
                          //       decorationThickness: 2.0,
                          //     )),
                          // sizeVer(5.0),
                          FutureBuilder<String?>(
                            future:
                                postController.postUserIdAddress(widget.index),
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
                                  style: GoogleFonts.sourceSansPro(
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                    fontSize: 12,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    sizeHor(20),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () async {
                          bool created = false;
                          created = await cartController.addToCart(
                              widget.productId.id, context);
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
