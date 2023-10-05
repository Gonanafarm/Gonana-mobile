import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../presentation/widgets/widgets.dart';
import '../utilities/api_routes.dart';
import '../utilities/network.dart';

class TransactionController extends GetxController {

  Future<bool> verifyBVN(String bvn, var context) async {
    try {
      var data = {
        'bvn': bvn,
      };
      print(data);
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.verifyBVN);
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("BVN verification|| $response");
      if (responseBody.statusCode == 201) {
        SuccessSnackbar.show(context,
            "BVN submitted successfully,\n you would get a an email concerning your email verification");
        return true;
      } else {
        ErrorSnackbar.show(context, "${response['message']}");
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
