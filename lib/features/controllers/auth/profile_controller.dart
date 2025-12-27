import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Future<bool> updateProfile(
  //   String? firstName,
  //   String? lastName,
  //   String? bio,
  //   String? phone,
  //   File? profilePhoto,
  //   File? coverPhoto
  // )async{
  //   var data ={
  //     "first_name": firstName,
  //     "last_name": lastName,
  //     "bio": bio,
  //     "phone": phone,
  //     "profilePhoto": profilePhoto,
  //     "coverPhoto": coverPhoto
  //   };
  //   try{
  //     var res = await NetworkApi().putData(data, ApiRoute.updateProfile);
  //     final result = jsonDecode(res.body);
  //     log(result);
  //     if(res.statusCode == 200){
  //       log("Success ${res.statusCode}");
  //     }else{
  //       log("Failed ${res.statusCode}");
  //     }
  //     return true;
  //   }catch(e){
  //     log("UpdateProfile Error=> $e");
  //     return false;
  //   }
  // }
}
