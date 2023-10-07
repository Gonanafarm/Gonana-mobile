import "package:flutter/material.dart";
import 'package:gonana/consts.dart';
import 'package:flutter_svg/svg.dart';

class FiatWithdrawal extends StatefulWidget {
  const FiatWithdrawal({super.key});

  @override
  State<FiatWithdrawal> createState() => _FiatWithdrawalState();
}

class _FiatWithdrawalState extends State<FiatWithdrawal> {
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
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Withdrawal',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                  )
                )
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Enter the amount you want to withdraw',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black)
                  ),
                  child: Row(
                    
                  )
                )
              )
            ]
          ),
        )
      )
    );
  }
}
