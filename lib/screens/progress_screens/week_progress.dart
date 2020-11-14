// import 'package:UBT/Utils/CaloriesCalculator.dart';
import 'package:UBT/screens/progress_screens/user_data1.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:collection';
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
  int n;
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
    _ref =
        FirebaseDatabase.instance.reference().child(uploadAuth).child('2020');

    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    monthnow = formatter.format(now);
    // userentry = chart(monthnow);
    // print('current month $monthnow');
  }

  Container userentry;

  //
  // Card userentry;

  chart(String month) {
    _ref = FirebaseDatabase.instance
        .reference()
        .child(uploadAuth)
        .child('2020')
        .child(month);

    return Container(
      child: Column(children: [
        Expanded(
            child: FirebaseAnimatedList(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(bottom: 20),
                query: _ref,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  // position:
                  // animation.drive(_offset);
                  Map userdata = snapshot.value;
                  // print(userdata);

                  return _buildUseritem(userdata: userdata);
                })

            //
            )
      ]),
    );
  }

  Widget _buildUseritem({Map userdata}) {
    return Container(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 05,
                height: 30,
              ),
              Text(
                userdata['DateString'].substring(5, 10),
                style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 22,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                userdata['Distance'.toString()].substring(0, 1),
                style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 22,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: 60,
              ),
              Text(
                userdata['Minutes'.toString()],
                style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 22,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: 55,
              ),
              Text(
                userdata['Pace'].toString().substring(0, 1),
                style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 22,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: 45,
              ),
              Text(
                userdata['Score'].toString().substring(0, 2),
                style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 22,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ), //ROw
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Deine Aktivitaten'),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: Scrollbar(
          child: Container(
            height: 600,
            width: 400,
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                  width: 50,
                ),

                // Row(),

                DropdownButton(
                  hint: Text('Select Month'),
                  value: selectedUser,
                  onChanged: (Item value) {
                    setState(
                      () {
                        selectedUser = value;

                        String m = selectedUser.name;
                        print(m);
                        if (m == null) {}

                        switch (m) {
                          case 'Jan':
                            {
                              // Chart('1');

                              userentry = chart('1');
                              // n = 1;
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
                              // n = 2;
                              // print(n);
                            }
                            // return Expanded(child: Container(child: userentry));

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
                          //
                        ],
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 05,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.date_range_rounded,
                          size: 50,
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.trending_up_outlined,
                          size: 50,
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.access_time,
                          size: 50,
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.speed_rounded,
                          size: 50,
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.score_outlined,
                          size: 50,
                        )),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text('Date'),
                    SizedBox(
                      width: 40,
                    ),
                    Text('Distance'),
                    SizedBox(
                      width: 30,
                    ),
                    Text('Minutes'),
                    SizedBox(
                      width: 40,
                    ),
                    Text('Pace'),
                    SizedBox(
                      width: 45,
                    ),
                    Text('Score'),
                  ],
                ),

                Expanded(child: Container(child: userentry))
              ],
            ),
          ),
        ));
  }
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}
