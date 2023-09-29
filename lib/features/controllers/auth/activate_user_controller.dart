import 'dart:convert';
import 'dart:developer';
import 'package:gonana/features/utilities/network.dart';
import 'package:get/get.dart';
import 'package:gonana/features/utilities/api_routes.dart';

class ActivateUser extends GetxController{
  String activationToken = '';
  String userId = '';
  Future<bool> activateUser(    
    
  )async{
    try{
      var res = await NetworkApi().getData('${ApiRoute.activate}/$userId/$activationToken');
      final result = jsonDecode(res.body);
      if(res.statusCode ==200 ){
        log("Success");
        log(result);
        return true;
      }else{
        log("Failed ${res.statusCode}");
      }
      return true;
    }catch(e){
      log("ActivationError=> $e");
      return false;
    }
  }

  Future<bool> resendActivationCredentials(

  )async{
    try{
      var res = await NetworkApi().postData({}, ApiRoute.resendActivationCredentials);
      final result = jsonDecode(res.code);
      if(res.statusCode == 201){
        log("Success");
        log(result);
      }else{
        log("failed ${res.statusCode}");
      }
      return true;
    }catch(e){
      log("Resend Error=> $e");
      return false;
    }
  }
}