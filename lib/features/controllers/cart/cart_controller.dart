// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart' as getx;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:gonana/features/data/models/order_model.dart';
import 'package:gonana/features/data/models/courier_model.dart';

import '../../data/models/cart_model.dart';
import '../../presentation/widgets/widgets.dart';
import '../../utilities/api_routes.dart';
import '../../utilities/network.dart';
import 'package:dio/dio.dart';

class CartController extends GetxController {
  Rx<CartModel> cartModel = Rx<CartModel>(CartModel());
  // CartModel? cartModel;
  final RxList<Product> cartProduct = <Product>[].obs;
  final RxList<OrdersModel> orderModel = <OrdersModel>[].obs;

  RxInt quantity = 0.obs;
  RxInt cartItems = 0.obs;
  RxInt totalPrice = 0.obs;
  String item = "";
  var couriers = <CourierModel>[].obs;
  
  void updateQuantityPerItem(int newQuantity) {
    quantity.value = newQuantity;
    update();
  }

  void updateUnitPerItem(int newQuantity, int index) {
    cartModel.value.products![index].unit = newQuantity;
    update();
  }

  void updateCartItems() {
    cartItems.value = cartModel!.value.products!.length;
    update();
  }

  int calculateTotalPrice() {
    for (Product item in cartProduct!) {
      totalPrice += (item.amount! * quantity.value);
    }
    return totalPrice.toInt();
  }

  Future<bool> fetchCart() async {
    try {
      var responseBody = await NetworkApi().authGetData(ApiRoute.fetchCart);
      final response = jsonDecode(responseBody.body);
      print("cart got here");
      cartModel.value = cartModelFromJson(responseBody.body);
      log("all cart items || $response");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  // Future<bool> fetchCartItem() async {
  //   try {
  //     var responseBody =
  //         await NetworkApi().authGetData("${ApiRoute.fetchCartItem}/$item");
  //     final response = jsonDecode(responseBody.body);
  //     cartModel = cartModelFromJson(responseBody);
  //     log("cart item || $responseBody");
  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  Future<bool> addToCart(String? productId, context) async {
    try {
      var data = {
        'product_id': productId,
      };
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.addToCart);
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("added cart items response || $response");
      SuccessSnackbar.show(context, "${response['message']}");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> removeItem(String? productId) async {
    try {
      var data = {
        'product_id': productId,
      };
      var responseBody =
          await NetworkApi().deleteData(data, ApiRoute.addToCart);
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("remove cart items response || $response");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateQuantity() async {
    int? quantity;
    try {
      var data = {'quantity': quantity};
      var responseBody = await NetworkApi()
          .putData(data, "${ApiRoute.updateCart}$item/update-price");
      var response = jsonDecode(responseBody);
      log("quantity updated || $responseBody");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> placeOrder() async {
    String? image;
    String? product_name;
    String? product_id;
    int? quantity;
    double? amount;
    double? sum_total;
    String? payment_method;
    String? payment_url;
    String? payment_status;
    String? status;
    String? created_at;
    String? updated_at;
    try {
      var data = {
        'productName': product_name,
        'productId': product_id,
        'quantity': quantity,
        'amount': amount,
        'sumTotal': sum_total,
        'paymentMethod': payment_method,
        'paymentUrl': payment_url,
        'paymentStatus': payment_status,
        'status': status,
        'createAt': created_at,
        'updatedAt': updated_at,
      };
      FormData formData;
      MultipartFile productImage;
      if (image!.isNotEmpty) {
        productImage = await MultipartFile.fromFile(
          image!,
          filename: '${image}',
        );

        formData = FormData.fromMap(data..addAll({"image": productImage}));
        var responseBody = await NetworkApi().authPostData(
            data, ApiRoute.placeOrder,
            multimediaRequest: formData);
        var response = jsonDecode(responseBody);
        log("order placed || $responseBody");
        return true;
      } else {
        var data = {
          'image': image,
          'productName': product_name,
          'productId': product_id,
          'quantity': quantity,
          'amount': amount,
          'sumTotal': sum_total,
          'paymentMethod': payment_method,
          'paymentUrl': payment_url,
          'paymentStatus': payment_status,
          'status': status,
          'createAt': created_at,
          'updatedAt': updated_at,
        };
        var responseBody =
            await NetworkApi().authPostData(data, ApiRoute.placeOrder);
        var response = jsonDecode(responseBody);
        log("order placed || $responseBody");
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> checkOut(List<Order> order) async {
    try {
      var data = {"orders": order};
      for (var item in order) {
        print('Order ID: ${item.id}');
        print('Units: ${item.units}');
      }
      var res = await NetworkApi().authPostData(data, ApiRoute.placeOrder);
      var response = jsonDecode(res.body);
      print("got here");
      log('Message: $response');
      if (res.statusCode == 201) {
        return true;
      }
    } catch (e, s) {
      log("checkOut Error=> $e");
      log("checkOut Stack=> $s");
    }
    return false;
  }

  Future<bool> validateAddress(String address) async {
    try {
      var data = {'address': address};
      var res = await NetworkApi().authPostData(data, ApiRoute.validateAddress);
      final result = jsonDecode(res.body);
      if (res.statusCode == 201) {
        log('statcode: ${res.statusCode}');
        log('rezz: $result');
        return true;
      } else {
        log('rezzzz: $result');
        return false;
      }
    } catch (e, s) {
      log("vaalidate Error=> $e");
      log("vaalidate Stack=> $s");
      return false;
    }
  }

  CourierModel? courierModel;
  Future<bool> fetchActiveCourier() async {
    try {
      var res = await NetworkApi().authGetData(ApiRoute.fetchCourier);
      final result = jsonDecode(res.body);
      //courierModel = courierModelFromJson(res.body);
      if (res.statusCode == 200) {
        log("Couriers: $result");
        courierModel = courierModelFromJson(res.body);
        return true;
      }else{
        log("Fail Couriers: $result");
        return false;
      }
    } catch (e, s) {
      log("fetchActiveCourier Error=> $e");
      log("fetchActiveCourier Stack=> $s");
      return false;
    }
  }
}

