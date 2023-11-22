import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/cart/cart_controller.dart';
import 'package:gonana/features/controllers/order/order_controller.dart';
import 'package:gonana/features/controllers/user/user_controller.dart';
import 'package:gonana/features/data/models/cart_model.dart';
import 'package:gonana/features/presentation/page/home.dart';
import 'package:gonana/features/presentation/page/market/product_checkout.dart';
import 'package:gonana/features/presentation/widgets/bottomsheets.dart';
import 'package:gonana/features/presentation/widgets/search_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../consts.dart';
import '../../../controllers/fiat_wallet/transaction_controller.dart';
import '../../../data/models/order_model.dart';
import '../../widgets/widgets.dart';
import 'address_courier.dart';

Future<bool>? fetchData;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final TextEditingController _searchController = TextEditingController();
  String get searchItem => _searchController.text;
  TransactionController transactionController =
      Get.put(TransactionController());
  @override
  void initState() {
    super.initState();
    setState(() {
      // postController.getPosts();
      fetchData = getCartItems();
      getBVNStatus();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        resetTotalPrice();
      });
      orderList.clear();
      checkedItems.clear();
    });
  }

  void resetTotalPrice() {
    cartController.clearPrice();
  }

  bool? BVNisSubmited = false;
  getBVNStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BVNisSubmited = prefs.getBool('bvnSubmission');
  }

  Future<bool> getCartItems() async {
    var data = await cartController.fetchCart();
    print("initState() called cart");
    if (data != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  CartController cartController = Get.put(CartController());
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
                    )),
              ),
            ); // Show a loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // cartController.clearPrice();
            return Scaffold(
              backgroundColor: const Color(0xffF1F1F1),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, bottom: 20, right: 25.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 20.0, 25, 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            icon: const Icon(Icons.arrow_back),
                                            onPressed: () {
                                              cartController.totalPrice.value =
                                                  0;
                                              orderList.clear();
                                              checkedItems.clear();
                                              // Get.to(
                                              //   () => HomePage(navIndex: 0),
                                              // );
                                              Get.back();
                                              cartController.totalPrice.value =
                                                  0;
                                            }),
                                      ],
                                    ),
                                  ),
                                  sizeVer(15.0),
                                  SearchWidget(
                                    controller: _searchController,
                                    onChanged: (searchItem){

                                    }
                                  ),
                                  sizeVer(50.0),
                                  ListView.builder(
                                      itemCount: cartController
                                          .cartModel!.value.products!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            CartCard(index: index),
                                            Divider(
                                              thickness: 1,
                                              color: Colors.grey[300],
                                            )
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svgs/money_checkout.svg",
                                      color: const Color(0xff29844B),
                                    ),
                                    sizeHor(10.0),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Total estimate",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: const Color(0xff29844B),
                                                fontWeight: FontWeight.w400,
                                              )),
                                          Obx(() {
                                            return Text(
                                                cartController.cartModel != null
                                                    ? "NGN ${cartController.totalPrice.value}"
                                                    : "NGN",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff29844B),
                                                  fontWeight: FontWeight.w600,
                                                ));
                                          }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              sizeHor(10.0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    BVNisSubmited =
                                        prefs.getBool('bvnSubmission');
                                    if (userController.userModel.value
                                            .virtualAccountNumber !=
                                        null) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      setState(() {
                                        isLoading = false;
                                      });
                                      for (var product in checkedItems) {
                                        orderList.add(Order(
                                            id: "${product.id}",
                                            units: product.unit));
                                      }
                                      if (checkedItems.isNotEmpty &&
                                          (userController.userModel.value
                                                  .virtualAccountNumber !=
                                              null) &&
                                          BVNisSubmited != null) {
                                        Get.to(() => const AddressCourier());
                                      }
                                    } else if ((userController.userModel.value
                                                .virtualAccountNumber ==
                                            null) &&
                                        BVNisSubmited != null) {
                                      if (BVNisSubmited!) {
                                        ErrorSnackbar.show(context,
                                            "Your BVN is awaiting verification");
                                      } else {
                                        ErrorSnackbar.show(context,
                                            "Please kindly go to verifications and submit your BVN for verification to create your virtual account ");
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
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
                                        // transform: GradientRotation(89.94 * 3.14 / 180),
                                      ),
                                    ),
                                    child: isLoading
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.16,
                                                vertical: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02),
                                            child:
                                                const CircularProgressIndicator(
                                                    color: Colors.white),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "CheckOut",
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              sizeHor(5.0),
                                              Flexible(
                                                child: const Icon(
                                                  Icons.arrow_forward,
                                                  color: primaryColor,
                                                  size: 30,
                                                ),
                                              )
                                            ],
                                          ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}

CartController cartController = Get.put(CartController());
UserController userController = Get.put(UserController());
OrderController orderController = Get.put(OrderController());
List? cartItems = cartController.cartModel.value.products;
List<Product> checkedItems = [];
List<Order> orderList = [];
bool? isSelected;
bool isLoading = false;

class CartCard extends StatefulWidget {
  final int index;
  const CartCard({super.key, required this.index});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int _count = 1;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30.0,
              width: 20.0,
              child: Checkbox(
                value: this.value,
                activeColor: Color(0xff29844B),
                onChanged: (value) async {
                  setState(() {
                    this.value = value!;
                  });

                  if (value!) {
                    setState(() {
                      cartController.totalPrice += cartController
                          .cartModel!.value.products![widget.index].amount!;
                      checkedItems.add(cartController
                          .cartModel.value.products![widget.index]);
                      cartController.updateUnitPerItem(1, widget.index);
                    });
                  }
                  if (!value) {
                    setState(() {
                      cartController.totalPrice -= cartController
                          .cartModel!.value.products![widget.index].amount!;
                      checkedItems.remove(cartController
                          .cartModel.value.products![widget.index]);
                    });
                  }
                },
              ),
            ),
            sizeHor(10.0),
            Flexible(
              child: Text(
                overflow: TextOverflow.ellipsis,
                cartController.cartModel!.value.products![widget.index].title !=
                        null
                    ? "${cartController.cartModel!.value.products![widget.index].title}"
                    : "",
                style: GoogleFonts.montserrat(
                    color: darkColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
            ),
            sizeHor(10.0),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  cartController
                              .cartModel!.value.products![widget.index].from !=
                          null
                      ? "from ${cartController.cartModel!.value.products![widget.index].from}"
                      : "",
                  style: GoogleFonts.montserrat(
                      color: darkColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ),
            ),
          ],
        ),
        sizeVer(15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 77.34,
              height: 72.26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: cartController
                          .cartModel!.value.products![widget.index].image !=
                      null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        cartController
                            .cartModel!.value.products![widget.index].image![0],
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(),
            ),
            sizeHor(15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          cartController.cartModel!.value
                                      .products![widget.index].body !=
                                  null
                              ? "${cartController.cartModel!.value.products![widget.index].body}"
                              : "",
                          style: TextStyle(color: darkColor),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          successDialog(context, widget.index);
                        },
                        icon: Icon(Icons.delete_outlined),
                        color: Colors.red,
                      ),
                    ],
                  ),
                  sizeVer(10),
                  Text(
                    cartController.cartModel!.value.products![widget.index]
                                .amount! !=
                            null
                        ? "NGN ${cartController.cartModel!.value.products![widget.index].amount!}"
                        : "NGN",
                    style: GoogleFonts.montserrat(
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
                        // child: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     // Text("NGN 30000",
                        //     //     style: GoogleFonts.montserrat(
                        //     //       color: const Color.fromRGBO(0, 0, 0, 1),
                        //     //       fontSize: 10,
                        //     //       decoration: TextDecoration.lineThrough,
                        //     //       decorationColor: Colors.black,
                        //     //       decorationThickness: 2.0,
                        //     //     )),
                        //     sizeVer(5.0),
                        //     Text(
                        //         cartController.cartModel![widget.index].title !=
                        //                 null
                        //             ? "${cartController.cartModel![widget.index].title}"
                        //             : "",
                        //         style: GoogleFonts.sourceSansPro(
                        //           color: const Color.fromRGBO(0, 0, 0, 1),
                        //           fontSize: 12,
                        //         )),
                        //   ],
                        // ),
                      ),
                      // sizeHor(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (_count == 1 && !value) {
                                setState(() {
                                  _count++;
                                  cartController.updateQuantityPerItem(_count);
                                  cartController.updateUnitPerItem(
                                      _count, widget.index);
                                  // orderController.updateOrdersUnit(
                                  //     _count, widget.index);
                                });
                                setState(() {
                                  cartController.totalPrice += cartController
                                          .cartModel!
                                          .value
                                          .products![widget.index]
                                          .amount! *
                                      2;
                                  value = true;
                                  checkedItems.add(cartController
                                      .cartModel.value.products![widget.index]);
                                });
                              }
                              // else if(_count < 1){
                              //
                              // }
                              else {
                                setState(() {
                                  _count++;
                                  cartController.updateQuantityPerItem(_count);
                                  cartController.updateUnitPerItem(
                                      _count, widget.index);
                                  // orderController.updateOrdersUnit(
                                  //     _count, widget.index);
                                });
                                setState(() {
                                  cartController.totalPrice += cartController
                                      .cartModel!
                                      .value
                                      .products![widget.index]
                                      .amount!;
                                });
                              }
                            },
                            icon: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(231, 231, 231, 1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Color.fromRGBO(41, 45, 50, 1),
                                size: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Text(
                              '$_count',
                              style: GoogleFonts.montserrat(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // _decrement();
                              // setState(() {
                              //   cartController.totalPrice -= cartController
                              //       .cartModel![widget.index].amount!;
                              // });
                              if (_count > 1) {
                                setState(() {
                                  _count--;
                                  cartController.updateQuantityPerItem(_count);
                                  cartController.updateUnitPerItem(
                                      _count, widget.index);
                                  // orderController.updateOrdersUnit(
                                  //     _count, widget.index);
                                });
                                setState(() {
                                  cartController.totalPrice -= cartController
                                      .cartModel!
                                      .value
                                      .products![widget.index]
                                      .amount!;
                                });
                              }
                            },
                            icon: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(231, 231, 231, 1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.remove,
                                color: Color.fromRGBO(41, 45, 50, 1),
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Future<dynamic> successDialog(BuildContext context, int index) {
  return showDialog(
    context: context,
    barrierDismissible:
        true, // Set to true if you want to allow dismissing the dialog by tapping outside it
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
                        'Are you sure you want to remove this item',
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
                  title: 'Yes, remove it',
                  onPressed: () async {
                    bool created = false;
                    created = await cartController.removeItem(
                        cartController.cartModel!.value.products![index].id);
                    if (created) {
                      cartController.updateCartItems();
                      await cartController.fetchCart();
                      Get.to(() => HomePage(navIndex: 0));
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 20),
                child: Center(
                  child: DialogWhiteButton(
                    title: 'No, Keep the item',
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
