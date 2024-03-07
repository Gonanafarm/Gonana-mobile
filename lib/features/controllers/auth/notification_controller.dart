import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../utilities/api_routes.dart';
import '../../utilities/network.dart';

class NotificationController extends GetxController {
  Future<bool> registerPlayerId(String id) async {
    try {
      var data = {'id': id};
      var res =
          await NetworkApi().authPostData(data, ApiRoute.registerPlayerId);
      final result = jsonDecode(res.body);
      if (res.statusCode == 201) {
        log('$result');
        log("Success ${res.statusCode}");
        return true;
      } else {
        log("Failed ${res.statusCode}");
        print(res['message']);
        return false;
      }
    } catch (e) {
      log("Register error Error=> $e");
      return false;
    }
  }
}
