import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart' as getx;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:gonana/features/data/models/post_model_id.dart';
import 'package:gonana/features/data/models/post_model.dart';
import '../../../consts.dart';
import '../../data/models/feeds_model.dart';
import '../../data/models/get_post_model.dart';
import '../../utilities/api_routes.dart';
import 'package:dio/dio.dart';

import '../../utilities/network.dart';

class PostController extends GetxController {
  //List<PostModel> postModel = [];
  late FeedsModel postModel;
  GetPostModel getPostModel = GetPostModel();
  RxString title = "".obs;
  RxString body = "".obs;
  var image = File("").obs;
  var posts = <PostModel>[].obs;
  String postItem = "";

  void updateTitle(String newTitle) {
    title.value = newTitle;
    update();
  }

  void updateBody(String newBody) {
    body.value = newBody;
    update();
  }

  void updateImage(var newImage) {
    image.value = newImage;
    update();
  }

  Future<bool> createPost(String? body, File? image) async {
    MultipartFile productImage;

    String id = DateTime.now().millisecondsSinceEpoch.toString();
    // Map<String, dynamic> noMediaReq = {}..addAll(val);
    List files = [];
    productImage = await MultipartFile.fromFile(
      image!.path,
      filename: '$id/${image}',
    );
    files.insert(0, productImage);
    FormData formData = FormData.fromMap({
      'title': "Market",
      'body': body,
      'type': 'post',
      'status': "published",
      'files': files,
      'delivery_company': "DHL",
      'address': "4 penguin close zoo estate,ogui junction, Enugu",
    });
    log("FD =>${formData.fields}");
    try {
      var res = await NetworkApi()
          .dioPost(formData: formData, routeUrl: ApiRoute.createPost);
      final result = jsonDecode(res.data);
      log('MarketResult => $result');
      // log(res);

      return true;
    } on DioException catch (e, s) {
      log('e=>$e');
      log('s=.>$s');
      return false;
    }
  }

  // Future<bool> getProducts() async {
  //   try {
  //     var res = await NetworkApi().authGetData(ApiRoute.getProducts);
  //     final response = jsonDecode(res.body);
  //     // log("${res.statusCode}");
  //     // log("${response}");
  //     // if(res.statusCode == 200){
  //     //   log(response.toString());
  //     //   var data = List<Map<String, dynamic>>.from(response);
  //     //   List list = data.map((e)=> PostModel().fromJson(e)).toList();
  //     //   posts.value.addAll(list as Iterable<PostModel>);
  //     // }
  //     // print("posts || $response");
  //     postModel = postModelFromJson(res.body);
  //     print(postModel[0].images!.elementAt(0));
  //     // print("posts || $responseBody");
  //     print("products got here || $response");
  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  Future<bool> getPosts() async {
    try {
      var res = await NetworkApi().authGetData(ApiRoute.getPosts);
      final response = jsonDecode(res.body);
      // log("${res.statusCode}");
      // log("${response}");
      // if(res.statusCode == 200){
      //   log(response.toString());
      //   var data = List<Map<String, dynamic>>.from(response);
      //   List list = data.map((e)=> PostModel().fromJson(e)).toList();
      //   posts.value.addAll(list as Iterable<PostModel>);
      // }
      // print("posts || $response");
      postModel = feedsModelFromJson(res.body);
      // print(postModel[0].images!.elementAt(0));
      // print("posts || $responseBody");
      print("posts got here || $response");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  PostmodelById? idPostModel;
  Future<bool> getPostsById(var userId, var type) async {
    try {
      var res = await NetworkApi().authGetData(
          "api/catalog/posts/any-user-products?id=$userId&type=$type");
      final response = jsonDecode(res.body);
      idPostModel = postmodelByIdFromJson(res.body);
      print("posts id got here || $response");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String?> postUserIdAddress(int index) async {
    if (idPostModel! != null &&
        idPostModel!.data![index] != null &&
        idPostModel!.data![index].product! != null &&
        idPostModel!.data![index].product!.address![0] != null) {
      String? state;
      String? addressString =
          idPostModel!.data![index].product!.address![0].address;
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

  Future<bool> fetchPostItem() async {
    try {
      var responseBody =
          await NetworkApi().authGetData("${ApiRoute.getPostItem}/$postItem");
      final response = jsonDecode(responseBody.body);
      getPostModel = getPostModelFromJson(responseBody);
      print("post || $responseBody");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updatePost() async {
    String? title;
    String? body;
    String? status;
    try {
      var data = {
        'title': title,
        'body': body,
        'status': status,
      };
      var responseBody =
          await NetworkApi().putData(data, "${ApiRoute.updatePost}/$postItem");
      var response = jsonDecode(responseBody);
      log("post updated || $responseBody");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Future<bool> deletePost() async {
  //   try {
  //     var responseBody =
  //         await NetworkApi().deleteData("${ApiRoute.deletePost}/$postItem");
  //     var response = jsonDecode(responseBody);
  //     log("post deleted || $responseBody");
  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }
}
