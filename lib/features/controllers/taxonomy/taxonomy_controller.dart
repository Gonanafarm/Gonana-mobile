import 'dart:convert';

import 'package:get/get.dart';
import 'package:gonana/features/data/models/taxonomy_model.dart';
import 'package:gonana/features/utilities/api_routes.dart';
import 'dart:developer';

import '../../utilities/network.dart';

class TaxonomyController extends GetxController {
  RxList<String> dropdownOptions = <String>[].obs;
  var taxonomies = <TaxonomyModel>[].obs;
  RxString id = ''.obs;
  RxString name = ''.obs;

  void updateId(String newId) {
    id.value = newId;
    update();
  }

  TaxonomyModel taxonomyModel = TaxonomyModel();
  void getTaxonomy() async {
    try {
      var res = await NetworkApi().authGetData(ApiRoute.getTaxonomy);
      final result = jsonDecode(res.body.toString());
      //taxonomyModel = taxonomyModelFromJson(res) as TaxonomyModel;
      if (res.statusCode == 200) {
        print(res);
        var data = List<Map<String, dynamic>>.from(result);
        List<TaxonomyModel> list =
            data.map((e) => TaxonomyModel().fromJson(e)).toList();
        taxonomies.value = list;
        name = taxonomies[0].name as RxString;
      } else {
        log("Failed ${res.body}");
        log("Failed ${res.statusCode}");
      }
    } catch (e, s) {
      log("TaxonomyError=> $e");
      log("TaxonomyError Stack=> $s");
    }
  }

  void postTaxonomy(String taxonomyContext, String name, String description,
      String parentId, String image) async {
    var data = {
      'taxonomy_context': taxonomyContext,
      'name': name,
      'description': description,
      'parent_id': parentId,
      'image': image
    };
    try {
      var res = await NetworkApi().authPostData(data, ApiRoute.postTaxonomy);
      final result = jsonDecode(res.body);
      if (res.statusCode == 200) {
        log(result);
      } else {
        log("Failed ${res.statusCode}");
      }
    } catch (e) {
      log("TaxonomyError=> $e");
    }
  }

  String item = '';
  // void deleteTaxonomy() async {
  //   try {
  //     var res =
  //         await NetworkApi().deleteData('${ApiRoute.deleteTaxonomy}/$item}');
  //     final result = jsonDecode(res.body);
  //     if (res.statusCode == 200) {
  //       log(result);
  //     } else {
  //       log("Failed ${res.statusCode}");
  //     }
  //   } catch (e) {
  //     log("TaxonomyError=> $e");
  //   }
  // }

  void getTaxonomyItem() async {
    try {
      var res =
          await NetworkApi().authGetData('${ApiRoute.getTaxonomyItem}/$item');
      final result = jsonDecode(res.body);
      if (res.statusCode == 200) {
        log(result);
      } else {
        log("Failed ${res.statusCode}");
      }
    } catch (e) {
      log("TaxonomyError=> $e");
    }
  }

  void putTaxonomyItem(String? name, String? description) async {
    var data = {'name': name, 'description': description};
    try {
      var res =
          await NetworkApi().putData(data, '${ApiRoute.putTaxonomyItem}/$item');
      final result = jsonDecode(res.body);
      if (res.statusCode == 200) {
        log(result);
      } else {
        log("Failed ${res.statusCode}");
      }
    } catch (e) {
      log("TaxonomyError=> $e");
    }
  }
}
