// import 'package:UBT/screens/progress_screens/user_entry.dart';
// import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:UBT/screens/progress_screens/user_entry.dart';
import 'package:UBT/screens/progress_screens/progress_chart.dart';
// import 'package:provider/single_child_widget.dart';

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
      ),
      body: Container(
        child: SizedBox(
          width: 400.0,
          height: 300.0,
          child: PointsLineChart(_createSampleData()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        child: Icon(Icons.edit),
        onPressed: () {
          Userdata();
        },
      ),
    );
  }

  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 200),
      new LinearSales(3, 75),
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
