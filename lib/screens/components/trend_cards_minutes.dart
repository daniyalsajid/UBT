import 'package:UBT/screens/progress_screens/Circular_progress.dart';
import 'package:flutter/material.dart';
///[Trend] card [minutes] Component
class TrendCardMinutes extends StatefulWidget {
  @override
  _TrendCardMinutesState createState() => _TrendCardMinutesState();
}

class _TrendCardMinutesState extends State<TrendCardMinutes> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 150,
        decoration: new BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularPorogress(
              percentage: 10 / 100 * 100.toInt(),

              // percentage: this.totalSteps / this.goalSteps * 100.toInt(),
              height: 70,
              // child: Icon(),
              // child: Icon(
              //   CustomIcons
              //       .Pedometer.footsteps_silhouette_variant,
              //   size: 27,
              //   color: CustomColors.white,
              // )
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Icon(Icons.watch),
            // ),
            // Text(
            //   "Pace",
            //   style: TextStyle(
            //       height: 1, fontWeight: FontWeight.bold, fontSize: 14),
            // ),
            // Icon(Icons.trending_up),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //       "Hervorragend! Du bist bei deiner letzten Aktivität im Durchschnitt schneller als sonst gelaufen."),
            // ),
          ],
        ));
  }
}
