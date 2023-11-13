// ignore_for_file: invalid_use_of_protected_member, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:gonana/features/controllers/user/user_controller.dart';
import 'package:gonana/features/data/models/discounted_product_model.dart'
    as DiscountedModel;
import 'package:gonana/features/data/models/post_model.dart' as PostModel;
import 'package:gonana/features/data/models/user_model.dart';
import 'package:gonana/features/data/models/user_post_model.dart'
    as UserProductModel;
import 'package:gonana/features/presentation/page/store/store_logistics.dart';
import 'package:gonana/features/data/models/user_post_model.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import '../../../consts.dart';
import '../../utilities/api_routes.dart';
import 'package:dio/dio.dart';

import '../../utilities/network.dart';
// import 'package:cloudinary_flutter/cloudinary_context.dart';
// import 'package:cloudinary_dart/cloudinary.dart';

class ProductController extends GetxController {
  final userController = Get.put(UserController());
  String postItem = "";

  RxString title = "".obs;
  RxString body = "".obs;
  RxString logisticsMerchant = "Select from our verified merchant".obs;
  var image = File("").obs;
  var image2 = File("").obs;
  var image3 = File("").obs;
  RxInt amount = 0.obs;
  RxInt quantity = 0.obs;
  RxDouble weight = 0.00.obs;
  RxList categories = [].obs;
  var attachments = <String>[].obs;
  var displayAttachments = <File>[].obs;
  RxString address = "".obs;
  RxDouble geoLong = 0.0.obs;
  RxDouble geoLat = 0.0.obs;
  RxList<dynamic> images = [].obs;
  RxBool selfShipping = false.obs;
  RxBool isLoadingMoreRunning = false.obs;
  RxBool hasMore = false.obs;

  // void updateIsLoadingMoreRunning(bool newIsLoadingMoreRunning) {
  //   isLoadingMoreRunning.value = newIsLoadingMoreRunning;
  //   update();
  //   print("Updated loading: ${isLoadingMoreRunning.value}");
  // }

  void updateHasMore(bool newHasMore) {
    hasMore.value = newHasMore;
    update();
  }

  void updateTitle(String newTitle) {
    title.value = newTitle;
    update();
  }

  void updateBody(String newBody) {
    body.value = newBody;
    update();
  }

  void updateLogisticsMerchants(String newLogistics) {
    logisticsMerchant.value = newLogistics;
    update();
  }

  // void updateCoordinates(double newLat, double newLong) {
  //   coordinates.value.add(newLat);
  //   coordinates.value.add(newLong);
  //   update();
  // }

  void updateGeoLong(var newGeoLong) {
    geoLong.value = newGeoLong;
    update();
  }

  void updateGeoLat(var newGeoLat) {
    geoLat.value = newGeoLat;
    update();
  }

  void updateAddress(String newAddress) {
    address.value = newAddress;
    update();
  }

  void updateImage(var newImage) {
    image.value = newImage;
    update();
  }

  void updateImage2(var newImage) {
    image2.value = newImage;
    update();
  }

  void updateImage3(var newImage) {
    image3.value = newImage;
    update();
  }

  void updateAmount(String newAmount) {
    amount.value = int.tryParse(newAmount)!;
    update();
  }

  void updateQuantity(String newQuantity) {
    quantity.value = int.tryParse(newQuantity)!;
    update();
  }

  void updateWeight(String newWeight) {
    weight.value = double.parse(newWeight)!;
    update();
  }

  // void updateHashTags(List<String> newHashTags) {
  //   hashtags.value = newHashTags;
  //   update();
  // }

  void updateCategories(List<String> newCategories) {
    categories.value = newCategories;
    update();
  }

  void updateAttachments(var newDisplayAttachments, String newAttachments) {
    attachments.value.add(newAttachments);
    displayAttachments.value.add(newDisplayAttachments);
    // attachment.value = newAttachments;
    update();
  }

  void updateShipping(bool newShipping) {
    selfShipping.value = newShipping;
    update();
  }

  Future<bool> createProduct(
      String? title,
      String? body,
      //  List<File> images,
      File? image,
      File? image2,
      File? image3,
      String? categories,
      int? amount,
      int? quantity,
      double? weight,
      double? geoLong,
      double? geoLat,
      String? logisticMerchant,
      String? address,
      bool? selfShippping,
      var context) async {
    List<MultipartFile> files = [];

    if ((image == null || image!.path.isEmpty) &&
        (image2 == null || image2!.path.isEmpty) &&
        (image3 == null || image3!.path.isEmpty)) {
      ErrorSnackbar.show(context, "You have to select at least one image");
      return false;
    }
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    for (File? image in [image, image2, image3]) {
      if (image != null && image.path.isNotEmpty) {
        MultipartFile imagePartFile =
            await MultipartFile.fromFile(image.path, filename: "$id/${image!}");
        files.add(imagePartFile);
      }
    }

    FormData formData = FormData.fromMap({
      //"self_shipping": true,
      'title': title,
      'body': body,
      'type': 'product',
      'status': "published",
      'files': files,
      'categories': categories,
      'amount': amount,
      'quantity': quantity,
      'weight': weight,
      'geo_long': geoLong,
      'geo_lat': geoLat,
      'delivery_company': logisticMerchant,
      'address': address,
      'self_shipping': selfShippping
    });

    try {
      var res = await NetworkApi()
          .dioPost(formData: formData, routeUrl: ApiRoute.createPost);
      print("here");
      final result = jsonDecode(res.data);
      log('MarketResult => $result');
      // log(res);
      if (res.statusCode == 201) {
        SuccessSnackbar.show(context, "Product successfully created");
        return true;
      } else {
        ErrorSnackbar.show(context, result['message']);
        return false;
      }
    } on DioException catch (e, s) {
      log('productError=>$e');
      log('productErrorStack=.>$s');
      return false;
    }
  }

  // PostModel? marketModel;
  Rx<PostModel.PostModel> marketModel =
      Rx<PostModel.PostModel>(PostModel.PostModel());
  UserProductModel.UserPostModel? userMarketModel;
  int productLimit = 15;
  int discountedLimit = 15;
  int productPage = 1;
  Future<bool> fetchProduct() async {
    productPage = 1;
    try {
      var responseBody = await NetworkApi().authGetData(
          "api/catalog/posts?page=$productPage&limit=$productLimit&type=product");
      final response = jsonDecode(responseBody.body);
      //marketModel = marketModelFromJson(responseBody);
      print("products abeg $response");
      marketModel.value = PostModel.postModelFromJson(responseBody.body);
      print(response);
      print(marketModel!.value.data![0].product!.location!.coordinates);
      log("MarketProcuts: [$response]");
      // log("products || ${response}");
      return true;
    } catch (e, s) {
      print(e);
      print(s);
      return false;
    }
  }

  Future fetchMoreProducts() async {
    await productPage++;
    try {
      print("page test  $productPage");
      var responseBody = await NetworkApi().authGetData(
          "api/catalog/posts?page=$productPage&limit=$productLimit&type=product");
      var response = jsonDecode(responseBody.body);
      if (response != null &&
          marketModel.value != null &&
          marketModel.value.data != null &&
          marketModel.value.data!.isNotEmpty) {
        final dataToAdd = (response["data"] as List<dynamic>?)?.map((item) {
              return PostModel.Datum.fromJson(item);
            })?.toList() ??
            [];
        if (dataToAdd.length < productLimit) {
          updateHasMore(false);
        }
        marketModel.value.data!.addAll(dataToAdd);
        update();
        print("pagination got here $productPage");
        print("New data body: ${marketModel.value.data![1].product!.title}");
      }

      print(response);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  // Future<bool> fetchMoreProducts() async {
  //   page++;
  //   try {
  //     var responseBody = await NetworkApi()
  //         .authGetData("api/catalog/posts?page=$page&$limit=1&type=product");
  //     var response = jsonDecode(responseBody.body);
  //     print("products abeg $response");
  //     if (response != null) {
  //       marketModel.value.data!.add(response["data"]);
  //     }
  //     print(response);
  //     return true;
  //   } catch (e, s) {
  //     print(e);
  //     print(s);
  //     return false;
  //   }
  // }

  int userProductPage = 1;
  int userProductLimit = 15;
  Future<bool> fetchUserProduct() async {
    userProductPage = 1;
    try {
      var responseBody = await NetworkApi().authGetData(
          "api/catalog/posts/user-products?type=product&page=$userProductPage&limit=$userProductLimit");
      final response = jsonDecode(responseBody.body);
      //marketModel = marketModelFromJson(responseBody);
      userMarketModel =
          UserProductModel.userPostModelFromJson(responseBody.body);
      // print(userMarketModel!.data![0].location!.coordinates);
      log("Userproducts || ${response}");
      return true;
    } catch (e, s) {
      print(e);
      print(s);
      return false;
    }
  }

  Future fetchMoreUserProducts() async {
    await userProductPage++;
    try {
      print("page test 1 $userProductPage");
      var responseBody = await NetworkApi().authGetData(
          "api/catalog/posts/user-products?type=product&page=$userProductPage&limit=$userProductLimit");
      var response = jsonDecode(responseBody.body);
      if (response != null &&
          userMarketModel != null &&
          userMarketModel!.data != null &&
          userMarketModel!.data!.isNotEmpty) {
        final dataToAdd = (response["data"] as List<dynamic>?)?.map((item) {
              return UserProductModel.Datum.fromJson(item);
            })?.toList() ??
            [];
        // if (dataToAdd.length < limit) {
        //   updateHasMore(false);
        // }
        if (dataToAdd.isNotEmpty) {
          userMarketModel!.data!.addAll(dataToAdd);
          update();
          print("pagination got here $userProductPage");
          print("New data body: ${userMarketModel!.data!.length}");
          print("New data body: ${userMarketModel!.data![1]!.body}");
        }
        print(response);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<bool> deleteProductItem(String? productId) async {
    try {
      var data = {
        'product_id': productId,
      };
      var responseBody = await NetworkApi()
          .deleteData(data, "${ApiRoute.deleteProduct}/$productId");
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("deleted product || $response");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  DiscountedModel.DiscountedProductModel? discountMarketModel;
  int discountedProductPage = 1;
  Future<bool> fetchDiscountedProducts() async {
    discountedProductPage = 1;
    try {
      var responseBody = await NetworkApi().authGetData(
          "api/catalog/posts/discounted-products?page=$discountedProductPage&limit=$discountedLimit");
      if (responseBody == null) {
        print("API response is null");
        return false;
      }
      final response = jsonDecode(responseBody.body);
      //marketModel = marketModelFromJson(responseBody);
      discountMarketModel =
          DiscountedModel.discountedProductModelFromJson(responseBody.body);
      print(discountMarketModel);
      log("Discountproducts || $response");
      return true;
    } catch (e, s) {
      print(e);
      print(s);
      return false;
    }
  }

  Future fetchMoreDiscountedProducts() async {
    await discountedProductPage++;
    try {
      print("page test 1 $discountedProductPage");
      var responseBody = await NetworkApi().authGetData(
          "api/catalog/posts/discounted-products?page=$discountedProductPage&limit=$discountedLimit");
      var response = jsonDecode(responseBody.body);
      if (response != null &&
          discountMarketModel != null &&
          discountMarketModel!.data != null &&
          discountMarketModel!.data!.isNotEmpty) {
        final dataToAdd = (response["data"] as List<dynamic>?)?.map((item) {
              return DiscountedModel.Datum.fromJson(item);
            })?.toList() ??
            [];
        // if (dataToAdd.length < limit) {
        //   updateHasMore(false);
        // }
        if (dataToAdd.isNotEmpty) {
          discountMarketModel!.data!.addAll(dataToAdd);
          update();
          print("pagination got here $discountedProductPage");
          print("New data body: ${discountMarketModel!.data!.length}");
          print("New data body: ${discountMarketModel!.data![1]!.body}");
        }
      }

      print(response);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<bool> updatePrice(
    String? id,
    int? price,
  ) async {
    try {
      var data = {
        'id': id,
        'amount': price,
      };
      // FormData formData = FormData.fromMap({
      //   'id': userController.userModel.value.id,
      //   'price': price,
      // });
      var responseBody =
          await NetworkApi().patch(data, "${ApiRoute.updatePrice}");
      var response = jsonDecode(responseBody.body);
      log("price updated || $response");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String> convertCoordinatesToAddress(List<double> coordinates) async {
    if (coordinates[0] == null && coordinates[1] == null) {
      return "";
    }
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        coordinates[1], // Latitude
        coordinates[0], // Longitude
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String locality = placemark.locality ?? "Unknown Locality";
        return locality; // Get the full address
      } else {
        return "No address found for the given coordinates.";
      }
    } catch (e) {
      // return "Error converting coordinates to address: $e";
      return " ";
    }
  }

  Future<String?> productAddress(int index) async {
    if (marketModel! != null &&
        marketModel.value.data![index] != null &&
        marketModel.value.data![index].product! != null &&
        marketModel.value.data![index].product!.address![0] != null) {
      String? state;
      String? addressString =
          marketModel.value.data![index].product!.address![0].address;
      List<String> components = addressString!.split(", ");
      for (String component in components) {
        if (nigerianStates.contains(component)) {
          state = component;
          break;
        }
      }
      print("State now: $state");
      return state;
    } else {
      return "";
    }
  }

  Future<String?> userProductAddress(int index) async {
    if (userMarketModel! != null &&
        userMarketModel!.data![index] != null &&
        userMarketModel!.data![index].address! != null &&
        userMarketModel!.data![index].address![0].address != null) {
      String? state;
      String? addressString = userMarketModel!.data![index].address![0].address;
      List<String> components = addressString!.split(", ");
      for (String component in components) {
        if (nigerianStates.contains(component)) {
          state = component;
          break;
        }
      }
      print("State now: $state");
      return state;
    } else {
      return "";
    }
  }

  Future<String?> discountedProductAddress(int index) async {
    if (discountMarketModel! != null &&
      discountMarketModel!.data![index] != null &&
      discountMarketModel!.data![index].address! != null &&
      discountMarketModel!.data![index].address![0].address != null
    ){
      String? state;
      String? addressString = discountMarketModel!.data![index].address![0].address;
      List<String> components = addressString!.split(", ");
      for (String component in components) {
        if (nigerianStates.contains(component)) {
          state = component;
          break;
        }
      }
      print("State now: $state");
      return state;
    } else {
      return "";
    }
  }

  Future<String?> searchProduct(String product) async{
    try{
      var res = await NetworkApi().authGetData('api/catalog/posts?type=product&title=$product');
      var response = jsonDecode(res.body);
      log('SearchResponse: $response');
      
    }catch(e,s){
      log('error: $e');
      log('stack; $s');
    }
  }
}
