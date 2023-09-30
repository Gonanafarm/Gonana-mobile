import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class NetworkApi {
  final baseurl = 'https://starfish-app-4q3vo.ondigitalocean.app';

  postData(formData, routeUrl) async {
    var url = Uri.parse('$baseurl/$routeUrl');
    var response = await https.post(url,
        headers: {
          'Content-type': 'application/json',
        },
        body: jsonEncode(formData));
    return response;
  }

  authPostData(data, routeUrl, {FormData? multimediaRequest}) async {
    var client = https.Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    //If does not include files, use http request.
    if (multimediaRequest == null) {
      var url = Uri.parse('$baseurl/$routeUrl');
      var response = await client.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
          },
          body: jsonEncode(data));
      return response;
    }
    //If includes files, use dio request.
    else {
      Dio dio = Dio();
      Response responseBody = await dio.post(
        '$baseurl/$routeUrl',
        data: multimediaRequest,
        options: Options(
          method: 'POST',
          contentType: "application/json",
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
          },
          responseType: ResponseType.plain,
        ),
      );
      print(responseBody.data);
      print(responseBody.statusCode);
      return responseBody.data;
    }
  }

  putData(data, routeUrl, {FormData? multimediaRequest}) async {
    var client = https.Client();
    Dio dio = Dio();
    var responseJson;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    //If does not include files, use http request.
    if (multimediaRequest == null) {
      try {
        var url = Uri.parse('$baseurl/$routeUrl');
        var response = await client.put(url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-type': 'application/json',
            },
            body: jsonEncode(data));
        // print(response);
        responseJson = response;
      } catch (e) {
        print("Error: $e");
      }
      // print(responseJson);
      return responseJson;
    } else {
      Dio dio = Dio();
      try {
        Response response = await dio.put(
          '$baseurl/$routeUrl',
          data: multimediaRequest,
          options: Options(
            method: 'PUT',
            contentType: "application/json",
            headers: {
              'Authorization': 'Bearer $token',
              'Content-type': 'application/json',
            },
            responseType: ResponseType.plain,
          ),
        );
        // print(response);
        responseJson = response;
      } catch (e) {
        print("Error: $e");
      }
      // print(responseJson);
      return responseJson;
      // log(response.data.toString());
      // log(response.statusCode.toString());
      // return response.data;
    }
  }

  dioPost({FormData? formData, String? routeUrl}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final options = BaseOptions(
      receiveDataWhenStatusError: true,
      followRedirects: false,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    Dio dio = Dio(options);
    Response responseBody = await dio.post(
      '$baseurl/$routeUrl',
      data: formData,
      options: Options(
        method: 'POST',
        contentType: "application/json",
        headers: {
          'Authorization': 'Bearer $token',
          // 'Content-type': 'application/json',
        },
        responseType: ResponseType.plain,
      ),
    );
    log(responseBody.data.toString());
    log(responseBody.statusCode.toString());
    return responseBody;
  }

  getData(routeUrl) async {
    var url = Uri.parse('$baseurl/$routeUrl');
    var response = await https.get(url, headers: {
      'Content-type': 'application/json',
    });
    return response;
  }

  authGetData(routeUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var url = Uri.parse('$baseurl/$routeUrl');
    var response = await https.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json',
    });
    return response;
  }

  deleteData(data, routeUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var client = https.Client();
    var url = Uri.parse('$baseurl/$routeUrl');
    var response = await client.delete(url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
        },
        body: jsonEncode(data));
    return response;
  }

  patchData({FormData? formData, String? routeUrl}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Dio dio = Dio();
    var client = https.Client();
    Response response = await dio.patch(
      '$baseurl/$routeUrl',
      data: formData,
      options: Options(
        method: 'PATCH',
        contentType: 'application/json',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
        },
        responseType: ResponseType.plain,
      ),
    );
    return response;
  }

  patch(data, routeUrl, {FormData? multimediaRequest}) async {
    var client = https.Client();
    Dio dio = Dio();
    var responseJson;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    //If does not include files, use http request.
    if (multimediaRequest == null) {
      try {
        var url = Uri.parse('$baseurl/$routeUrl');
        var response = await client.patch(url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-type': 'application/json',
            },
            body: jsonEncode(data));
        // print(response);
        responseJson = response;
      } catch (e) {
        print("Error: $e");
      }
      // print(responseJson);
      return responseJson;
    } else {
      Dio dio = Dio();
      try {
        Response response = await dio.patch(
          '$baseurl/$routeUrl',
          data: multimediaRequest,
          options: Options(
            method: 'PUT',
            contentType: "application/json",
            headers: {
              'Authorization': 'Bearer $token',
              'Content-type': 'application/json',
            },
            responseType: ResponseType.plain,
          ),
        );
        // print(response);
        responseJson = response;
      } catch (e) {
        print("Error: $e");
      }
      // print(responseJson);
      return responseJson;
      // log(response.data.toString());
      // log(response.statusCode.toString());
      // return response.data;
    }
  }
}
