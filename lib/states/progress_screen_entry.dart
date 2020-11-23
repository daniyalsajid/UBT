import 'package:flutter/material.dart';

class ProgressScreenEntry extends ChangeNotifier {
  double score;
  int totaldistance;
  String totalHourWithMinutes;

  setScoreAndGoalToAchieve(double score) {
    this.score = score;
    notifyListeners();
  }

  setTotalDistance(int totaldistance) {
    this.totaldistance = totaldistance;
    notifyListeners();
  }

  setTotalHourAndMinutes(String totalHourWithMinutes) {
    this.totalHourWithMinutes = totalHourWithMinutes;
    notifyListeners();
  }
}
