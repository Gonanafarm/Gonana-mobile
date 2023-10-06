import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/geolocator/geoservices.dart';
import 'package:gonana/features/controllers/taxonomy/taxonomy_controller.dart';
import 'package:gonana/features/data/models/taxonomy_model.dart';
import 'package:gonana/features/presentation/page/fiat_wallet/register_bank.dart';
import 'package:gonana/features/presentation/page/store/store_confirm_screen.dart';
import 'package:gonana/features/presentation/page/store/store_logistics.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../controllers/market/market_controllers.dart';

class AddProduct2 extends StatefulWidget {
  const AddProduct2({super.key});

  @override
  State<AddProduct2> createState() => _AddProduct2State();
}

class _AddProduct2State extends State<AddProduct2> {
  final taxonomyController = Get.put(TaxonomyController());
  final productController = Get.put(ProductController());
  @override
  LocationServiceController locationController =
      Get.put(LocationServiceController());
  final TextEditingController _hashTags = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _productCategory = TextEditingController();
  String get hashTags => _hashTags.text;
  String get price => _price.text;
  String get address => _address.text;
  String get quantity => _quantity.text;
  String get weight => _weight.text;
  String get productCategory => _productCategory.text;
  String selectedCategory = "";
  String? currentAddress;
  Position? currentPosition;
  double lat = 0.0;
  double long = 0.0;
  late var coordinates = [lat.toString(), long.toString()];
  Rx<TaxonomyModel?> selectedTaxonomy = TaxonomyModel().obs;

  @override
  void initState() {
    taxonomyController.getTaxonomy();
    locationController.determinePosition();
    getPosition();
    super.initState();
  }

  Future<void> getPosition() async {
    final hasPermission = await locationController.determinePosition();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => currentPosition = position);
      getAddress(currentPosition!);
      assignCordinates();
      // productController.updateCoordinates(
      //   lat,
      //   long
      // );
      productController.updateGeoLong(long);
      productController.updateGeoLat(lat);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void assignCordinates() async {
    setState(() {
      lat = currentPosition!.latitude;
      long = currentPosition!.longitude;
    });
    log("$lat");
    log("$long");
    log(coordinates.toString());
  }

  void getAddress(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        currentAddress = '${place.subAdministrativeArea}, ${place.country}';
        productController.updateAddress(currentAddress!);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Create Product',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // SizedBox(
                        //     // height: 122,
                        //     width: MediaQuery.of(context).size.width,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //       children: [
                        //         // EnterText(
                        //         //   onChanged: (hashtag) {
                        //         //     productController.updateHashTags(
                        //         //       hashtag as List<String>
                        //         //     );
                        //         //   },
                        //         //   controller: _hashTags,
                        //         //   label: 'HashTags',
                        //         //   hint: 'eg vegetables',
                        //         // ),
                        //         const Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Expanded(
                        //                 flex: 1,
                        //                 child: Text(
                        //                   'Recomended:',
                        //                   style: TextStyle(
                        //                       fontSize: 12,
                        //                       fontWeight: FontWeight.w400),
                        //                   textAlign: TextAlign.left,
                        //                 )),
                        //             Expanded(
                        //                 flex: 3,
                        //                 child: Padding(
                        //                   padding: EdgeInsets.only(top: 13.0),
                        //                   child: Text(
                        //                     'Vegetables Meat Meat Layers Eggs Corn Millet Nigeria Congo Jam Honey',
                        //                     textAlign: TextAlign.start,
                        //                     style: TextStyle(
                        //                         fontSize: 12,
                        //                         fontWeight: FontWeight.w400),
                        //                   ),
                        //                 )),
                        //           ],
                        //         )
                        //       ],
                        //     )),
                        const SizedBox(height: 10),
                        SizedBox(
                            // height: 82,
                            width: MediaQuery.of(context).size.width,
                            child: EnterText(
                              onChanged: (price) {
                                productController.updateAmount(price);
                              },
                              controller: _price,
                              keyboardType: TextInputType.number,
                              label: 'Price',
                              hint: 'Enter the amount',
                            )),
                        const SizedBox(height: 10),
                        SizedBox(
                            // height: 82,
                            width: MediaQuery.of(context).size.width,
                            child: EnterText(
                              onChanged: (quantity) {
                                productController.updateQuantity(quantity);
                              },
                              controller: _quantity,
                              keyboardType: TextInputType.number,
                              label: 'Quantity',
                              hint: 'Unit number of items',
                            )),
                        const SizedBox(height: 10),
                        SizedBox(
                            // height: 82,
                            width: MediaQuery.of(context).size.width,
                            child: EnterText(
                              onChanged: (weight) {
                                productController.updateWeight(weight);
                              },
                              controller: _weight,
                              keyboardType: TextInputType.number,
                              label: 'Weight',
                              hint: 'Weight in KG',
                            )),
                        const SizedBox(height: 10),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: EnterText(
                                onChanged: (weight) {
                                  productController.updateAddress(address);
                                },
                                controller: _address,
                                label: 'Product Address',
                                hint: 'Enter address for pick up')),
                        // Column(
                        //   children: [
                        //     const SizedBox(
                        //       width: double.infinity,
                        //       child: Padding(
                        //         padding: EdgeInsets.all(4.0),
                        //         child: Text(
                        //           'Product Location',
                        //           textAlign: TextAlign.left,
                        //         ),
                        //       )
                        //     ),
                        //     Container(
                        //       height: 58,
                        //       width: MediaQuery.of(context).size.width,
                        //       decoration: BoxDecoration(
                        //         border: Border.all(width: 1, color: Colors.grey),
                        //         borderRadius: const BorderRadius.all(Radius.circular(5)),
                        //       ),
                        //       child: Padding(
                        //         padding: const EdgeInsets.fromLTRB(8, 20, 0, 0),
                        //         child: Text('$currentAddress',
                        //           style: const TextStyle(),
                        //           textAlign: TextAlign.left
                        //         ),
                        //       )
                        //     )
                        //   ]
                        // ),
                        // const SizedBox(height: 10),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     const Text("  Product Category"),
                        //     const SizedBox(height: 5),
                        //     GetBuilder<TaxonomyController>(builder: (_) {
                        //       if (taxonomyController.taxonomies.isEmpty) {
                        //         taxonomyController.getTaxonomy();
                        //       } else {
                        //         if (selectedTaxonomy.value.isBlank!) {
                        //           selectedTaxonomy.update((val) {
                        //             selectedTaxonomy.value =
                        //                 taxonomyController.taxonomies[0];
                        //           });
                        //         }
                        //       }
                        //       return Obx(
                        //         () => Container(
                        //           width:
                        //               MediaQuery.of(context).size.width * 0.9,
                        //           decoration: BoxDecoration(
                        //               border: Border.all(color: Colors.grey),
                        //               borderRadius: BorderRadius.circular(5)),
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: DropdownButton<String>(
                        //                 isExpanded: true,
                        //                 underline: const SizedBox(),
                        //                 dropdownColor: Theme.of(context)
                        //                     .scaffoldBackgroundColor,
                        //                 focusColor: Colors.transparent,
                        //                 value: selectedTaxonomy.value != null &&
                        //                         selectedTaxonomy.value!.id !=
                        //                             null
                        //                     ? selectedTaxonomy.value!.id
                        //                         .toString()
                        //                     : null,
                        //                 hint: const Text(
                        //                     'Select your product category'),
                        //                 items: taxonomyController
                        //                         .taxonomies.isNotEmpty
                        //                     ? taxonomyController.taxonomies
                        //                         .map((e) {
                        //                         return DropdownMenuItem<String>(
                        //                           value: e.id.toString(),
                        //                           child:
                        //                               Text(e.name.toString()),
                        //                         );
                        //                       }).toList()
                        //                     : [],
                        //                 onChanged: (e) {
                        //                   if (e!.isNotEmpty) {
                        //                     selectedTaxonomy.value =
                        //                         taxonomyController.taxonomies
                        //                             .firstWhere((element) =>
                        //                                 element.id.toString() ==
                        //                                 e);
                        //                     taxonomyController.updateId(
                        //                         selectedTaxonomy.value!.id
                        //                             .toString());
                        //                   }
                        //                   log('${selectedTaxonomy.value!.id}');
                        //                 }),
                        //           ),
                        //         ),
                        //       );
                        //     })
                        //   ],
                        // ),
                      ]),
                ],
              ),
            ),
            LongGradientButton(
                title: 'Proceed',
                onPressed: () {
                  log('$currentPosition');
                  Get.to(
                    () => const ConfirmScreen(),
                  );
                })
          ],
        ),
      ),
    );
  }
}
