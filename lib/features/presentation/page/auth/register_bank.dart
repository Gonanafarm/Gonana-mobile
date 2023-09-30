import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/page/market/cart_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/bank_controller.dart';
import '../../../controllers/user/user_controller.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/widgets.dart';
import '../profile_photo/add_profile_photo1.dart';
import '../store/store_confirm_screen.dart';

class RegisterBank extends StatefulWidget {
  const RegisterBank({Key? key}) : super(key: key);

  @override
  State<RegisterBank> createState() => _RegisterBankState();
}

class _RegisterBankState extends State<RegisterBank> {
  final TextEditingController _accountNumber = TextEditingController();
  BankController bankController = Get.put(BankController());
  final userController = Get.find<UserController>();
  String selectedBank = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    bankController.fetchBank();
  }

  Future<List<String>> fetchData() async {
    // Simulate asynchronous data fetching (replace with your actual data fetching logic)
    await Future.delayed(Duration(seconds: 2));
    return bankController.banks; // Replace with your data
  }

  Future fetchAccountDetails() async {
    return bankController.resolveBankModel!.data!.data!.accountName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Add bank account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
              const Text(
                'Add your commercial bank account you want your money to be paid into.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Proxima Nova',
                  fontWeight: FontWeight.w400,
                ),
              ),
              sizeVer(20),
              const Text(
                'Bank',
                style: TextStyle(
                  color: Color(0xFF444444),
                  fontSize: 16,
                  fontFamily: 'Proxima Nova',
                  fontWeight: FontWeight.w600,
                ),
              ),
              FutureBuilder(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Return a loading indicator while data is being fetched
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // Handle error
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      // Handle the case where data is empty
                      return Text('No data available');
                    } else {
                      return CustomDropDown(
                        labelText: "Bank",
                        options: bankController.banks,
                        onChanged: (option) {
                          setState(() {
                            selectedBank = option;
                          });
                        },
                        hintText: 'Select your bank',
                        fillColor: Colors.transparent,
                        elevation: 2,
                        margin: EdgeInsetsDirectional.fromSTEB(12, 10, 15, 4),
                        hidesUnderline: true,
                        initialOption: selectedBank,
                      );
                    }
                  }),
              sizeVer(15),
              EnterText(
                onChanged: (value) async {
                  _accountNumber.text = value;
                  if (_accountNumber.text.length == 10 &&
                      selectedBank.isNotEmpty) {
                    try {
                      String? bankName = await bankController.fetchAccountName(
                        selectedBank,
                        _accountNumber.text.trim(),
                      );

                      setState(() {
                        bankController.resolveBankModel!.data!.data!
                            .accountName = bankName;
                      });
                    } catch (error) {
                      // Handle any errors that occur during the async operation.
                    }
                  }
                },
                controller: _accountNumber,
                keyboardType: TextInputType.number,
                label: 'Account number',
                hint: 'Enter your account number',
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Text(
                      'Account Name: ',
                      style: TextStyle(
                        color: Color(0xFF29844B),
                        fontSize: 10,
                        fontFamily: 'Proxima Nova',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (bankController.resolveBankModel != null &&
                        bankController.resolveBankModel!.data != null &&
                        bankController.resolveBankModel!.data!.data != null &&
                        bankController
                                .resolveBankModel!.data!.data!.accountName !=
                            null &&
                        bankController.resolveBankModel!.data!.data!
                            .accountName!.isNotEmpty) ...[
                      FutureBuilder<String?>(
                        future: bankController.fetchAccountName(
                            selectedBank, _accountNumber.text.trim()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data == null) {
                            return Text('No data available');
                          } else {
                            return Text(
                              snapshot.data!,
                              style: TextStyle(
                                color: Color(0xFF29844B),
                                fontSize: 10,
                                fontFamily: 'Proxima Nova',
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ],
                ),
              ),
              Spacer(),
              LongGradientButton(
                  isLoading: isLoading,
                  title: "Save",
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    var isCreated = false;
                    isCreated = await bankController.updateBankDetails(
                        _accountNumber.text.trim(), selectedBank, context);
                    if (isCreated) {
                      Get.to(() => const ConfirmScreen());
                      setState(() {
                        isLoading = false;
                      });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
