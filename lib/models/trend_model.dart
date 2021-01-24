import 'dart:convert';

class Trend {
  Trend({this.score, this.distance, this.pace, this.totalMinutes});

  String score = "0.0";
  String distance = "0.0";
  String pace = "0.0";
  String totalMinutes = "0";

  factory Trend.fromRawJson(String str) => Trend.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Trend.fromJson(Map<String, dynamic> json) => Trend(
        score: json["Score"] == null ? null : json["Score"],
        distance: json["distance"] == null ? null : json["distance"],
        pace: json["Pace"] == null ? null : json["Pace"],
        totalMinutes: json["Minutes"] == null ? null : json["Minutes"],
      );

  Map<String, dynamic> toJson() => {
        "Score": score == null ? null : score,
        "distance": distance == null ? null : distance,
        "Pace": pace == null ? null : pace,
        "Minutes": totalMinutes == null ? null : totalMinutes,
      };
}
