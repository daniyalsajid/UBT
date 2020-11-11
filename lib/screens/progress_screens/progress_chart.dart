/// Line chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:UBT/screens/progress_screens/user_data1.dart';

class PointsLineChart extends StatelessWidget {
  final List<charts.Series<LinearSales, int>> seriesList;
  final bool animate;

  PointsLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory PointsLineChart.withSampleData() {
    return new PointsLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        // domainAxis: charts.DateTimeAxisSpec(
        //     tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
        //         day: charts.TimeFormatterSpec(
        //             format: 'dd', transitionFormat: 'dd MMM YYYY'))),
        animate: animate,
        behaviors: [
          new charts.RangeAnnotation([
            new charts.LineAnnotationSegment(
                20, charts.RangeAnnotationAxisType.measure,
                startLabel: 'Goal To Achieve',
                // endLabel: 'Measure 1 End',
                color: charts.MaterialPalette.gray.shade400),
            new charts.LineAnnotationSegment(
                02, charts.RangeAnnotationAxisType.measure,
                startLabel: 'Date',
                // endLabel: 'Measure 1 End',
                color: charts.MaterialPalette.gray.shade100),
            new charts.LineAnnotationSegment(
                1.0, charts.RangeAnnotationAxisType.domain,
                startLabel: 'Score',
                // endLabel: 'Measure 1 End',
                color: charts.MaterialPalette.gray.shade100),
          ])
        ],
        defaultRenderer: new charts.LineRendererConfig(includePoints: true));
  }

  // / Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(1, 5),
      new LinearSales(2, 10),
      // new LinearSales(3, 29),
      // new LinearSales(4, 25),
      // new LinearSales(5, 30),
      // new LinearSales(6, 75),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
