import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/data/models/user_post_model.dart';
import 'package:gonana/features/presentation/page/settings/settiings_profile.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../controllers/market/market_controllers.dart';

class StoreEditProduct extends StatefulWidget {
  final Datum userPostModel;
  const StoreEditProduct({super.key, required this.userPostModel});

  @override
  State<StoreEditProduct> createState() => _StoreEditProductState();
}

class _StoreEditProductState extends State<StoreEditProduct> {
  final marketController = Get.put(ProductController());
  final TextEditingController _newPrice = TextEditingController();
  String get newPrice => _newPrice.text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back,
                    size: 20, color: Color(0xff292D32)))),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Change Price',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                sizeVer(8),
                                const Text(
                                  'Change the price of your product here',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ),
                        EnterText(
                            label: 'New Price',
                            hint: '₦0.00',
                            controller: _newPrice),
                        sizeVer(20),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Current Price',
                                  style: TextStyle(
                                    color: Color(0xffAEAEAE),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  width: 342,
                                  // height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: const Color(0xffAEAEAE))),
                                  child: SizedBox(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 23.0, horizontal: 18),
                                      child: Text(
                                        widget.userPostModel.amount != null
                                            ? '₦${widget.userPostModel.amount}'
                                            : "₦ 0.0",
                                        style: TextStyle(
                                          color: Color(0xffAEAEAE),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        sizeVer(17),
                        Container(
                          //height: 104,
                          //width: 272,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: redColor)),
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Note:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(text: '\n'), // Add a new line
                                  TextSpan(
                                    text:
                                        'You can only change the price of a product up to three times a month. Each time you reduce the price of your product, it is then added to the “Hot Deals” page and it attracts more buyers.',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  LongGradientButton(
                    title: 'Save Changes',
                    onPressed: () async {
                      bool created = false;
                      created = await marketController.updatePrice(
                          widget.userPostModel.id, int.tryParse(newPrice));
                      if (created) {
                        await marketController.fetchUserProduct();
                        await marketController.fetchProduct();
                        await marketController.fetchDiscountedProducts();
                        Get.to(() => SettingsProfile());
                      }
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
