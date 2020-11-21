import 'dart:convert';

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
  Container userentry;
  String n;
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
  String monthnow;
  String userSelectedValue;
  double s; //score
  // C for rounding score values
  int c;

  var abc;
  var valuesList, keysList;
  final uploadAuth = FirebaseAuth.instance.currentUser.uid;
  final databaseReference = FirebaseDatabase.instance.reference();
  // List<Map> lists = [];
  Item selectedUser;
  // List<Item> users = <Item>[
  //   const Item(
  //       'Jan',
  //       Icon(
  //         Icons.calendar_today,
  //         color: const Color(0xFF167F67),
  //       )),
  //   const Item(
  //       'Feb',
  //       Icon(
  //         Icons.calendar_today,
  //         color: const Color(0xFF167F67),
  //       )),
  //   const Item(
  //       'Mar',
  //       Icon(
  //         Icons.calendar_today,
  //         color: const Color(0xFF167F67),
  //       )),
  //   const Item(
  //       'Apr',
  //       Icon(
  //         Icons.calendar_today,
  //         color: const Color(0xFF167F67),
  //       )),
  //   const Item(
  //       'May',
  //       Icon(
  //         Icons.calendar_today,
  //         color: const Color(0xFF167F67),
  //       )),
  //   const Item(
  //       'Jun',
  //       Icon(
  //         Icons.calendar_today,
  //         color: const Color(0xFF167F67),
  //       )),
  //   const Item(
  //       'Jul',
  //       Icon(
  //         Icons.calendar_today,
  //         color: const Color(0xFF167F67),
  //       )),
  //   const Item(
  //       'Aug',
  //       Icon(
  //         Icons.calendar_today,
  //         color: const Color(0xFF167F67),
  //       )),
  //   const Item(
  //       'Sep',
  //       Icon(
  //         Icons.calendar_today,
  //         color: const Color(0xFF167F67),
  //       )),
  //   const Item(
  //       'Oct',
  //       Icon(
  //         Icons.calendar_today,
  //         color: const Color(0xFF167F67),
  //       )),
  //   const Item(
  //       'Nov',
  //       Icon(
  //         Icons.calendar_today,
  //         color: const Color(0xFF167F67),
  //       )),
  //   const Item(
  //       'Dec',
  //       Icon(
  //         Icons.calendar_today,
  //         color: const Color(0xFF167F67),
  //       )),
  // ];
  List<String> users = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  Query _ref;

  @override
  void initState() {
    super.initState();
    // readData();
    _ref = FirebaseDatabase.instance.reference().child(uploadAuth);

    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    monthnow = formatter.format(now);
    // print(monthnow);
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

  chart(String month) {
    final databaseReference = FirebaseDatabase.instance.reference();

    databaseReference
      ..child(uploadAuth)
          .child('2020')
          .child(month)
          .once()
          .then((DataSnapshot snapshot) {
        var date = [];
        var score = [];
        try {
          Map snapshotData = snapshot.value;
          snapshotData.forEach((key, value) => {
                date.add(value["DateString"]
                    .substring(value["DateString"].length - 2)),
                score.add(value["Score"].truncate())
              });

          // snapshot.value.forEach((x,i) => {
          //       if (x != null)
          //         {
          //           date.add(
          //               x["DateString"].substring(x["DateString"].length - 2)),
          //           score.add(x["Score"].truncate())
          //         }
          //     });
        } catch (_) {
          print(_);
          date = ["0"];
          score = [0];
        }

        setState(() {
          graphlists = date;
          keysList = score;
          d = score;
        });

        return PointsLineChart(_createSampleData(graphlists, keysList));
      });
  }

  // chart(String month) {
  //   final databaseReference = FirebaseDatabase.instance.reference();

  //   databaseReference
  //     ..child(uploadAuth)
  //         .child('2020')
  //         .child(month)
  //         .once()
  //         .then((DataSnapshot snapshot) {
  //       //print('Data : ${snapshot.value}');
  //       // snapshot.value.map((element) => {
  //       //       if (element != null) {print("element: $element")}
  //       //     });
  //       abc = snapshot.value;
  //       len = (snapshot.value.length);
  //       keysList = abc.keys.toList();
  //       d.clear();
  //       print(abc);
  //       graphlists.clear();
  //       for (int i = 0; i < len; i++) {
  //         s = (abc[keysList[i]]['Score']);
  //         c = s.truncate();
  //         d.add(keysList[i]);
  //         graphlists.add(c);
  //         // print(c);
  //       }

  //       //
  //       return PointsLineChart(_createSampleData(graphlists, keysList));
  //     });
  // }

  List<charts.Series<LinearSales, int>> _createSampleData(date, score) {
    List<LinearSales> data = [];
    if (score.length != 0 && date.length != 0) {
      for (var i = 0; i < score.length; i++) {
        data.add(new LinearSales(score[i], int.parse(date[i])));
      }
    } else {
      data.add(new LinearSales(0, 0));
    }

    // final data = [
    //   // for (var i = 0; i < lists.length; i++)
    //   //   {
    //   //     new LinearSales(int.parse(d[i]), int.parse(lists[i].toString())),
    //   //   }
    //   // new LinearSales(int.parse(d[0]), int.parse(graphlists[0].toString())),
    //   // new LinearSales(int.parse(d[1]), int.parse(graphlists[1].toString())),
    //   new LinearSales(1, 5),
    //   new LinearSales(2, 7),
    //   new LinearSales(3, 10),
    //   new LinearSales(4, 11),
    //   new LinearSales(5, 8),
    //   new LinearSales(6, 9),
    //   new LinearSales(7, 3),
    //   new LinearSales(8, 8),
    //   new LinearSales(9, 8),
    //   new LinearSales(10, 9),
    //   new LinearSales(11, 3),
    //   new LinearSales(12, 8),
    //   new LinearSales(13, 8),
    //   new LinearSales(14, 9),
    //   new LinearSales(15, 3),
    //   new LinearSales(16, 8),
    //   new LinearSales(17, 8),
    //   new LinearSales(18, 9),
    //   new LinearSales(19, 3),
    //   new LinearSales(20, 8),
    //   new LinearSales(30, 9),

    //   // new LinearSales(int.parse(d[1]), int.parse(graphlists[1].toString())),
    //   // new LinearSales(int.parse(d[2]), int.parse(graphlists[2].toString())),
    //   // new LinearSales(int.parse(d[3]), int.parse(graphlists[3].toString())),
    //   // new LinearSales(int.parse(d[4]), int.parse(graphlists[4].toString())),
    //   // new LinearSales(int.parse(d[6]), int.parse(graphlists[6].toString())),

    //   // new LinearSales(int.parse(d[7]), int.parse(graphlists[7].toString())),
    //   // new LinearSales(int.parse(d[8]), int.parse(graphlists[8].toString())),
    //   // new LinearSales(int.parse(d[9]), int.parse(graphlists[9].toString())),
    //   // new LinearSales(int.parse(d[10]), int.parse(graphlists[10].toString())),
    //   // new LinearSales(int.parse(d[11]), int.parse(graphlists[11].toString())),

    //   // new LinearSales(int.parse(d[12]), int.parse(lists[12].toString())),
    //   // new LinearSales(int.parse(d[13]), int.parse(lists[13].toString())),
    // ];

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
    return Scaffold(
        appBar: AppBar(
          title: Text('Progress Screen'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: DropdownButton(
                      hint: Text('Select Month'),
                      value: userSelectedValue,
                      onChanged: (value) {
                        setState(
                          () {
                            userSelectedValue = value;

                            // String m = selectedUser.name;
                            // String n = selectedUser.name;
                            // // print(n);
                            // print(n);
                            // switch (n) {
                            //   case '1':
                            //     {
                            //       n = '1';
                            //     }
                            //     break;
                            //   case '2':
                            //     {
                            //       n = '2';
                            //     }
                            // }

                            switch (userSelectedValue) {
                              case 'Jan':
                                {
                                  // Chart('1');

                                  userentry = chart('1');

                                  // Fluttertoast.showToast(
                                  //     msg: "This is Center Short Toast",
                                  //     toastLength: Toast.LENGTH_SHORT,
                                  //     gravity: ToastGravity.CENTER,
                                  //     timeInSecForIosWeb: 1,
                                  //     backgroundColor: Colors.red,
                                  //     textColor: Colors.white,
                                  //     fontSize: 16.0);
                                }
                                break;
                              case 'Feb':
                                {
                                  userentry = chart('2');

                                  // print(monthnow);
                                }
                                // return Expanded(child: Container(child: userentry));

                                break;

                              case 'Mar':
                                {
                                  userentry = chart('3');
                                  // print(n);
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
                              case 'Jun':
                                {
                                  userentry = chart('6');
                                }
                                break;
                              case 'Jul':
                                {
                                  userentry = chart('7');
                                }
                                break;
                              case 'Aug':
                                {
                                  userentry = chart('8');
                                }
                                break;
                              case 'Sep':
                                {
                                  userentry = chart('9');
                                }
                                break;
                              case 'Oct':
                                {
                                  userentry = chart('10');
                                }
                                break;
                              case 'Nov':
                                {
                                  userentry = chart('11');
                                }
                                break;
                              case 'Dec':
                                {
                                  userentry = chart('12');
                                }
                                break;
                            }
                          },
                        );
                      },
                      items: users.map((String month) {
                        return DropdownMenuItem<String>(
                          value: month,

                          // Row to Cloumn
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.calendar_today,
                                  color: Color(0xFF167F67)),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                month,
                                style: TextStyle(color: Colors.black),
                              ),
                              //
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Container(
                    width: 380,
                    height: 280,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.green)),
                    child: PointsLineChart(_createSampleData(graphlists, d)),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.green)),
                    child: SizedBox(
                      width: 380,
                      height: 250,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.trending_up,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
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
                                    borderRadius: BorderRadius.circular(18.0),
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
                                    borderRadius: BorderRadius.circular(8.0),
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
                                    // print(score);
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
                ),
              ],
            )
          ],
        ));
  }
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}
