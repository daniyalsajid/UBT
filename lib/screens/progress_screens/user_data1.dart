import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:UBT/screens/progress_screens/progress_chart.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class Userdata extends StatefulWidget {
  @override
  UserdataState createState() => UserdataState();
}

class UserdataState extends State<Userdata> {
  String userUID;
  //y axis
  List graphlists = [];
  // x axis
  List d = [];
  // var lists;
  // var d;
  int len;
  String minutes;
  int totalminuites;
  int totaldistance;
  String distance;
  double score;

  double s; //score
  // C for rounding score values
  int c;

  Map abc;
  var valuesList, keysList;
  final uploadAuth = FirebaseAuth.instance.currentUser.uid;
  // List<Map> lists = [];
  Item selectedUser;
  List<Item> users = <Item>[
    const Item(
        'Jan',
        Icon(
          Icons.calendar_today_rounded,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Feb',
        Icon(
          Icons.calendar_today_rounded,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Mar',
        Icon(
          Icons.calendar_today_rounded,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Apr',
        Icon(
          Icons.calendar_today_rounded,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'May',
        Icon(
          Icons.calendar_today_rounded,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Jun',
        Icon(
          Icons.calendar_today_rounded,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Jul',
        Icon(
          Icons.calendar_today_rounded,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Aug',
        Icon(
          Icons.calendar_today_rounded,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Sep',
        Icon(
          Icons.calendar_today_rounded,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Oct',
        Icon(
          Icons.calendar_today_rounded,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Nov',
        Icon(
          Icons.calendar_today_rounded,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Dec',
        Icon(
          Icons.calendar_today_rounded,
          color: const Color(0xFF167F67),
        )),
  ];

  Query _ref;

  @override
  void initState() {
    super.initState();
    // readData();
    _ref = FirebaseDatabase.instance.reference().child(uploadAuth);
  }

  createData1() {
    double percentmax, vo2;

    percentmax = (0.8 +
        0.1894393 * (exp(-0.012778 * int.parse(totalminuites.toString()))) +
        0.2989558 * (exp(-0.1932605 * int.parse(totalminuites.toString()))));

    vo2 = ((-4.60 +
            0.182258 *
                (int.parse(totaldistance.toString()) *
                    1000 /
                    int.parse(totalminuites.toString()))) +
        0.000104 *
            pow(
                int.parse(totaldistance.toString()) *
                    1000 /
                    int.parse(totalminuites.toString()),
                2));

    score = vo2 / percentmax;
    // print(score);
    return score;
  }

  Widget onTab() {
    Picker(
      adapter: NumberPickerAdapter(data: <NumberPickerColumn>[
        const NumberPickerColumn(begin: 1, end: 10, suffix: Text(' Km')),
      ]),
      delimiter: <PickerDelimiter>[
        PickerDelimiter(
          child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.more_vert),
          ),
        )
      ],
      hideHeader: true,
      confirmText: 'Ok',
      confirmTextStyle:
          TextStyle(inherit: false, color: Colors.red, fontSize: 22),
      title: const Text('Select Distance'),
      selectedTextStyle: TextStyle(color: Colors.green),
      onConfirm: (Picker picker, List<int> value) {
        Duration hours1 = Duration(hours: picker.getSelectedValues()[0]);

        // You get your duration here
        Duration _duration = Duration(
          hours: picker.getSelectedValues()[0],
        );

        totaldistance = num.parse(hours1.toString().substring(0, 1));
      },
    ).showDialog(context);
    return Container();
  }

  Widget onTap() {
    Picker(
      adapter: NumberPickerAdapter(data: <NumberPickerColumn>[
        const NumberPickerColumn(begin: 0, end: 6, suffix: Text(' hours')),
        const NumberPickerColumn(
            begin: 0, end: 60, suffix: Text(' minutes'), jump: 0),
        const NumberPickerColumn(begin: 0, end: 60, suffix: Text(' Sec')),
      ]),
      delimiter: <PickerDelimiter>[
        PickerDelimiter(
          child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.more_vert),
          ),
        )
      ],
      hideHeader: true,
      confirmText: 'OK',
      confirmTextStyle:
          TextStyle(inherit: false, color: Colors.red, fontSize: 22),
      title: const Text('Select Minutes'),
      selectedTextStyle: TextStyle(color: Colors.green),
      onConfirm: (Picker picker, List<int> value) {
        Duration hours1 = Duration(hours: picker.getSelectedValues()[0]);
        Duration minutes1 = Duration(minutes: picker.getSelectedValues()[1]);
        Duration seconds1 = Duration(seconds: picker.getSelectedValues()[2]);

        // You get your duration here
        Duration _duration = Duration(
          hours: picker.getSelectedValues()[0],
          minutes: picker.getSelectedValues()[1],
          seconds: picker.getSelectedValues()[2],
        );

        int hoursnew = num.parse(hours1.toString().substring(0, 1)) * 60;

        int minutesnew = num.parse(minutes1.toString().substring(2, 4));
        // int secondsnew = num.parse(seconds1.toString().substring(2, 4)) ~/ 60;

        totalminuites = hoursnew + minutesnew;
        // print(totalminuites);

        // + int.parse(secondsnew.toString());
        // print(_duration.toString().substring(0));

        // minutesnew = _duration.toString().substring(0);

        return totalminuites;
      },
    ).showDialog(context);
    return Container();
  }

  // Future<List> readData() async {
  // final databaseReference = FirebaseDatabase.instance.reference();
  // Map<dynamic, dynamic> map;
  // await databaseReference
  //     .child(uploadAuth)
  //     .child('2020')
  //     .child('10')
  //     .once()
  //     .then((DataSnapshot snapshot) {
  //   map = snapshot.value;
  // });
  String month;
  Card userentry;
  chart(String month) {
    _ref = FirebaseDatabase.instance
        .reference()
        .child(uploadAuth)
        .child('2020')
        .child(month);

    return Card(
      child: PointsLineChart(_createSampleData(graphlists, keysList)),
    );
  }

  Future<List> getData() async {
    final databaseReference = FirebaseDatabase.instance.reference();
    _ref = FirebaseDatabase.instance.reference().child(uploadAuth);
    // Map<dynamic, dynamic> map;
    // await databaseReference
    //     .child(uploadAuth)
    //     .child('2020')
    //     .child('10')
    //     .once()
    //     .then((DataSnapshot snapshot) {
    //   map = snapshot.value;
    // });

    // List lists = [];
    // List d = [];
    // int len;
    // double s; //score
    // Map abc;
    databaseReference
      ..child(uploadAuth)
          .child('2020')
          .child('10')
          .once()
          .then((DataSnapshot snapshot) {
        //print('Data : ${snapshot.value}');
        abc = snapshot.value;
        // print(abc);
        len = (snapshot.value.length);
        keysList = abc.keys.toList();
        d.clear();
        graphlists.clear();
        for (int i = 0; i < len; i++) {
          s = (abc[keysList[i]]['Score']);
          c = s.truncate();

          d.add(keysList[i]);
          graphlists.add(c);
        }
        return Container();

        // print(d);
        // return _ref;
      });
  }

  // getData();

  // keysList = map.keys.toList();
  // valuesList = map.values.toList();
  // return keysList;
  // return null;
  // }

  List<charts.Series<LinearSales, int>> _createSampleData(graphlist, d) {
    final data = [
      // for (var i = 0; i < lists.length; i++)
      //   {
      //     new LinearSales(int.parse(d[i]), int.parse(lists[i].toString())),
      //   }
      // new LinearSales(int.parse(d[0]), int.parse(graphlists[0].toString())),
      // new LinearSales(int.parse(d[1]), int.parse(graphlists[1].toString())),

      new LinearSales(int.parse(d[2]), int.parse(graphlists[2].toString())),
      // new LinearSales(int.parse(d[3]), int.parse(graphlists[3].toString())),
      // new LinearSales(int.parse(d[4]), int.parse(graphlists[4].toString())),
      // new LinearSales(int.parse(d[5]), int.parse(graphlists[5].toString())),
      // new LinearSales(int.parse(d[6]), int.parse(graphlists[6].toString())),

      // new LinearSales(int.parse(d[7]), int.parse(graphlists[7].toString())),
      // new LinearSales(int.parse(d[8]), int.parse(graphlists[8].toString())),
      // new LinearSales(int.parse(d[9]), int.parse(graphlists[9].toString())),
      // new LinearSales(int.parse(d[10]), int.parse(graphlists[10].toString())),
      // new LinearSales(int.parse(d[11]), int.parse(graphlists[11].toString())),

      // new LinearSales(int.parse(d[12]), int.parse(lists[12].toString())),
      // new LinearSales(int.parse(d[13]), int.parse(lists[13].toString())),
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
        future: getData(),
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
                      // Text(
                      //   'Month Progress',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontSize: 24,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      DropdownButton(
                        hint: Text(' Month'),
                        value: selectedUser,
                        onChanged: (Item value) {
                          setState(() {
                            selectedUser = value;
                            String m = selectedUser.name;

                            switch (m) {
                              case 'Jan':
                                {
                                  userentry = chart('1');
                                }
                                break;
                              case 'Feb':
                                {
                                  userentry = chart('2');
                                }
                                break;
                              case 'Mar':
                                {
                                  userentry = chart('3');
                                }
                                break;
                              case 'Apr':
                                {
                                  userentry = chart('4');
                                }
                                break;
                              case 'May':
                                {
                                  userentry = chart('5');
                                }
                                break;
                            }
                          });
                        },
                        items: users.map((Item user) {
                          return DropdownMenuItem<Item>(
                            value: user,

                            // Row to Cloumn
                            child: Row(
                              children: <Widget>[
                                user.icon,
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  user.name,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      // Expanded(child: userentry)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  height: 280,
                                  child: userentry,

                                  // child: PointsLineChart(
                                  //     _createSampleData(graphlists, keysList)),
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green)),
                        child: SizedBox(
                          width: 380,
                          height: 250,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'What is your goal?',
                                    style: TextStyle(
                                        height: 1.5,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Think of a certain distance that you would \n like to run in a certain time, \n in one or two months fom now?',
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        height: 1,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(
                                    Icons.trending_up_outlined,
                                    color: Colors.black,
                                    size: 36.0,
                                    semanticLabel:
                                        'Text to announce in accessibility modes',
                                  ),
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.blue,
                                    size: 36.0,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      child: Text(
                                        "Distance".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.green,
                                        ),
                                      ),
                                      onPressed: () {
                                        onTab();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      child: Text(
                                        "Minutes".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.green,
                                        ),
                                      ),
                                      onPressed: () {
                                        onTap();
                                      },
                                    ),
                                  ),
                                  // TextFormField(
                                  //   keyboardType: TextInputType.number,
                                  //   decoration: InputDecoration(
                                  //       labelText: 'Distance',
                                  //       fillColor: Colors.white,
                                  //       focusedBorder: OutlineInputBorder(
                                  //           borderSide: BorderSide(
                                  //               color: Colors.blue,
                                  //               width: 2.0))),
                                  //   onChanged: (String dist) {
                                  //     // distance = dist;
                                  //   },
                                  // ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(145, 0, 0, 0),
                                    child: RaisedButton(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Text(
                                        "Score: $score".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.green,
                                        ),
                                      ),
                                      onPressed: () {
                                        createData1();
                                        print(score);
                                      },
                                    ),

                                    // Text('Goal Score: $score'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ));
        });
  }
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}
