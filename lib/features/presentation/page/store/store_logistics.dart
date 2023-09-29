import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/presentation/page/store/store_confirm_screen.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import '../../../controllers/market/market_controllers.dart';
import '../../widgets/custom_dropdown.dart';

final productController = Get.put(ProductController());

class StoreLogistics extends StatefulWidget {
  const StoreLogistics({super.key});

  @override
  State<StoreLogistics> createState() => _StoreLogisticsState();
}

class _StoreLogisticsState extends State<StoreLogistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Logistics',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 10),
                    child: Text(
                      "Logistics Merchants",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      logisticComapnies(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff1E1E1E)),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() {
                              return Text(productController.logisticsMerchant.value);
                            }),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
              LongGradientButton(
                title: 'Proceed',
                onPressed: () {
                  Get.to(
                    () => const ConfirmScreen(),
                    //     arguments: [
                    //   {'data': argument}
                    // ],
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}

logisticComapnies(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
            color: const Color(0xffF1F1F1),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  // height: 60,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text('Logistics companies',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.left),
                          ),
                        ),
                        const SizedBox(
                          // width: double.infinity,
                          child: Text(
                              'These are logistics companies that we recommend',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          // width: 342,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const TextField(
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(),
                                hintText: 'Search token name',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              productController.updateLogisticsMerchants("Red Star Logistics");
                            },
                            child: Container(
                              height: 56,
                              // width: 342,
                              color: Colors.white,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      'assets/images/redstarLogo.png',
                                      height: 38,
                                      width: 38,
                                      fit: BoxFit.contain),
                                    const Text(
                                      'Red Star Logistics',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.arrow_forward_ios)
                                    ),
                                  ]
                                )
                              ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              productController.updateLogisticsMerchants("DHL Logistics");
                            },
                            child: Container(
                              height: 56,
                              // width: 342,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset('assets/images/dhllogo.png',
                                    height: 38,
                                    width: 38,
                                    fit: BoxFit.contain
                                  ),
                                  const Text(
                                    'DHL Logistics',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_forward_ios
                                    )
                                  ),
                                ]
                              )
                            ),
                          ),
                        ),
                      ]),
                ),

                // LongGradientButton(title: 'Proceed', onPressed: () {})
              ]),
            ),
          ),
        );
      });
}

final TextEditingController _logisticsMerchant = TextEditingController();
final TextEditingController _phoneNumber = TextEditingController();
final TextEditingController _email = TextEditingController();
String get email => _email.text;
String get phoneNumber => _phoneNumber.text;
String get logisticsMerchnat => _logisticsMerchant.text;

// createLogistics(BuildContext context) {
//   showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//
//         return Container(
//             height: MediaQuery.of(context).size.height * 0.85,
//             color: const Color(0xffF1F1F1),
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.close, color: Colors.black),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         const SizedBox(
//                           // height: 60,
//                           child: Column(children: [
//                             SizedBox(
//                               width: double.infinity,
//                               child: Padding(
//                                 padding: EdgeInsets.only(bottom: 8),
//                                 child: Text('Logistics companies',
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                     textAlign: TextAlign.left),
//                               ),
//                             ),
//                             SizedBox(
//                               width: double.infinity,
//                               child: Text(
//                                   'Enter the details to your logistics company',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   textAlign: TextAlign.left),
//                             ),
//                           ]),
//                         ),
//                         SizedBox(
//                           // height: 294,
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const  EdgeInsets.symmetric(vertical: 8),
//                                 child: EnterText(
//                                   controller: _logisticsMerchant,
//                                   label: 'Logistics Merchant',
//                                   hint: 'Enter the name of the company'
//                                   )
//                                 ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 8),
//                                 child: EnterText(
//                                   controller: _phoneNumber,
//                                   label: 'Phone',
//                                   hint: 'Enter the mobile number'
//                                 )
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 8),
//                                 child: EnterText(
//                                   controller: _email,
//                                   label: 'Web Address',
//                                   hint: 'Enter the web address'
//                                 )
//                               ),
//                             ],
//                           ),
//                         ),
//                         Align(
//                             alignment: AlignmentDirectional.bottomCenter,
//                             child: LongGradientButton(
//                                 title: 'Proceed',
//                                 onPressed: () {
//                                   Get.to(() => ConfirmScreen());
//                                 }))
//                       ]),
//                 ),
//               ],
//             ));
//       });
// }
