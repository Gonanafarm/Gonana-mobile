import 'package:get/get.dart' as getx;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SwapController extends GetxController {
  static SwapController get instance => Get.find();

  RxString tokenNameFrom = ("Gona").obs;
  RxString tokenLogoFrom = ("gona_logo").obs;
  RxString tokenNameTo = ("USDT").obs;
  RxString tokenLogoTo = ("usdt_logo").obs;

  void updateTokensFrom(String newTokenName, String newTokenLogo) {
    tokenNameFrom.value = newTokenName;
    tokenLogoFrom.value = newTokenLogo;
    update();
  }

  void updateTokensTo(String newTokenName, String newTokenLogo) {
    tokenNameTo.value = newTokenName;
    tokenLogoTo.value = newTokenLogo;
    update();
  }
}
