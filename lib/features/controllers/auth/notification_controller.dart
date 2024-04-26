import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../data/models/notification_model.dart';
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

  Rx<NotificationModel> notificationModel =
      Rx<NotificationModel>(NotificationModel());
  Future<bool> fetchNotification() async {
    try {
      var responseBody =
          await NetworkApi().authGetData(ApiRoute.fetchNotifications);
      final response = jsonDecode(responseBody.body);
      print("notification got here $response");
      notificationModel.value = notificationModelFromJson(responseBody.body);
      log("all cart items || ${notificationModel.value}");
      log("all cart items || $response");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
