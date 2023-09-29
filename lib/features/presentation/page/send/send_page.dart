import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gonana/consts.dart';
import 'package:gonana/features/presentation/widgets/widgets.dart';

class SendPage extends StatefulWidget {
  const SendPage({super.key});

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  TextEditingController _walletAddress = TextEditingController();
  TextEditingController _amount = TextEditingController();
  String get walletAddress => _walletAddress.text;
  String get amount => _amount.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed:(){
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Color(0xff292D32)
          )
        )
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text('Send Gona',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: EnterText(
                label: "Enter Wallet Address", 
                hint: "Your wallet address", 
                controller: _walletAddress
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: EnterText(
                label: "Amount", 
                hint: "Enter amount to send ", 
                controller: _amount
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text('Your balance: N500,000',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff292D32)
                  )
                ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: greenColor,
                    width: 1,
                  )
                ),
                child: const Text('It would cost you 5 GNX to send tokens to another wallet',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff292D32)
                  )
                ),
              ),
            ),
            const Spacer(),
            LongGradientButton(
              title: "Send Now", 
              onPressed: (){}
            )
          ],
        )
      ),
    );
  }
}
