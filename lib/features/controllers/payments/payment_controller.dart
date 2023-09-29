import 'dart:convert';
import 'dart:developer';
import 'package:gonana/features/utilities/network.dart';
import 'package:get/get.dart';
import 'package:gonana/features/utilities/api_routes.dart';

class PaymentController extends GetxController{
  Future<bool> transferFunds(
    String requestReference,
    double amount,
    String accountNumber,
    String bankCode,
    String nameEnquirySessionId,
    String narration
  )async{
    try{
      var data = {
        'requestReference' : requestReference,
        'amount' : amount,
        'accountNumber' : accountNumber,
        'bankCode' : bankCode,
        'nameEnquirySessionId' : nameEnquirySessionId,
        'narration': narration
      };
      var res = await NetworkApi().postData(data, ApiRoute.transferFunds);
      final result = jsonDecode(res.body);
      if(res.statusCode == 201){
        
        log("result: $result");
        return true;
      }else{
        return false;
      }
    }catch(e,s){
      log("Transfer Error=> $e");
      log("Transfer Stack=> $s");
      return false;
    }
  }
}