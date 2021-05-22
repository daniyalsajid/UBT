import 'package:flutter/material.dart';
///[Trend] card [score] Component
class TrendCardscore extends StatefulWidget {
  @override
  _TrendCardscoreState createState() => _TrendCardscoreState();
}

class _TrendCardscoreState extends State<TrendCardscore> {
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
              child: Icon(Icons.navigation),
            ),
            Text("Score",style: TextStyle(
                  height: 1, fontWeight: FontWeight.bold, fontSize: 14),),
            Icon(Icons.trending_up),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Hervorragend! Du hattest bei deiner letzten Aktivität einen höheren Score als sonst."),
            ),
          ],
        ));
  }
}
