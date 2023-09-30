import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/auth/get_details.dart';
import 'package:gonana/features/controllers/cart/cart_controller.dart';
import 'package:gonana/features/presentation/page/feeds/create_post2.dart';
import 'package:gonana/features/presentation/page/home.dart';
import 'package:gonana/features/presentation/page/market/cart_page.dart';
import 'package:gonana/features/presentation/page/savings/view_savings.dart';
// import 'package:gonana/features/presentation/page/security/security.dart';
import 'package:gonana/features/presentation/page/security/security.dart';
import 'package:gonana/features/presentation/page/send/send_chart.dart';
import 'package:gonana/features/presentation/page/settings/delete_account.dart';
import 'package:gonana/features/presentation/page/store/store_edit_product.dart';
import 'package:gonana/features/presentation/widgets/custom_tab_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import 'features/controllers/market/market_controllers.dart';
import 'features/controllers/post/post_controllers.dart';
import 'features/controllers/user/user_controller.dart';
import 'features/presentation/page/auth/auth_passcode.dart';
import 'features/presentation/page/auth/emailverification.dart';
import 'features/presentation/page/auth/facial_recognition.dart';
import 'features/presentation/page/auth/facial_capture.dart';
import 'features/presentation/page/auth/forgotpassword.dart';
import 'features/presentation/page/auth/number_verification_screen.dart';
import 'features/presentation/page/auth/register_bank.dart';
import 'features/presentation/page/auth/setpassword.dart';
import 'features/presentation/page/auth/auth_splash1.dart';
import 'features/presentation/page/auth/sign_in_page.dart';
import 'features/presentation/page/auth/sign_up_page.dart';
import 'features/presentation/page/bank_account/add_bank_account.dart';
import 'features/presentation/page/bank_account/add_card.dart';
import 'features/presentation/page/bank_account/add_card_passcode.dart';
import 'features/presentation/page/bank_account/bank_account.dart';
import 'features/presentation/page/bank_account/confirm_card_details.dart';
import 'features/presentation/page/crypto_pay/crypto_pay.dart';
import 'features/presentation/page/feeds/feed_page.dart';
import 'features/presentation/page/market/buy_now.dart';
import 'features/presentation/page/market/delivery_modal.dart';
import 'features/presentation/page/market/hot_deals.dart';
import 'features/presentation/page/market/market_page.dart';
import 'features/presentation/page/nextofkin/editnok.dart';
import 'features/presentation/page/nextofkin/nextofkin.dart';
import 'features/presentation/page/profile_photo/add_profile_photo1.dart';
import 'features/presentation/page/referrals/referrals.dart';
import 'features/presentation/page/savings/confirm_details.dart';
import 'features/presentation/page/savings/savings_amount.dart';
import 'features/presentation/page/savings/savings_details.dart';
import 'features/presentation/page/savings/savings_duration.dart';
import 'features/presentation/page/savings/savings_splash.dart';
import 'features/presentation/page/savings/savings_withdrawal.dart';
import 'features/presentation/page/security/confirm_changed_password.dart';
import 'features/presentation/page/security/confirm_changed_pin.dart';
import 'features/presentation/page/security/currency.dart';
import 'features/presentation/page/security/reset_password.dart';
import 'features/presentation/page/security/verify_changed_password.dart';
import 'features/presentation/page/settings/edit_profile.dart';
import 'features/presentation/page/settings/settiings_profile.dart';
import 'features/presentation/page/settings/settings.dart';
import 'features/presentation/page/settings/settings_details.dart';
import 'features/presentation/page/staking/staking_earnings.dart';
import 'features/presentation/page/staking/staking_splash.dart';
import 'features/presentation/page/store/store_add_poduct.dart';
import 'features/presentation/page/store/store_add_poduct2.dart';
import 'features/presentation/page/store/store_confirm_screen.dart';
import 'features/presentation/page/store/store_logistics.dart';
import 'features/presentation/page/store/store_view-product.dart';
import 'features/presentation/page/swap/passcode.dart';
import 'features/presentation/page/swap/swap_page.dart';
import 'features/presentation/page/verification/verification.dart';
import 'features/presentation/page/verification/verification_bvn.dart';
import 'features/presentation/page/verification/verification_drivers_license.dart';
import 'features/presentation/page/verification/verification_international_passport.dart';
import 'features/presentation/page/verification/verification_nin.dart';
import 'features/presentation/page/verification/verification_voters_card.dart';
import 'features/presentation/page/wallet/wallet_deposit.dart';
import 'features/presentation/page/wallet/wallet_withdrawal.dart';
import 'features/presentation/page/wallet/wallet_withdrawal_bank.dart';
import 'features/presentation/page/market/address_courier.dart';

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
    setStage();
  }

  int? registrationStage;
  setStage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    registrationStage = prefs.getInt('registrationStage');
  }

  void getToken() async {
    prefs = await SharedPreferences.getInstance();
  }

  var token;
  SharedPreferences? prefs;
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
          token = prefs!.getString('token');
          print("token: $token");
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home:token != null && registrationStage == 5
                  ? UpgradeAlert(child: HomePage(navIndex: 0))
                  : token != null && registrationStage == 4
                      ? const SetPasscode()
                      : token != null && registrationStage == 3
                          ? const AddProfilePhoto()
                              : token != null && registrationStage == 2
                                  ? const Verification()
                                  : token != null && registrationStage == 1
                                      ? const SignUp()
                                      : const Splash1()
          );
        }
      },
    );
  }
}

