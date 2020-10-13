import 'package:flutter/material.dart';
import 'package:UBT/screens/Constant/Colors.dart' as CustomColors;
import 'package:UBT/screens/Constant/Fonts.dart' as Fonts;
import 'package:UBT/Widgets/Commons/CustomCard.dart';
import 'package:UBT/Widgets/Commons/BarChart.dart';
import 'package:UBT/Models/Chartitem.dart';

class DaysChartCard extends StatelessWidget {
  final List<ChartItem> chartItems;

  DaysChartCard({@required this.chartItems});

  @override
  Widget build(BuildContext context) {
    return new CustomCard(
      child: Container(
        child: Column(children: <Widget>[
          Container(
            child: BarChart(
              chartItems: this.chartItems,
              seriesId: 'daysPerformance',
              renderPrimaryAxis: true,
              labelOffsetFromAxisPx: 3,
            ),
            height: 115,
          ),
          Text(
            'Distance',
            style: TextStyle(
              color: CustomColors.white,
              fontSize: 13,
              fontFamily: Fonts.mainFont,
            ),
          )
        ]),
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 0),
      ),
      height: 150,
    );
  }
}
