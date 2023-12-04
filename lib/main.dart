import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/auth/get_details.dart';
import 'package:gonana/features/controllers/cart/cart_controller.dart';
import 'package:gonana/features/presentation/page/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:upgrader/upgrader.dart';
import 'features/controllers/user/user_controller.dart';
import 'features/presentation/page/auth/auth_passcode.dart';
import 'features/presentation/page/auth/emailverification.dart';
import 'features/presentation/page/auth/auth_splash1.dart';
import 'features/presentation/page/auth/sign_up_page.dart';
import 'features/presentation/page/profile_photo/add_profile_photo1.dart';
import 'features/utilities/page_routes.dart';
// import 'package:flutter/services.dart' show PlatformException;

late Future<bool> fetchData;
GetDetailsController detailsController = Get.put(GetDetailsController());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(CartController());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserController userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    getToken();
    setState(() { 
      // postController.getPosts();
      fetchData = detailsController.getUserDetails();
    });
    // initUniLinks();
    setStage();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showLoading = false;
        });
      }
    });
  }

  // StreamSubscription? _sub;
  //
  // Future<void> initUniLinks() async {
  //   // ... check initialLink
  //
  //   // Attach a listener to the stream
  //   _sub = linkStream.listen((String? link) {
  //     // Parse the link and warn the user, if it is not correct
  //     if (link != null) {
  //       print("Listener is working");
  //       var uri = Uri.parse(link);
  //       if (uri.queryParameters['id'] != null) {
  //         print(uri.queryParameters['id'].toString());
  //         Navigator.of(context).push(
  //             MaterialPageRoute(builder: (context) => HomePage(navIndex: 2)));
  //       }
  //     }
  //   }, onError: (err) {
  //     // Handle exception by warning the user their action did not succeed
  //   });
  //
  //   // NOTE: Don't forget to call _sub.cancel() in dispose()
  // }

  int? registrationStage;
  setStage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    registrationStage = prefs.getInt('registrationStage');
    bool? BVNisSubmited = prefs.getBool('bvnSubmission');
    print("BVN status $BVNisSubmited");
  }

  void getToken() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool showLoading = true;

  var token;
  SharedPreferences? prefs;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: FutureBuilder<bool>(
        future: fetchData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xff29844B), Color(0xff003633)])),
                child: Center(
                  child: Container(
                    // height: 150,
                    // width: 150,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Center(child: Image.asset('assets/images/whit1.png')),
                      ],
                    ),
                    // CircularProgressIndicator(
                    //   color: Color.fromRGBO(41, 132, 75, 1),
                    // )),
                  ),
                ));
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
            token = prefs!.getString('token');
            print("token: $token");
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              getPages: getPages,
              home: token != null && registrationStage == 5
                  ? UpgradeAlert(child: HomePage(navIndex: 0))
                  : token != null && registrationStage == 4
                      ? const SetPasscode()
                      : token != null && registrationStage == 3
                          ? const AddProfilePhoto()
                          : token != null && registrationStage == 2
                              ? const Verification()
                              : token != null && registrationStage == 1
                                  ? const SignUp()
                                  : const Splash1(),
              // home: Splash(),
            );
          }
        },
      ),
    );
  }
}
