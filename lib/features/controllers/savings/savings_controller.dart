import 'package:get/get.dart';

class SavingsController extends GetxController {
  // static SavingsController get instance => Get.find();

  RxString tokenName = "Gona".obs;
  RxList<String> tokenNamesList = <String>[].obs;
  RxString tokenLogo = "gona_logo".obs;
  RxList<String> tokenLogosList = <String>[].obs;
  RxInt duration = 0.obs;
  RxDouble interestRate = 0.00.obs;
  RxDouble savingsAmount = 23000.00.obs;
  RxList<double> savingsAmountList = <double>[].obs;

  void updateTokens(String newTokenName, String newTokenLogo) {
    tokenName.value = newTokenName;
    tokenLogo.value = newTokenLogo;
    update();
  }

  void addTokens() {
    tokenNamesList.value.add(tokenName.value);
    tokenLogosList.value.add(tokenLogo.value);
    update();
  }

  void updateInterestRate(double newInterest) {
    interestRate.value = newInterest;
    update();
  }

  void updateDuration(int newDuration) {
    duration.value = newDuration;
    update();
  }

  void updateSavingsAmount(double newAmount) {
    savingsAmount.value = newAmount;
    update();
  }

  void addSavingsAmount() {
    savingsAmountList.value.add(savingsAmount.value);
    update();
  }
}
