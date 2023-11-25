// import "package:flutter/material.dart";
// import "dart:developer";
// import 'package:get/get.dart';
// import "package:gonana/consts.dart";
// import "package:gonana/features/controllers/market/market_controllers.dart";
// import "package:gonana/features/presentation/page/market/cart_page.dart";
// import "package:gonana/features/presentation/widgets/widgets.dart";
//
// class AllSearchedProducts extends StatefulWidget {
//   const AllSearchedProducts({super.key});
//
//   @override
//   State<AllSearchedProducts> createState() => _AllSearchedProductsState();
// }
//
// class _AllSearchedProductsState extends State<AllSearchedProducts> {
//   ProductController marketController = Get.put(ProductController());
//   late Future<bool> fetchData;
//
//   @override
//   void initState() {
//     super.initState();
//     final searchResults = Get.arguments;
//     //var list = searchResults["searchData"];
//     String searchQuery = searchResults["searchQuery"];
//     fetchData = marketController.searchProduct(searchQuery);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final searchResults = Get.arguments;
//     String searchQuery = searchResults["searchQuery"];
//
//     return FutureBuilder<bool>(
//         future: fetchData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Container(
//               color: Colors.white,
//               child: Center(
//                 child: Container(
//                   height: 75,
//                   width: 75,
//                   child: const CircularProgressIndicator(
//                     color: Color.fromRGBO(41, 132, 75, 1),
//                   ),
//                 ),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (!snapshot.data!) {
//             return Container(
//               color: Colors.white,
//               child: const Center(
//                 child: Padding(
//                   padding: EdgeInsets.all(10.0),
//                   child: Text(
//                     'No network connection. Please check your internet connection.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700),
//                   ),
//                 ),
//               ),
//             );
//           } else {
//             return Scaffold(
//                 backgroundColor: const Color(0xffF1F1F1),
//                 appBar: AppBar(
//                     backgroundColor: Colors.transparent,
//                     elevation: 0,
//                     leading: IconButton(
//                       icon: const Icon(Icons.arrow_back),
//                       color: Colors.black,
//                       onPressed: () {
//                         Get.back();
//                       },
//                     )),
//                 body: SafeArea(
//                     child: ListView(children: [
//                   Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 15.0, vertical: 15.0),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Results for: $searchQuery",
//                                 style: const TextStyle(
//                                     fontSize: 25.0,
//                                     fontWeight: FontWeight.bold,
//                                     color: secondaryColor)),
//                             SizedBox(
//                                 child: ListView.builder(
//                                     itemCount: marketController
//                                         .searchedProducts.length,
//                                     shrinkWrap: true,
//                                     itemBuilder: (context, index) {
//                                       var sProducts = marketController
//                                           .searchedProducts[index];
//                                       return Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                             vertical: 8,
//                                           ),
//                                           child: Text(
//                                               "product: ${marketController.searchedProducts[index].title}"));
//                                     }))
//                           ]))
//                 ])));
//           }
//         });
//   }
// }
//
// class HotDealsCard extends StatefulWidget {
//   final int index;
//   const HotDealsCard({
//     super.key,
//     required this.index,
//   });
//
//   @override
//   State<HotDealsCard> createState() => _HotDealsCardState();
// }
//
// class _HotDealsCardState extends State<HotDealsCard> {
//   final marketController = Get.find<ProductController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               InkWell(
//                 onTap: () {
//                   // Navigator.pushNamed(context, PageConst.checkoutPage);
//                 },
//                 child: Container(
//                   width: 115,
//                   height: 103,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     // image: const DecorationImage(
//                     //   image: AssetImage('assets/images/image 4.png'),
//                     //   fit: BoxFit.cover,
//                     // ),
//                   ),
//                   child: marketController.discountMarketModel!.data != null &&
//                           widget.index >= 0 &&
//                           widget.index <
//                               marketController
//                                   .discountMarketModel!.data!.length &&
//                           marketController.discountMarketModel!
//                                   .data![widget.index].images !=
//                               null &&
//                           marketController.discountMarketModel!
//                               .data![widget.index].images!.isNotEmpty
//                       ? ClipRRect(
//                           child: Image.network(
//                             "${marketController.discountMarketModel!.data![widget.index].images![0]}",
//                             fit: BoxFit.cover,
//                           ),
//                         )
//                       : Container(),
//                 ),
//               ),
//             ],
//           ),
//           sizeHor(15.0),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '${marketController.discountMarketModel!.data![widget.index].body}',
//                   style: const TextStyle(color: darkColor),
//                 ),
//                 sizeVer(10),
//                 Text(
//                   "${marketController.discountMarketModel!.data![widget.index].amount}",
//                   style: const TextStyle(
//                       fontSize: 20,
//                       color: greenColor,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 sizeVer(4.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Flexible(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 8.0),
//                         child: Container(
//                           child: FutureBuilder<String?>(
//                             future: marketController
//                                 .discountedProductAddress(widget.index),
//                             builder: (BuildContext context,
//                                 AsyncSnapshot<String?> snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return const CircularProgressIndicator();
//                               } else if (snapshot.hasError) {
//                                 return Text("Error: ${snapshot.error}",
//                                     style: const TextStyle(
//                                         color: Color(0xff000000),
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w700));
//                               } else {
//                                 return Text(
//                                   snapshot.data ?? "",
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 14,
//                                     fontFamily: 'Proxima Nova',
//                                     fontWeight: FontWeight.w400,
//                                     height: 0.92,
//                                   ),
//                                 );
//                               }
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 60,
//                       width: MediaQuery.of(context).size.width * 0.2,
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           bool created = false;
//                           created = await cartController.addToCart(
//                               marketController
//                                   .discountMarketModel!.data![widget.index].id,
//                               context);
//                           if (created) {
//                             await cartController.fetchCart();
//                             SuccessSnackbar.show(context, "Item added to cart");
//                             cartController.updateCartItems();
//                           }
//                         },
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all<Color>(greenColor),
//                           foregroundColor:
//                               MaterialStateProperty.all<Color>(primaryColor),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 13.0),
//                           child: Text('Add to cart'),
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
