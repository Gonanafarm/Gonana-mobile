import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gonana/features/controllers/cart/cart_controller.dart';
import 'package:gonana/features/presentation/page/market/hot_deals.dart';
import 'package:gonana/features/presentation/page/market/product_checkout.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';
import 'package:gonana/consts.dart';

import '../../../data/models/order_model.dart';
import 'cart_page.dart';

class AddressCourier extends StatefulWidget {
  const AddressCourier({super.key});

  @override
  State<AddressCourier> createState() => _AddressCourierState();
}

class _AddressCourierState extends State<AddressCourier> {
  CartController cartController = Get.put(CartController());
  final TextEditingController _address = TextEditingController();
  String get address => _address.text;
  bool isValidated = false;
  // bool isiTemSelected = false;
  bool isLoading = false;
  var selectedCourier;

  @override
  void initState() {
    super.initState();
    cartController.fetchActiveCourier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffF1F1F1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                orderList.clear();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                        //width: double.infinity,
                        child: isValidated
                            ? Image.asset('assets/images/check.png',
                                height: 30, width: 30, fit: BoxFit.fill)
                            : Image.asset('assets/images/checked.png',
                                height: 30, width: 30, fit: BoxFit.fill)),
                    sizeHor(10),
                    const Text('Delivery Address',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: EnterText(
                      label: 'Address',
                      hint: 'Enter delivery address',
                      controller: _address),
                ),
                ShortGradientButton(
                    title: 'Validate',
                    onPressed: () async {
                      var isSuccess =
                          await cartController.validateAddress(address);
                      if (isSuccess == true) {
                        log('isSUccess: $isSuccess');
                        SuccessSnackbar.show(
                            context, 'Address succesfully validated');
                        setState(() {
                          isValidated = true;
                        });
                      } else {
                        ErrorSnackbar.show(context, 'Address not validated');
                      }
                    }),
                const Divider(),
                const SizedBox(
                  width: double.infinity,
                  child: Text('Courier Service',
                    style:TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.left
                  ),
                ),
                sizeVer(10),
                Container(
                  //height: MediaQuery.of(context).size.height * 0.75,
                  child: SingleChildScrollView(
                    child: Container(
                      //height: MediaQuery.of(context).size.height * 0.85,
                      color: const Color(0xffF1F1F1),
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              sizeVer(10),
                              SizedBox(
                                // height: 60,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        // width: double.infinity,
                                        child: Text(
                                            'These are the logistics companies that we recommend',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.left),
                                      ),
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.5,
                                        child: listAvailableCouriers(selectedCourier)
                                      )
                                    ]
                                  ),
                              ),
                            ]
                          ),
                      ),
                    ),
                  ),
                ),
                sizeVer(45),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: LongGradientButton(
                    isLoading: isLoading,
                    title: 'Proceed to pay',
                    onPressed: () async {
                      // cartController.checkOut(order, serviceCode)
                      // Get.to(() => const AddressCourier());
                      // Passes the value here
                      if (isValidated && isiTemSelected) {
                        setState(() {
                          isLoading = true;
                        });
                        bool isSuccess = await cartController.getRates(
                            orderList, courierItem.serviceCode, context);
                        if (isSuccess) {
                          Get.to(() => const ProductCheckout(), arguments: {
                            "courier": courierItem.serviceCode
                          });
                        }
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        ErrorSnackbar.show(context,"Validate your address and select your Courier service");
                      }
                    }
                  )
                )
              ],
            ),
          ),
        )
      )
    );
  }

  var courierItem;
  Widget listAvailableCouriers(var selectedCourier) {
    return cartController.courierModel != null
        ? ListView.builder(
            itemCount: cartController.courierModel?.couriers?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final courierModel = cartController.courierModel;

              if (courierModel == null || courierModel.couriers == null) {
                // Handle null values as needed, e.g., return a placeholder widget.
                return SizedBox(child: Container());
              }

              if (index >= courierModel.couriers!.length) {
                // Handle the case where the index is out of bounds.
                return SizedBox(); // Or any other appropriate handling.
              }

              courierItem = courierModel.couriers![index];

              return InkWell(
                onTap: () {
                  setState(() {
                    selectedCourier = courierItem.serviceCode;
                    log('selected: ${selectedCourier}');
                    setState(() {
                      isiTemSelected = !isiTemSelected;
                    });
                    log('${courierItem.serviceCode} isSelected: $isSelected');
                  });
                },
                child: CourierWidget(
                  title: "${courierItem.name}",
                  imageUrl: "${courierItem.pinImage}",
                  index: index,
                ),
              );
            },
          )
        : SizedBox(child: Container());
  }
}

bool isiTemSelected = false;

class CourierWidget extends StatefulWidget {
  final String title;
  final String imageUrl;
  final int index;

  CourierWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.index,
  }) : super(key: key);

  @override
  State<CourierWidget> createState() => _CourierWidgetState();
}

class _CourierWidgetState extends State<CourierWidget> {
  bool isSelected = false; // Local isSelected state for each widget

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          log('selected: ${widget.title}');
          log('${widget.title} isSelected: $isSelected');
          isiTemSelected = true;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.white,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                child: Image.network(widget.imageUrl, height: 38, width: 38, fit: BoxFit.contain),
              ),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                child: SizedBox(
                  child: isSelected
                    ? Image.asset('assets/images/check.png', height: 30, width: 30, fit: BoxFit.fill)
                    : Image.asset('assets/images/checked.png', height: 30, width: 30, fit: BoxFit.fill),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
