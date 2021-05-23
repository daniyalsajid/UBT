import 'package:UBT/constants/shared_preference_constants.dart';
import 'package:UBT/models/trend_model.dart';
import 'package:UBT/services/shared_preference.dart';
import 'package:flutter/material.dart';

class ProgressScreenProvider extends ChangeNotifier {
  ///Declaring and Initializing the variables and objects
  double score;
  int totaldistance;
  String totalHourWithMinutes;
  String totalMinutes = "0";
  Trend trendCard = new Trend(score: "0.0", distance: "0.0", pace: "0.0");
  Trend trendScore = new Trend(score: "0.0", distance: "0.0", pace: "0.0");
  Trend trendPace = new Trend(score: "0.0", distance: "0.0", pace: "0.0");
  Trend todayTrend = new Trend(score: "0.0", distance: "0.0", pace: "0.0");
  Trend todayScore = new Trend(score: "0.0", distance: "0.0", pace: "0.0");
  Trend todayPace = new Trend(score: "0.0", distance: "0.0", pace: "0.0");

  ///[notifyListeners] is used for refelecting the changes in UI thread

  //Setting the score value and also saving this value into the preferences
  setScoreAndGoalToAchieve(double score) {
    SharedPreferenceServiceClass()
        .addStringInSF(SharedPreferencesConstant.scoreValue, score.toString());
    this.score = score;
    notifyListeners();
  }

  //Setting the total distance
  setTotalDistance(int totaldistance) {
    this.totaldistance = totaldistance;
    notifyListeners();
  }

//Setting the hours and minutes
  setTotalHourAndMinutes(String totalHourWithMinutes) {
    this.totalHourWithMinutes = totalHourWithMinutes;
    notifyListeners();
  }

//Setting the minutes
  setTotalMinutes(String totalMinutes) {
    this.totalMinutes = totalMinutes;
    notifyListeners();
  }

//Setting the trencd distance
  setTrendDistance(String distance) {
    this.trendCard.distance = distance;
    notifyListeners();
  }

//Setting the trend score
  setTrendScore(String score) {
    this.trendScore.score = score;
    notifyListeners();
  }

//Setting the trend pace
  setTrendPace(String pace) {
    this.trendPace.pace = pace;
    notifyListeners();
  }
}
