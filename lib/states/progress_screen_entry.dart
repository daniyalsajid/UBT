import 'package:flutter/material.dart';

///[Progress Screen] State
class ProgressScreenEntry extends ChangeNotifier {
  double score;
  int totaldistance;
  String totalHourWithMinutes;

  ///[notifyListeners] is used for refelecting the changes in UI thread

  //Setting the score value
  setScoreAndGoalToAchieve(double score) {
    this.score = score;
    notifyListeners();
  }

//Setting the distance value
  setTotalDistance(int totaldistance) {
    this.totaldistance = totaldistance;
    notifyListeners();
  }

//Setting the hours and minutes value
  setTotalHourAndMinutes(String totalHourWithMinutes) {
    this.totalHourWithMinutes = totalHourWithMinutes;
    notifyListeners();
  }
}
