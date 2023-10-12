import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/market/market_controllers.dart';
import 'package:gonana/features/controllers/post/post_controllers.dart';
import 'package:gonana/features/controllers/user/user_controller.dart';
import 'package:gonana/features/presentation/page/feeds/feed_page.dart';
import 'package:gonana/features/presentation/page/notification/notification.dart';
import 'package:gonana/features/presentation/page/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../consts.dart';
import 'fiat_wallet/wallet_home.dart';
import 'market/market_page.dart';
import 'wallet/wallet_page.dart';

class HomePage extends StatefulWidget {
  late int navIndex;
  HomePage({super.key, required this.navIndex});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostController postsController = Get.put(PostController());
  ProductController productController = Get.put(ProductController());
  UserController userController = Get.put(UserController());

  getBVNStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('bvnSubmission') == null) {
      prefs.setBool('bvnSubmission', false);
    }
  }

  @override
  void initState() {
    super.initState();
    getBVNStatus();
  }

  final screens = [
    const MarketPage(),
    // const WalletPage(),
    const FiatWalletHome(),
    const FeedsPage(),
    // const Notifications(),
    const Settings(),
  ];
  // late Future<bool> fetchData;
  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     // postController.getPosts();
  //     fetchData = getUserDetails();
  //   });
  // }
  //
  // Future<bool> getPosts() async {
  //   var data = await postsController.getPosts();
  //   print("initState() called posts");
  //   if (data != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //
  // Future<bool> getProducts() async {
  //   var data = await productController.fetchProduct();
  //   var data2 = await productController.fetchUserProduct();
  //   print("initState() called products");
  //   if (data != null && data2 != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //
  // Future<bool> getDiscountedProducts() async {
  //   var data = await productController.fetchDiscountedProducts();
  //   print("initState() called discount");
  //   if (data != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //
  // Future<bool> getUserDetails() async {
  //   var data1 = await userController.fetchUserByEmail();
  //   var data2 = await getDiscountedProducts();
  //   var data3 = await getProducts();
  //   var data4 = await getPosts();
  //   print("User details gotten");
  //   if (data1 != false && data2 != false && data3 != false && data4 != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // int currentIndex = widget.navIndex;
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<bool>(
    //   future: fetchData,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Container(
    //         color: Colors.white,
    //         child: Center(
    //           child: Container(
    //               height: 100,
    //               width: 100,
    //               child: CircularProgressIndicator(
    //                 color: Color.fromRGBO(41, 132, 75, 1),
    //               )),
    //         ),
    //       ); // Show a loading indicator while waiting
    //     } else if (snapshot.hasError) {
    //       return Text('Error: ${snapshot.error}');
    //     } else {
    // Data has been fetched successfully, build your UI using snapshot.data
    return Scaffold(
      // body: IndexedStack(
      //   index: currentIndex,
      //   children: screens,
      // ),
      body: screens[widget.navIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.navIndex,
        onTap: (index) => setState(() {
          // currentIndex = widget.navIndex;
          widget.navIndex = index;
        }),
        selectedItemColor: const Color.fromRGBO(41, 132, 75, 1),
        unselectedItemColor: const Color.fromRGBO(41, 45, 50, 1),
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svgs/market.svg",
            ),
            label: "Market",
            //backgroundColor: greenColor
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svgs/money.svg",
            ),
            label: "Wallet",
            //backgroundColor: greenColor
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svgs/feed.svg",
            ),
            label: "Feeds",
          ),
          // BottomNavigationBarItem(
          //   icon: SvgPicture.asset(
          //     "assets/svgs/Notifications.svg",
          //   ),
          //   label: "Notification",
          // ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svgs/Settings.svg",
            ),
            label: "Settings",
          ),
        ],
      ),
    );
    //     }
    //   },
    // );
    // // return Scaffold(
    //   // body: IndexedStack(
    //   //   index: currentIndex,
    //   //   children: screens,
    //   // ),
    //   body: screens[widget.navIndex],
    //   bottomNavigationBar: BottomNavigationBar(
    //     currentIndex: widget.navIndex,
    //     onTap: (index) => setState(() {
    //       // currentIndex = widget.navIndex;
    //       widget.navIndex = index;
    //     }),
    //     selectedItemColor: const Color.fromRGBO(41, 132, 75, 1),
    //     unselectedItemColor: const Color.fromRGBO(41, 45, 50, 1),
    //     iconSize: 30,
    //     items: [
    //       BottomNavigationBarItem(
    //         icon: SvgPicture.asset(
    //           "assets/svgs/market.svg",
    //         ),
    //         label: "Market",
    //         //backgroundColor: greenColor
    //       ),
    //       BottomNavigationBarItem(
    //         icon: SvgPicture.asset(
    //           "assets/svgs/money.svg",
    //         ),
    //         label: "Wallet",
    //         //backgroundColor: greenColor
    //       ),
    //       BottomNavigationBarItem(
    //         icon: SvgPicture.asset(
    //           "assets/svgs/feed.svg",
    //         ),
    //         label: "Feeds",
    //       ),
    //       BottomNavigationBarItem(
    //         icon: SvgPicture.asset(
    //           "assets/svgs/Notifications.svg",
    //         ),
    //         label: "Notification",
    //       ),
    //       BottomNavigationBarItem(
    //         icon: SvgPicture.asset(
    //           "assets/svgs/Settings.svg",
    //         ),
    //         label: "Settings",
    //       ),
    //     ],
    //   ),
    // );
  }
}
