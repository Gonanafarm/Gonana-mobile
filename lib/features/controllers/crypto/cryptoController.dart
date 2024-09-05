import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../data/models/order_model.dart';
import '../../presentation/page/market/product_checkout.dart';
import '../../presentation/widgets/widgets.dart';
import '../../utilities/api_routes.dart';
import '../../utilities/network.dart';
import '../fiat_wallet/transaction_controller.dart';

class CryptoPayController extends GetxController {
  RxString tokenName = "CCD".obs;
  RxList<String> tokenNamesList = <String>[].obs;
  RxString tokenLogo = "ccd".obs;
  RxString tokenValue = "0".obs;

  final transactionController = Get.find<TransactionController>();

  RxDouble converted = 0.0.obs;
  getTokenPrice() async {
    converted.value =
        await transactionController.ngnToToken("$totalPriceInNaira");
    if (converted != 0.0) {
      converted.value = converted.value;
      update();
    }
    // return converted.value;
  }

  void updateTokens(String newTokenName, String newTokenLogo) {
    tokenName.value = newTokenName;
    tokenLogo.value = newTokenLogo;
    update();
  }

  Future<bool> cryptoPlaceOrder(
      List<Order> order, String serviceCode, var context) async {
    try {
      var data = {"orders": order, "service_code": serviceCode};
      log("data: $data");
      for (var item in order) {
        print('Order ID: ${item.id}');
        print('Units: ${item.units}');
      }
      var res =
          await NetworkApi().authPostData(data, ApiRoute.cryptoPlaceOrder);
      var response = jsonDecode(res.body);
      print("got here");
      log('Message: $response');
      log('status code: ${res.statusCode}');
      if (res.statusCode == 201) {
        SuccessSnackbar.show(context, "Successful");
        return true;
      } else {
        ErrorSnackbar.show(context, response["message"]);
        return false;
      }
    } catch (e, s) {
      log("checkOut Error=> $e");
      log("checkOut Stack=> $s");
      return false;
    }
  }
}
