import 'package:flutter/material.dart';
import 'package:UBT/Widgets/Commons/CustomCard.dart';
import 'package:UBT/Widgets/Commons/CircularProgress.dart';
import 'package:UBT/Widgets/Commons/MainProgressText.dart';

class DayStepsCard extends StatelessWidget {
  final goalSteps;
  final steps;

  DayStepsCard({this.steps, this.goalSteps});

  @override
  Widget build(BuildContext context) {
    return new CustomCard(
      child: CircularPorogress(
          height: 200,
          percentage: this.steps / this.goalSteps * 100,
          child:
              MainProgressText(goalSteps: this.goalSteps, steps: this.steps)),
      height: 225,
    );
  }
}
