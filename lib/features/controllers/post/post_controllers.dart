import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart' as getx;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:gonana/features/data/models/post_model_id.dart';
import 'package:gonana/features/data/models/post_model.dart';
import 'package:gonana/features/data/models/user_liked_feeds.dart';
import '../../../consts.dart';
import '../../data/models/feeds_model.dart' as FeedsModel;
import '../../data/models/get_post_model.dart';
import '../../utilities/api_routes.dart';
import 'package:dio/dio.dart';

import '../../utilities/network.dart';

class PostController extends GetxController {
  //List<PostModel> postModel = [];
  late FeedsModel.FeedsModel postModel;
  GetPostModel getPostModel = GetPostModel();
  RxString title = "".obs;
  RxString body = "".obs;
  var image = File("").obs;
  RxString comment = "".obs;
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

  void updateComment(String newComment){
    comment.value = newComment;
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

  var userLikedFeeds = UserLikedFeeds().obs;
  Future<bool> getUserLikedFeeds(String postId) async {
    try {
      var res = await NetworkApi().authGetData("api/catalog/posts/likes/$postId");
      final response = jsonDecode(res.body);
      if (res.statusCode == 200) {
        userLikedFeeds.value = userLikedFeedsFromJson(res.body);
        log("Users that have liked posts|| $response");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("UsersLiked: $e");
      return false;
    }
  }

  int postPage = 1;
  int postLimit = 15;
  Future<bool> getPosts() async {
    postPage = 1;
    try {
      var res = await NetworkApi().authGetData(
          "api/catalog/posts?type=post&page=$postPage&limit=$postLimit");
      final response = jsonDecode(res.body);
      postModel = FeedsModel.feedsModelFromJson(res.body);
      print("posts got here || $response");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future getMorePosts() async {
    await postPage++;
    try {
      print("page test 1 $postPage");
      var responseBody = await NetworkApi().authGetData(
          "api/catalog/posts?type=post&page=$postPage&limit=$postLimit");
      var response = jsonDecode(responseBody.body);
      if (response != null &&
          postModel != null &&
          postModel!.data != null &&
          postModel!.data!.isNotEmpty) {
        final dataToAdd = (response["data"] as List<dynamic>?)?.map((item) {
              return FeedsModel.Datum.fromJson(item);
            })?.toList() ??
            [];
        // if (dataToAdd.length < limit) {
        //   updateHasMore(false);
        // }
        if (dataToAdd.isNotEmpty) {
          postModel!.data!.addAll(dataToAdd);
          update();
          print("pagination got here $postPage");
          print("New data body: ${postModel!.data!.length}");
          print("New data body: ${postModel!.data![0]!.product!.body}");
        }
        print(response);
      }
    } catch (e, s) {
      print(e);
      print(s);
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
    if(idPostModel! != null &&
      idPostModel!.data![index] != null &&
      idPostModel!.data![index].product! != null &&
      idPostModel!.data![index].product!.address![0] != null) {
      String? state;
      String? addressString = idPostModel!.data![index].product!.address![0].address;
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

  likePost(String? postId) async {
    log("called likepost");
    var data = {"postId": postId};
    try {
      var res = await NetworkApi().authPostData(data, ApiRoute.likePost);
      var response = jsonDecode(res.body);
      log('LikeResponse: $response && ${res.statusCode}');
      if (res.statusCode == 201) {
        return [true, true];
      } else if (res.statusCode == 400) {
        return [false, true];
      } else {
        return [false, false];
      }
    } catch (e, s) {
      log('likeError: $e');
      log('likeErrorStack: $s');
      return [false, false];
    }
  }

  Future<bool> unlikePost(String? postId) async {
    log("called unlikepost");
    var data = {"postId": postId};
    try {
      var res = await NetworkApi().authPostData(data, ApiRoute.unlikePost);
      var response = jsonDecode(res.body);
      log('UnlikeResponse: $response && ${res.statusCode}');
      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      log('unlikeError: $e');
      log('unlikeErrorStack: $s');
      return false;
    }
  }

  Future<bool> makeComment(
    String postId,
    String comment,
  ) async{
    var data = {
      "postId": postId,
      "comment": comment
    };
    try{
      var res = await NetworkApi().authPostData(data, ApiRoute.comment);
      var response = jsonDecode(res.body);
      log("CommentResponse: $response && statcode: ${res.statusCode}");
      if(res.statusCode == 201){

        return true;
      }else{
        return false;
      }
      return false;
    }catch(e,s){
      log('CommentError: $e');
      log('CommentErrorStack: $s');
      return false;
    }
  }
}
