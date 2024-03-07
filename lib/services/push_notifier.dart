import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/controllers/auth/notification_controller.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotifier {
  NotificationController notificationController =
      Get.put(NotificationController());
  Future<void> initPlatform() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId("0dee701d-4cde-4850-a1c3-fb34903f65b1");
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted ");
    });
  }

  Future<void> updatePlayerId() async {
    OneSignal.shared.getDeviceState().then((value) {
      print("Id: ${value!.userId}");
      notificationController.registerPlayerId(value!.userId ?? '');
    });
  }
}
