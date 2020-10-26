import 'package:UBT/Utils/CaloriesCalculator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:UBT/screens/progress_screens/progress_chart.dart';
import 'package:UBT/screens/profile_screen/User.dart';

class Userdata extends StatefulWidget {
  @override
  _UserdataState createState() => _UserdataState();
}

class _UserdataState extends State<Userdata> {
  String userUID;
  final uploadAuth = FirebaseAuth.instance.currentUser.uid;
  // List<Map> lists = [];

  Query _ref;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child(uploadAuth);
  }

  // Widget _buildUserdata() {
  //   return Container(
  //       child: Title(
  //     color: Colors.blue,
  //     child: SizedBox(
  //         width: 400, height: 300, child: PointsLineChart(_seriesBarData)),
  //   ));
  // }

  List<charts.Series<Users, String>> _seriesBarData;
  List<Users> myData;
  _generateData(myData) {
    _seriesBarData.add(charts.Series(
        id: 'Users',
        domainFn: (Users userdata, _) => userdata.scoreVal.toString(),
        measureFn: ((Users userdata, _) => userdata.scoreDate),
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        data: myData));
  }

  // static List<charts.Series<LinearSales, int>> _createSampleData() {
  //   final data = [
  //     // new LinearSales(userdata['Date'], userdata[int.parse('Distance')]),
  //     // new LinearSales(userdata['Date'], userdata[int.parse('Distance')]),
  //     // new LinearSales(userdata['Date'], userdata[int.parse('Distance')]),
  //     new LinearSales(1, 18),
  //     new LinearSales(4, 34),
  //     new LinearSales(5, 55),
  //   ];

  //   return [
  //     new charts.Series<LinearSales, int>(
  //       id: 'Sales',
  //       colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
  //       domainFn: (LinearSales sales, _) => sales.year,
  //       measureFn: (LinearSales sales, _) => sales.sales,
  //       data: data,
  //     )
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daniyal'),
      ),
      body: _buildBody(context),

      // Container(
      //   child: Title(
      //       color: Colors.blue,
      //       child: SizedBox(
      //         width: 400,
      //         height: 300,
      //         child: PointsLineChart(_createSampleData()),
      //       )),
      // ),
    );
  }

  Widget _buildBody(context) {
    return StreamBuilder(
        stream: _ref.onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('Test');
            return LinearProgressIndicator();
          } else {
            List<Users> userdata = snapshot.data.value;

            return _buildChart(context, userdata);
          }
        });
  }

  Widget _buildChart(BuildContext context, List<Users> userdata) {
    // myData = userdata;
    _generateData(userdata);
    return Container(
        child: Title(color: Colors.blue, child: charts.BarChart(_seriesBarData)

            //  SizedBox(
            //     width: 400, height: 300, child: PointsLineChart(_seriesBarData)),
            ));
  }
}

// FutureBuilder(
//             future: _ref.once(),
//             builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
//               if (snapshot.hasData) {
//                 Map values = snapshot.data.value;

//                 values.forEach((key, value) {
//                   lists.add(values);
//                 });

//                 return new ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: lists.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       // Map values = snapshot.value;
//                       return Card(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                         ),
//                       );
//                     });
//               }
//               return CircularProgressIndicator();
//             })
