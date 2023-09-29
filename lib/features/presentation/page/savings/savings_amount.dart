import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/features/controllers/savings/savings_controller.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

import 'confirm_details.dart';

class SavingsAmountPage extends StatefulWidget {
  const SavingsAmountPage({super.key});

  @override
  State<SavingsAmountPage> createState() => _SavingsAmountPageState();
}

class _SavingsAmountPageState extends State<SavingsAmountPage> {
  SavingsController savingsController = Get.put(SavingsController());
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF1F1F1),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.arrow_back, color: Colors.black))),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Amount',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 10),
                            Text('Enter how much you want to save'),
                            SizedBox(height: 20),
                            Text('Gona available in wallet:'),

                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Image.asset(
                                      "assets/images/gona_logo.png"),
                                ),
                                Text(
                                  '500,000',
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0, left: 20, bottom: 10),
                              child: Text(
                                'Amount',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Color(0xff1E1E1E))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, right: 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: TextField(
                                        controller: controller,
                                        onChanged: (value) {
                                          savingsController.updateSavingsAmount(
                                              double.parse(value));
                                        },
                                        decoration: const InputDecoration(
                                          hintText:
                                              "Enter amount you want to save",
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 40,
                                            child: const VerticalDivider(
                                              color: Colors.black,
                                              thickness: 2,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: Obx(
                                              () => SvgPicture.asset(
                                                  "assets/svgs/${savingsController.tokenLogo.value}.svg"),
                                            ),
                                          ),
                                          Obx(
                                            () => Text(
                                              "${savingsController.tokenName.value}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: IconButton(
                                              onPressed: () {
                                                SavingsTokenModal(context);
                                              },
                                              icon: Icon(
                                                  size: 40,
                                                  Icons.arrow_drop_down),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20),
                              child: RichText(
                                text: const TextSpan(
                                  text: 'Your balance : NGN 500,000',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' MAX',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff29844B),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(height: 104, width: 342, child: Placeholder())
                          ]),
                    ),
                    const Spacer(),
                    LongGradientButton(
                        title: 'Complete',
                        onPressed: () {
                          // savingsController.updateSavingsAmount(
                          //     double.parse(controller.text));
                          Get.to(() => ConfirmDetails());
                        })
                  ])),
        ));
  }
}

SavingsTokenModal(BuildContext context) {
  // SavingsController savingsController = Get.put(SavingsController());
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select a token',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    'Select the token you want to use for your savings.'
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  TokensContainers(
                    leading: 'gona_logo',
                    title: 'Gona',
                    trailing: '500,000',
                  ),
                  SizedBox(height: 10),
                  TokensContainers(
                    leading: 'usdt_logo',
                    title: 'USDT',
                    trailing: '',
                  ),
                  SizedBox(height: 10),
                  TokensContainers(
                    leading: 'ccd_logo',
                    title: 'CCD O',
                    trailing: '0',
                  ),
                  SizedBox(height: 10),
                  TokensContainers(
                    leading: 'usdc_logo',
                    title: 'USDC',
                    trailing: '0',
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

class TokensContainers extends StatefulWidget {
  final String leading;
  final String title;
  final String trailing;
  const TokensContainers(
      {Key? key,
      required this.leading,
      required this.title,
      required this.trailing})
      : super(key: key);

  @override
  State<TokensContainers> createState() => _TokensContainersState();
}

class _TokensContainersState extends State<TokensContainers> {
  SavingsController savingsController = Get.put(SavingsController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        savingsController.updateTokens(widget.title, widget.leading);
        print(savingsController.tokenName.value);
        Get.back();
      },
      child: Container(
        color: Color(0xffFFFFFF),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            visualDensity: VisualDensity(horizontal: -4),
            leading: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SvgPicture.asset("assets/svgs/${widget.leading}.svg")),
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Text(
              widget.trailing,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
