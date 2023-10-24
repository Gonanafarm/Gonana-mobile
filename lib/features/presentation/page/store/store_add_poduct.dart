import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gonana/consts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/store/store_add_poduct2.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../controllers/market/market_controllers.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final picker = ImagePicker();
  final picker2 = ImagePicker();
  final picker3 = ImagePicker();
  File? _imageFile;
  String? _imageFilePath;
  File? _imageFile2;
  String? _imageFilePath2;
  File? _imageFile3;
  String? _imageFilePath3;
  bool selfShipping = false;

  final productController = Get.put(ProductController());
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageFilePath = pickedFile.path;
      });
      productController.updateImage(_imageFile);
    }
  }

  Future<void> pickImage2() async {
    final pickedFile2 = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile2 != null) {
      setState(() {
        _imageFile2 = File(pickedFile2.path);
        productController.updateImage2(_imageFile2);
      });
      productController.updateAttachments(_imageFile2, _imageFilePath2!);
    }
  }

  Future<void> pickImage3() async {
    final pickedFile3 = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile3 != null) {
      setState(() {
        _imageFile3 = File(pickedFile3.path);
        productController.updateImage3(_imageFile3);
      });
      productController.updateAttachments(_imageFile3, _imageFilePath3!);
    }
  }

  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();
  String get title => _title.text;
  String get body => _body.text;
  bool isLoading = false;

  final _product1Key = GlobalKey<FormState>();
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: ListView(children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 0),
                              child: SizedBox(
                                width: 342,
                                height: 180,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                          pickImage();
                                        },
                                        child: Container(
                                            // width: 342,
                                            height: 56,
                                            color: Colors.white,
                                            child: const Center(
                                                child: SizedBox(
                                              width: 130,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Add Image',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  )
                                                ],
                                              ),
                                            )))),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 0),
                                      child: SizedBox(
                                        width: 248,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Limit: 5MB',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              'Supported format: JPG, PNG',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // width: 342,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _imageFile == null
                                              ? GestureDetector(
                                                  onTap: () async {
                                                    pickImage();
                                                  },
                                                  child: Container(
                                                    width: 91.2,
                                                    height: 88,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color: const Color(
                                                            0xffD9D9D9)),
                                                    child: const Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text('Add Image',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        Icon(
                                                          Icons.add,
                                                          color: Colors.black,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () async {
                                                    pickImage();
                                                  },
                                                  child: Container(
                                                    width: 91.2,
                                                    height: 88,
                                                    child: ClipRRect(
                                                      child: Image.file(
                                                        fit: BoxFit.contain,
                                                        _imageFile!,
                                                        width: 91.2,
                                                        height: 88,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          _imageFile2 == null
                                              ? GestureDetector(
                                                  onTap: () async {
                                                    pickImage2();
                                                  },
                                                  child: Container(
                                                    width: 91.2,
                                                    height: 88,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color: const Color(
                                                            0xffD9D9D9)),
                                                    child: const Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text('Add Image',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        Icon(
                                                          Icons.add,
                                                          color: Colors.black,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () async {
                                                    pickImage2();
                                                  },
                                                  child: Image.file(
                                                    _imageFile2!,
                                                    width: 91.2,
                                                    height: 88,
                                                  ),
                                                ),
                                          _imageFile3 == null
                                              ? GestureDetector(
                                                  onTap: () async {
                                                    pickImage3();
                                                  },
                                                  child: Container(
                                                    width: 91.2,
                                                    height: 88,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color: const Color(
                                                            0xffD9D9D9)),
                                                    child: const Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text('Add Image',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        Icon(
                                                          Icons.add,
                                                          color: Colors.black,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () async {
                                                    pickImage3();
                                                  },
                                                  child: Image.file(
                                                    _imageFile3!,
                                                    width: 91.2,
                                                    height: 88,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Form(
                              key: _product1Key,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    // height: 82,
                                    width: MediaQuery.of(context).size.width,
                                    child: EnterFormText(
                                      onChanged: (title) {
                                        productController.updateTitle(title);
                                      },
                                      validator: inputValidator,
                                      controller: _title,
                                      label: 'Title',
                                      hint: 'Enter the title',
                                    ),
                                  ),
                                  SizedBox(
                                    // height: 164,
                                    width: MediaQuery.of(context).size.width,
                                    child: EnterLargeText(
                                      validator: inputValidator,
                                      controller: _body,
                                      onChanged: (body) {
                                        productController.updateBody(body);
                                      },
                                      label: 'Overview',
                                      hint: 'Tell us about the product',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Transform.scale(
                                        scale: 1.25,
                                        child: Checkbox(
                                            value: selfShipping,
                                            activeColor: greenColor,
                                            visualDensity:
                                                VisualDensity.comfortable,
                                            onChanged: (value) {
                                              setState(() {
                                                selfShipping = value!;
                                                log('selfShipping: $selfShipping , value: $value');
                                                productController
                                                    .updateShipping(
                                                        selfShipping);
                                              });
                                            }),
                                      ),
                                      const Text(
                                        'I would like to ship my product myself',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: greenColor),
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: LongGradientButton(
                        title: 'Proceed',
                        isLoading: false,
                        onPressed: () {
                          bool isValid = _product1Key.currentState!.validate();
                          if (isValid) {
                            Get.to(() => AddProduct2(), arguments: [
                              {"selfShipping": selfShipping}
                            ]);
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
