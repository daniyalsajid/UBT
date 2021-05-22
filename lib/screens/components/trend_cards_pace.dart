import 'package:flutter/material.dart';
///[Trend] card [pace] Component
class TrendCardpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        decoration: new BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.watch),
            ),
            Text(
              "Pace",
              style: TextStyle(
                  height: 1, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Icon(Icons.trending_up),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Hervorragend! Du bist bei deiner letzten Aktivität im Durchschnitt schneller als sonst gelaufen."),
            ),
          ],
        ));
  }
}
