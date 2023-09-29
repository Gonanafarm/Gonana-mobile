import 'package:get/get.dart';

import '../cart/cart_controller.dart';
import '../market/market_controllers.dart';
import '../post/post_controllers.dart';
import '../user/user_controller.dart';

class GetDetailsController extends GetxController {
  PostController postsController = Get.put(PostController());
  ProductController productController = Get.put(ProductController());
  UserController userController = Get.put(UserController());
  CartController cartController = Get.put(CartController());
  Future<bool> getPosts() async {
    var data = await postsController.getPosts();
    print("initState() called posts");
    if (data != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getProducts() async {
    var data = await productController.fetchProduct();
    var data2 = await productController.fetchUserProduct();
    var data3 = await cartController.fetchCart();
    print("initState() called products");
    if (data != null && data2 != null && data3 != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getDiscountedProducts() async {
    var data = await productController.fetchDiscountedProducts();
    print("initState() called discount");
    if (data != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getUserDetails() async {
    var data1 = await userController.fetchUserByEmail();
    var data2 = await getDiscountedProducts();
    var data3 = await getProducts();
    var data4 = await getPosts();
    print("User details gotten");
    if (data1 != false && data2 != false && data3 != false && data4 != null) {
      return true;
    } else {
      return false;
    }
  }
}
