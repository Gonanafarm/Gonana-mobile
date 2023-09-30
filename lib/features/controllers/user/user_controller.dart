import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart' as getx;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:gonana/features/data/models/user_model.dart';
import 'package:gonana/features/presentation/page/settings/settiings_profile.dart';
import 'package:gonana/features/utilities/api_routes.dart';
import 'package:gonana/features/utilities/network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class UserController extends GetxController {
  // String token = '';
  String userId = "";
  RxString userEmail = "".obs;
  RxInt registrationStage = 0.obs;
  var userModel = UserModel().obs;

  void updateEmail(String newEmail) {
    userEmail.value = newEmail;
    update();
  }

  void updateStage(int newStage) {
    registrationStage.value = newStage;
    update();
  }

  Future<bool> fetchUserByEmail() async {
    try {
      // print(userEmail);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userEmailAdd = prefs.getString('userEmail');
      print("email addy ${userEmailAdd}");
      var responseBody = await NetworkApi()
          .authGetData("${ApiRoute.fetchUserByEmail}/$userEmailAdd");
      // final response = jsonDecode(responseBody.body);
      userModel.value = userModelFromJson(responseBody.body);
      update();
      log("${userModel.value.user!.firstName}");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> fetchUserById() async {
    try {
      var responseBody =
          await NetworkApi().authGetData("${ApiRoute.fetchUserById}/$userId");
      userModel.value = userModelFromJson(responseBody);
      log("user profile || $responseBody");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> uploadProfilePhoto(String? email, File? image) async {
    MultipartFile productImage;

    String id = DateTime.now().millisecondsSinceEpoch.toString();
    // Map<String, dynamic> noMediaReq = {}..addAll(val);
    productImage = await MultipartFile.fromFile(
      image!.path,
      filename: '$id/${image}',
    );
    FormData formData = FormData.fromMap({
      'email': email,
      'file': productImage,
    });
    log("FD =>${formData.fields}");
    print("MultipartFile Info => ${productImage}");
    try {
      var res = await NetworkApi()
          .patchData(formData: formData, routeUrl: ApiRoute.uploadProfilePhoto);
      // final response = jsonDecode(responseBody.body);
      log("image response || $res");
      print(res.statusCode);
      // log(res);

      return true;
    } on DioException catch (e, s) {
      log('e=>$e');
      log('s=.>$s');
      return false;
    }
  }

  Future<bool> updateProfile(
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
  ) async {
    //print(countryId.runtimeType);
    var data = {
      'first_name': firstName.toString(),
      'last_name': lastName.toString(),
      'phone': phone.toString(),
      'email': email.toString(),
      'account_type': "FARMER",
    };
    try {
      var res = await NetworkApi().putData(data, ApiRoute.putUpdateProfile);
      final response = jsonDecode(res.body);
      log("all cart items || ${res.body}");
      Get.to(() => SettingsProfile());
      return true;
      // final result = jsonDecode(res.body);
      // log(result);
      // if (res.statusCode == 200) {
      //   log("Success ${res.statusCode}");
      //   Get.to(() => SettingsProfile());
      // } else {
      //   log("Failed ${res.statusCode}");
      // }
      // return true;
    } catch (e) {
      log("UpdateProfile Error=> $e");
      return false;
    }
  }
}
