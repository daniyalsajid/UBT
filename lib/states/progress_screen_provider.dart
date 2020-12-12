import 'package:UBT/constants/shared_preference_constants.dart';
import 'package:UBT/services/shared_preference.dart';
import 'package:flutter/material.dart';

class ProgressScreenProvider extends ChangeNotifier {
  double score;
  int totaldistance;
  String totalHourWithMinutes;

  setScoreAndGoalToAchieve(double score) {
    SharedPreferenceServiceClass()
        .addStringInSF(SharedPreferencesConstant.scoreValue, score.toString());
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
