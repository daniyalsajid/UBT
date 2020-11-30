import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:intl/intl.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Weekprogress extends StatefulWidget {
  @override
  _WeekprogressState createState() => _WeekprogressState();
}

class _WeekprogressState extends State<Weekprogress> {
  String userUID;
  final uploadAuth = FirebaseAuth.instance.currentUser.uid;
  String pace, monthnow;
  String n;
  Item selectedUser;
  String userSelectedValue;
  String selectedMonthNumber;
  // FirebaseAnimatedList userentry;
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
    _ref =
        FirebaseDatabase.instance.reference().child(uploadAuth).child('2020');

    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    monthnow = formatter.format(now);
    // userentry = chart(monthnow);
    // print('current month $monthnow');
  }

  FirebaseAnimatedList userentry;
  Map userdata;
  //
  // Card userentry;

  chart(String month) {
    return FirebaseAnimatedList(
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(bottom: 20),
        query: FirebaseDatabase.instance
            .reference()
            .child(uploadAuth)
            .child('2020')
            .child(month),
        sort: (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          userdata = snapshot.value;
          return _buildUseritem(userdata: snapshot.value);
        });

    // Container(
    //   child: Column(children: [
    //     Expanded(
    //         child: FirebaseAnimatedList(
    //             scrollDirection: Axis.vertical,
    //             padding: const EdgeInsets.only(bottom: 20),
    //             query: _ref,
    //             itemBuilder: (BuildContext context, DataSnapshot snapshot,
    //                 Animation<double> animation, int index) {
    //               // position:
    //               // animation.drive(_offset);
    //               Map userdata = snapshot.value;
    //               // print(userdata);

    //               return _buildUseritem(userdata: userdata);
    //             })

    //         //
    //         )
    //   ]),
    // );
  }

  Widget _buildUseritem({Map userdata}) {
    return Container(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 0.0,
                ),
                Text(
                  userdata['DateString'].substring(5, 10),
                  style: TextStyle(
                      color: Colors.green[900],
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  userdata['Distance'].toString().substring(0, 4),
                  style: TextStyle(
                      color: Colors.green[900],
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  width: 42,
                ),
                Text(
                  userdata['Minutes'].toString().substring(0, 4),
                  style: TextStyle(
                      color: Colors.green[900],
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  width: 40,
                ),
                Text(
                  userdata['Pace'].toStringAsFixed(2),
                  style: TextStyle(
                      color: Colors.green[900],
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  width: 45,
                ),
                Text(
                  userdata['Score'].toString().substring(0, 4),
                  style: TextStyle(
                      color: Colors.green[900],
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ), //ROw
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Deine Aktivitäten'),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  hint: Text('Select Month'),
                  value: userSelectedValue,
                  onChanged: (value) {
                    setState(
                      () {
                        userSelectedValue = value;

                        // String m = selectedUser.name;

                        // String n;

                        // if (m == null) {}

                        switch (userSelectedValue) {
                          case 'Jan':
                            {
                              // Chart('1');

                              userentry = chart('1');
                              selectedMonthNumber = "1";
                              //  monthnow = '1';
                              // print(monthnow);
                              // print(n);

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
                              selectedMonthNumber = "2";
                            }
                            break;
                            // return Expanded(child: Container(child: userentry));

                            break;
                          case 'Mar':
                            {
                              userentry = chart('3');
                              selectedMonthNumber = "3";
                            }
                            break;
                          case 'Apr':
                            {
                              userentry = chart('4');
                              selectedMonthNumber = "4";
                            }
                            break;
                          case 'May':
                            {
                              userentry = chart('5');
                              selectedMonthNumber = "5";
                            }
                            break;
                          case 'Jun':
                            {
                              userentry = chart('6');
                              selectedMonthNumber = "6";
                            }
                            break;
                          case 'Jul':
                            {
                              userentry = chart('7');
                              selectedMonthNumber = "7";
                            }
                            break;
                          case 'Aug':
                            {
                              userentry = chart('8');
                              selectedMonthNumber = "8";
                            }
                            break;
                          case 'Sep':
                            {
                              userentry = chart('9');
                              selectedMonthNumber = "9";
                            }
                            break;
                          case 'Oct':
                            {
                              userentry = chart('10');
                              selectedMonthNumber = "10";
                            }
                            break;
                          case 'Nov':
                            {
                              userentry = chart('11');
                              selectedMonthNumber = "11";
                            }
                            break;
                          case 'Dec':
                            {
                              userentry = chart('12');
                              selectedMonthNumber = "12";
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
                          Icon(Icons.calendar_today, color: Color(0xFF167F67)),
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
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 05,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.date_range,
                      size: 50,
                    )),
                Flexible(
                  child: SizedBox(
                    width: 30,
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.trending_up,
                      size: 50,
                    )),
                Flexible(
                  child: SizedBox(
                    width: 30,
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.access_time,
                      size: 50,
                    )),
                Flexible(
                  child: SizedBox(
                    width: 30,
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.shutter_speed,
                      size: 50,
                    )),
                Flexible(
                  child: SizedBox(
                    width: 30,
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.score,
                      size: 50,
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text('Date'),
                Flexible(
                  child: SizedBox(
                    width: 40,
                  ),
                ),
                Text('Distance'),
                Flexible(
                  child: SizedBox(
                    width: 30,
                  ),
                ),
                Text('Minutes'),
                Flexible(
                  child: SizedBox(
                    width: 40,
                  ),
                ),
                Text('Pace'),
                Flexible(
                  child: SizedBox(
                    width: 45,
                  ),
                ),
                Text('Score'),
              ],
            ),
            selectedMonthNumber != null
                ? Flexible(
                    child: Container(
                      height: 480,
                      width: 360,
                      child: chart(selectedMonthNumber),
                    ),
                  )
                : SizedBox(),

            // Container(
            //     height: 480, width: 400, child: chart(n.toString())),
          ],
        ));
  }
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}
