import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class UserEntry extends StatefulWidget {
  @override
  UserEntryState createState() => UserEntryState();
}

class UserEntryState extends State<UserEntry> {
  String calories, heartrate;
  double pace, percentmax, vo2, score, distance;

  String minutes;
  int totalminuites, height;

  DateTime mydate = DateTime.now();
  // String userDistance;

  String userUID;
  final uploadAuth = FirebaseAuth.instance.currentUser.uid;

  getUserUID(firebaseAuth) {
    this.userUID = firebaseAuth.UserUID;
  }

//RealtimeDatabase
  createData1() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(mydate);
    int day = int.parse(DateFormat('d').format(mydate));
    int month = int.parse(DateFormat('M').format(mydate));
    int year = int.parse(DateFormat('y').format(mydate));
    // double pace, percentmax, vo2, score, distance;
    pace = (int.parse(totalminuites.toString()) / distance);
    // int.parse(distance.toString()));
    percentmax = (0.8 +
        0.1894393 * (exp(-0.012778 * int.parse(totalminuites.toString()))) +
        0.2989558 * (exp(-0.1932605 * int.parse(totalminuites.toString()))));

    vo2 = ((-4.60 +
            0.182258 *
                (distance *

                    // (int.parse(distance.toString()) *
                    1000 /
                    int.parse(totalminuites.toString()))) +
        0.000104 *
            pow(
                distance *

                    // int.parse(distance.toString()) *
                    1000 /
                    int.parse(totalminuites.toString()),
                2));
    score = vo2 / percentmax;

    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child(uploadAuth);

    databaseReference
        .child(year.toString())
        .child(month.toString())
        .child(day.toString())
        .set({
      'Minutes': totalminuites.toString(),
      'Heartrate': heartrate,
      'Calories': calories,
      'DateString': formattedDate,
      'Distance': distance,
      'Höhenunterschied': height,
      'Pace': pace,
      'Percent_max': percentmax,
      'VO2': vo2,
      'Score': score,
    }).whenComplete(() => {print('$uploadAuth realtime created')});
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
      title: const Text('Select duration'),
      selectedTextStyle: TextStyle(color: Colors.blue),
      onConfirm: (Picker picker, List<int> value) {
        Duration hours1 = Duration(hours: picker.getSelectedValues()[0]);
        Duration minutes1 = Duration(minutes: picker.getSelectedValues()[1]);
        Duration seconds1 = Duration(seconds: picker.getSelectedValues()[2]);

        // You get your duration here
        // Duration _duration = Duration(
        //   hours: picker.getSelectedValues()[0],
        //   minutes: picker.getSelectedValues()[1],
        //   // seconds: picker.getSelectedValues()[2],
        // );

        int hoursnew = num.parse(hours1.toString().substring(0, 1)) * 60;

        int minutesnew = num.parse(minutes1.toString().substring(2, 4));
        int secondsnew = num.parse(seconds1.toString().substring(5, 6)) ~/ 60;

        // print(_duration);
        // print(hoursnew);
        // print(minutesnew);
        setState(() {
          totalminuites = hoursnew + minutesnew + secondsnew;
        });

        // print(totalminuites);

        // + int.parse(secondsnew.toString());
        // print(_duration.toString().substring(0));

        // minutesnew = _duration.toString().substring(0);
        print(secondsnew);

        return totalminuites;
      },
    ).showDialog(context);
    // return Container();
  }

  // isvalue() {
  //   return pace = (distance * minutes.toInt());
  // }

  // readData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deine Aktivitate aufnehmen'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  "Select Duration".toUpperCase(),
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
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Total Minutes: $totalminuites'),
            ),
            DateTimeField(
              selectedDate: mydate,
              onDateSelected: (DateTime date) {
                setState(() {
                  mydate = date;
                  // print(mydate);
                });
              },
              lastDate: DateTime(2025),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Heart-Rate',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.green, width: 2.0))),
                onChanged: (String ht) {
                  heartrate = ht;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Distance',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.green, width: 2.0))),
                onChanged: (String dist) {
                  distance = double.parse(dist);
                  // distance = double.parse(dist);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Höhenunterschied  ',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.green, width: 2.0))),
                onChanged: (String hight) {
                  height = int.parse(hight);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Calories',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.green, width: 2.0))),
                // onChanged: (String calories) {
                //   getUserCalories(calories);
                // },
                onChanged: (String cal) {
                  calories = cal;
                  //getUserCalories(calories);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Text("Create"),
                  textColor: Colors.white,
                  onPressed: () {
                    // createData();
                    createData1();
                    Fluttertoast.showToast(
                        msg: "Data Is Stored",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.lightGreen,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
