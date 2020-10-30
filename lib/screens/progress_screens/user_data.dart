import 'package:UBT/Utils/CaloriesCalculator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:UBT/screens/progress_screens/progress_chart.dart';
import 'package:UBT/screens/progress_screens/time_series.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class Userdata extends StatefulWidget {
  @override
  _UserdataState createState() => _UserdataState();
}

class _UserdataState extends State<Userdata> {
  String userUID;
  var valuesList, keysList;
  final uploadAuth = FirebaseAuth.instance.currentUser.uid;
  // List<Map> lists = [];

  Query _ref;

  @override
  void initState() {
    super.initState();
    readData();
    _ref = FirebaseDatabase.instance.reference().child(uploadAuth);
  }

  Widget _buildUser() {}

  Future<List> readData() async {
    final databaseReference = FirebaseDatabase.instance.reference();
    Map<dynamic, dynamic> map;
    await databaseReference
        .child(uploadAuth)
        .once()
        .then((DataSnapshot snapshot) {
      map = snapshot.value;
    });

    keysList = map.keys.toList();
    valuesList = map.values.toList();

//    print('Retrived Data : ${map.values.toList()[1]["Calories"]}');
    print('keysList : ${keysList[0]}');
  }

  List<charts.Series<LinearSales, int>> _createSampleData(list, keylist) {
    final data = [
      new LinearSales(int.parse(list[0]["DateWeek"].toString()),
          int.parse(list[0]["VO2 max"].substring(0, 2))),

      // new LinearSales(int.parse(list[1]["DateWeek"].toString()),
      //     int.parse(list[1]["VO2 max"].substring(0, 2))),

      // new LinearSales(int.parse(list[2]["DateWeek"].toString()),
      //     int.parse(list[2]["VO2 max"].substring(0, 2))),

      // new LinearSales(int.parse(list[3]["DateWeek"].toString()),
      //     int.parse(list[3]["VO2 max"].substring(0, 2))),

      // new LinearSales(
      //     int.parse(list[1]["Distance"]), int.parse(list[0]["Calories"])),
      // new LinearSales(
      //     int.parse(list[2]["Distance"]), int.parse(list[2]["Calories"])),
//       // new LinearSales(list[1]['Date'], int.parse(list[2]["Calories"])),
//       // new LinearSales(list[2]['Date'], int.parse(list[3]["Calories"]))

// //      new LinearSales(3, 18),
// //      new LinearSales(4, 34),
// //      new LinearSales(5, 95),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        fillColorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readData(),
        builder: (ctx, snapshot) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Progress Screen'),
                centerTitle: true,
                backgroundColor: Colors.green,
              ),
              body: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                        height: 10,
                      ),
                      Text(
                        'Month Progress',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green)),
                            child: Title(
                                color: Colors.blue,
                                child: SizedBox(
                                  width: 380,
                                  height: 320,
                                  child: PointsLineChart(
                                      _createSampleData(valuesList, keysList)),
                                )),
                          )
                        ],
                      )
                    ],
                  )
                ],
              )

              //  Container(
              //   child: Title(
              //       color: Colors.blue,
              //       child: SizedBox(
              //         width: 400,
              //         height: 300,
              //         child: PointsLineChart(
              //             _createSampleData(valuesList, keysList)),
              //       )),
              // ),
              );
        });
  }
}
