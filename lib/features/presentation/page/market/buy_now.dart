import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gonana/features/controllers/cart/cart_controller.dart';
import 'package:gonana/features/data/models/post_model.dart';
import 'package:gonana/features/presentation/page/market/market_page.dart';
import 'package:gonana/features/presentation/widgets/bottomsheets.dart';
import 'package:gonana/features/presentation/widgets/image_slider.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../consts.dart';
import '../../../controllers/market/market_controllers.dart';
import 'cart_page.dart';

class BuyNowPage extends StatefulWidget {
  final Datum productModel;
  const BuyNowPage({super.key, required this.productModel});

  @override
  State<BuyNowPage> createState() => _BuyNowPageState();
}

class _BuyNowPageState extends State<BuyNowPage> {
  CartController cartController = Get.put(CartController());
  final marketController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    var productModelPost = widget.productModel;
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          //   "assets/svgs/Essential.svg",
                          //   width: 45,
                          //   height: 30,
                          // ),
                          sizeHor(20.0),
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
                sizeVer(10.0),
                ImageSlider(imageProductModel: widget.productModel),
                sizeVer(10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: widget.productModel!.product!.amount != null
                                ? "NGN ${widget.productModel!.product!.amount}"
                                : "NGN ",
                            style: GoogleFonts.montserrat(
                                fontSize: 24,
                                color: const Color.fromRGBO(41, 132, 75, 1),
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: "/Piece",
                            style: GoogleFonts.montserrat(
                                color: darkColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     SvgPicture.asset(
                    //       "assets/svgs/bottom-image.svg",
                    //     ),
                    //     sizeHor(10.0),
                    //     Text(
                    //       "Chat",
                    //       style: GoogleFonts.montserrat(
                    //           color: const Color.fromRGBO(0, 0, 0, 1),
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w400),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
                sizeVer(5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text("NGN 30000",
                    //     style: GoogleFonts.montserrat(
                    //       color: const Color.fromRGBO(0, 0, 0, 1),
                    //       fontSize: 18,
                    //       decoration: TextDecoration.lineThrough,
                    //       decorationColor: Colors.black,
                    //       decorationThickness: 2.0,
                    //     )),
                    Text("Location: ",
                        style: GoogleFonts.montserrat(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                    FutureBuilder<String>(
                      future: marketController.convertCoordinatesToAddress([
                        double.parse(widget
                            .productModel!.product!.location!.coordinates![0]
                            .toString()),
                        double.parse(widget
                            .productModel!.product!.location!.coordinates![1]
                            .toString())
                      ]),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
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
                    )
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                Text(
                    widget.productModel!.product!.title!.isNotEmpty
                        ? "${widget.productModel!.product!.title}"
                        : "",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: darkColor,
                        fontWeight: FontWeight.w600)),
                sizeVer(3.0),
                Text(
                    widget.productModel!.product!.body!.isNotEmpty
                        ? "${widget.productModel!.product!.body}"
                        : "",
                    style: GoogleFonts.montserrat(
                        fontSize: 10,
                        color: darkColor,
                        fontWeight: FontWeight.w400)),
                sizeVer(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Row(
                    //   children: [
                    //     SvgPicture.asset("assets/svgs/black-star.svg"),
                    //     sizeHor(5.0),
                    //     SvgPicture.asset("assets/svgs/black-star.svg"),
                    //     sizeHor(5.0),
                    //     SvgPicture.asset("assets/svgs/black-star.svg"),
                    //     sizeHor(5.0),
                    //     SvgPicture.asset("assets/svgs/black-star.svg"),
                    //     sizeHor(5.0),
                    //     SvgPicture.asset("assets/svgs/black-star.svg"),
                    //     sizeHor(5.0),
                    //     Text("5.0",
                    //         style: GoogleFonts.montserrat(
                    //             fontSize: 14,
                    //             color: darkColor,
                    //             fontWeight: FontWeight.w600)),
                    //   ],
                    // ),
                    Text(
                        widget.productModel!.product!.quantity! != null
                            ? "${widget.productModel!.product!.quantity} Pieces available"
                            : "0 Pieces available",
                        style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: darkColor,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                sizeVer(10),
                Divider(
                  thickness: 1.0,
                  color: Colors.grey[300],
                ),
                sizeVer(10.0),
                Text("Delivery",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: darkColor,
                        fontWeight: FontWeight.w600)),
                sizeVer(10.0),
                Row(
                  children: [
                    Container(
                      width: 125,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: darkColor, width: 1),
                      ),
                      child: Center(
                        child: Text(
                            widget.productModel!.product!.deliveryCompany !=
                                    null
                                ? "${widget.productModel!.product!.deliveryCompany}"
                                : "",
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                              color: darkColor,
                            )),
                      ),
                    ),
                    sizeHor(20.0),
                    // Flexible(
                    //   child: Container(
                    //     width: 125,
                    //     height: 45,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(5),
                    //       border: Border.all(color: darkColor, width: 1),
                    //     ),
                    //     child: Center(
                    //       child: Text("My own Logistics",
                    //           style: GoogleFonts.montserrat(
                    //             fontSize: 10,
                    //             color: darkColor,
                    //           )),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                sizeVer(10.0),
                Divider(
                  thickness: 1.0,
                  color: Colors.grey[300],
                ),
                sizeHor(10.0),
                // Text("Reviews(10)",
                //     style: GoogleFonts.montserrat(
                //         fontSize: 16,
                //         color: darkColor,
                //         fontWeight: FontWeight.w600)),
                // sizeVer(10.0),
                // Row(
                //   children: [
                //     Text("GregoryX",
                //         style: GoogleFonts.montserrat(
                //           fontSize: 10,
                //           color: darkColor,
                //         )),
                //     sizeHor(10.0),
                //     SvgPicture.asset("assets/svgs/black-star.svg"),
                //     sizeHor(5.0),
                //     SvgPicture.asset("assets/svgs/black-star.svg"),
                //     sizeHor(5.0),
                //     SvgPicture.asset("assets/svgs/black-star.svg"),
                //     sizeHor(5.0),
                //     SvgPicture.asset("assets/svgs/black-star.svg"),
                //     sizeHor(5.0),
                //     SvgPicture.asset("assets/svgs/black-star.svg"),
                //   ],
                // ),
                // sizeVer(5.0),
                // Text(
                //     "The corn is the best ive ever bought , ive also gotten the best review.",
                //     style: GoogleFonts.montserrat(
                //         fontSize: 10,
                //         color: darkColor,
                //         fontWeight: FontWeight.w400)),
                // sizeVer(10.0),
                // Divider(
                //   thickness: 1.0,
                //   color: Colors.grey[300],
                // ),
                // sizeHor(10.0),
                Text("Related Items",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: darkColor,
                        fontWeight: FontWeight.w600)),
                sizeVer(10.0),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: marketController.marketModel!.data!.length <= 3
                        ? marketController.marketModel!.data!.length
                        : 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: BuyNowCard(index: index),
                      );
                    },
                  ),
                ),
                sizeVer(20.0),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        bool created = false;
                        created = await cartController.addToCart(
                            widget.productModel.product!.id, context);
                        print(widget.productModel.product!.id);
                        if (created) {
                          await cartController.fetchCart();
                          cartController.updateCartItems();
                        }
                      },
                      child: Container(
                        width: 172.5,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: const Color(0xff29844B), width: 1),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Add to Cart",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: const Color(0xff29844B),
                                    fontWeight: FontWeight.w400,
                                  )),
                              sizeHor(10.0),
                              SvgPicture.asset(
                                "assets/svgs/cart.svg",
                                color: const Color(0xff29844B),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    sizeHor(15.0),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          checkout(context);
                        },
                        child: Container(
                          width: 172.5,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.04, 0.9994],
                              colors: [
                                Color(0xff072C27),
                                Color(0xff29844B),
                              ],
                              transform: GradientRotation(89.94 * 3.14 / 180),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Buy now",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              sizeHor(5.0),
                              const Icon(
                                Icons.arrow_forward,
                                color: primaryColor,
                                size: 35,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                sizeVer(20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
