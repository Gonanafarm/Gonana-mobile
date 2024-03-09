import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart' as getx;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:gonana/features/controllers/cart/cart_controller.dart';
import 'package:gonana/features/data/models/cart_model.dart';
import 'package:gonana/features/data/models/get_order_model.dart';
import 'package:gonana/features/data/models/get_outgoing_orders.dart';
import 'package:gonana/features/data/models/order_model.dart';

import '../../presentation/widgets/widgets.dart';
import '../../utilities/api_routes.dart';
import '../../utilities/network.dart';

class OrderController extends GetxController {
  String item = "";
  final cartController = Get.find<CartController>();
  Rx<GetOrdersModel> getOrderModel = Rx<GetOrdersModel>(GetOrdersModel());
  Rx<GetOutgoingOrdersModel> getOutGoingOrderModel =
      Rx<GetOutgoingOrdersModel>(GetOutgoingOrdersModel());

  Future<bool> getOrders() async {
    try {
      var responseBody =
          await NetworkApi().authGetData(ApiRoute.getIncomingOrders);
      final response = jsonDecode(responseBody.body);
      getOrderModel.value = getOrdersModelFromJson(responseBody.body);
      log("all orders || $response");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getOutGoingOrders() async {
    try {
      var responseBody =
          await NetworkApi().authGetData(ApiRoute.getOutgoingOrders);
      final response = jsonDecode(responseBody.body);
      getOutGoingOrderModel.value =
          getOutgoingOrdersModelFromJson(responseBody.body);
      log("all orders || $response");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> confirmOrderSent(String? productId, context) async {
    try {
      var data = {
        'orderId': productId,
      };
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.confirmSentOrder);
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("order || $response");
      if (responseBody.statusCode == 201) {
        SuccessSnackbar.show(context, "Order confirmation received");
        return true;
      } else {
        ErrorSnackbar.show(context, response["message"]);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> confirmOrderReceived(String? productId, context) async {
    try {
      var data = {
        'orderId': productId,
      };
      print("data: $data");
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.confirmReceivedOrder);
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("order || $response");
      if (responseBody.statusCode == 201) {
        SuccessSnackbar.show(context, "Order confirmation received");
        return true;
      } else {
        ErrorSnackbar.show(context, response["message"]);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> complain(String? productId, context) async {
    try {
      var data = {
        'orderId': productId,
      };
      var responseBody =
          await NetworkApi().authPostData(data, ApiRoute.confirmReceivedOrder);
      var response = jsonDecode(responseBody.body);
      // log("added cart items || $responseBody");
      log("order || $response");
      if (responseBody.statusCode == 201) {
        SuccessSnackbar.show(context, "Order complain received");
        return true;
      } else {
        ErrorSnackbar.show(context, response["message"]);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
//
//   Future<bool> order() async {
//     try {
//       var responseBody =
//           await NetworkApi().authGetData("${ApiRoute.getOrders}/$item");
//       final response = jsonDecode(responseBody.body);
//       orderModel = orderModelFromJson(responseBody);
//       log("item ordered || $responseBody");
//       return true;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }
}
