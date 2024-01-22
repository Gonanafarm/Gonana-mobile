import 'package:get/get.dart';

class CryptoPayController extends GetxController {
  RxString tokenName = "ETH".obs;
  RxList<String> tokenNamesList = <String>[].obs;
  RxString tokenLogo = "eth".obs;
  RxString tokenValue = "0".obs;

  void updateTokens(String newTokenName, String newTokenLogo) {
    tokenName.value = newTokenName;
    tokenLogo.value = newTokenLogo;
    update();
  }
}
