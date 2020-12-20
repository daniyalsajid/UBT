import 'dart:convert';

class Trend {
  Trend({
    this.score,
    this.distance,
  });

  String score = "0.0";
  String distance = "0.0";

  factory Trend.fromRawJson(String str) => Trend.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Trend.fromJson(Map<String, dynamic> json) => Trend(
        score: json["score"] == null ? null : json["score"],
        distance: json["distance"] == null ? null : json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "score": score == null ? null : score,
        "distance": distance == null ? null : distance,
      };
}
