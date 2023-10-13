import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ProgressIndicatorBar extends StatefulWidget {
  const ProgressIndicatorBar({super.key});

  @override
  State<ProgressIndicatorBar> createState() => _ProgressIndicatorBarState();
}

class _ProgressIndicatorBarState extends State<ProgressIndicatorBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 342,
      child: const Column(
        children: [
          Text('Uploading Your Snapshot To Verify'),
          StepProgressIndicator(
            totalSteps: 20,
            currentStep: 10,
            size: 8,
            padding: 0,
            roundedEdges: Radius.circular(10),
            selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff29844B), Color(0xff072C27)]),
            unselectedColor: Colors.grey,
          )
        ],
      ),
    );
  }
}
