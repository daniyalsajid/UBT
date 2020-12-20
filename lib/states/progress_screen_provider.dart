import 'package:UBT/constants/shared_preference_constants.dart';
import 'package:UBT/models/trend_model.dart';
import 'package:UBT/services/shared_preference.dart';
import 'package:flutter/material.dart';

class ProgressScreenProvider extends ChangeNotifier {
  double score;
  int totaldistance;
  String totalHourWithMinutes;
  Trend trendCard = new Trend(score: "0.0", distance: "0.0");
  Trend todayTrend = new Trend(score: "0.0", distance: "0.0");

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

  setTrend(String distance) {
    this.trendCard.distance = distance;
    notifyListeners();
  }
}
