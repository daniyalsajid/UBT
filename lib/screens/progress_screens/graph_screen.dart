import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'package:UBT/screens/progress_screens/progress_chart.dart';

class GraphScreen extends StatefulWidget {
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Screen'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Title(
            color: Colors.blue,
            child: SizedBox(
              width: 400,
              height: 300,
              child: PointsLineChart(_createSampleData()),
            )),
      ),

      // body: Container(
      //   child: SizedBox(
      //     width: 400.0,
      //     height: 300.0,
      //     child: PointsLineChart(_createSampleData()),
      //   ),
      // ),
    );
  }

  List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 10),
      new LinearSales(2, 20),
      new LinearSales(3, 18),
      new LinearSales(4, 34),
      new LinearSales(5, 55),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

// class LinearSales {
//   final int year;
//   final int sales;

//   LinearSales(this.year, this.sales);
// }
