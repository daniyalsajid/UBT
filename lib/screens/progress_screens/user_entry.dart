import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:math';

// import 'package:firebase_database/firebase_database.dart';

class UserEntry extends StatefulWidget {
  @override
  _UserEntryState createState() => _UserEntryState();
}

class _UserEntryState extends State<UserEntry> {
  String distance, calories, heartrate, score;
  String minutes;
  // var minutess = int.parse(minutes);
  int pace;
  DateTime mydate = DateTime.now();
  // String userDistance;

  String userUID;
  final uploadAuth = FirebaseAuth.instance.currentUser.uid;

  // String postid = FieldPath.documentId(docid);
  // final databaseReference = FirebaseDatabase.instance.reference();
  // final DocumentReference = FirebaseFirestore.instance;

  // getUserName(name) {
  //   this.userName = name;
  // }

  getUserUID(firebaseAuth) {
    this.userUID = firebaseAuth.UserUID;
  }

  // getUserDate(pace) {
  //   this.pace = distance;
  // }

  // getUserDistance(distance) {
  //   this.userDistance = distance;
  // }

  // getUserCalories(calories) {
  //   this.userCalories = calories;
  // }

//RealtimeDatabase
  createData1() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(mydate);
    String formattedDate1 = DateFormat('d').format(mydate);
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child(uploadAuth);

    // Map date_map = {'Day':formattedDate1,
    // 'Mon':}

    databaseReference.child(formattedDate).set({
      // 'Date': formattedDate,
      'Minutes': minutes,
      'Heartrate': heartrate,
      'Calories': calories,
      'DateString': formattedDate,
      // 'Date': date_map,
      // 'Datenow': databaseReference
      //     .child('Datenow')
      //     .set('Daniyal')
      //     .whenComplete(() => {print('$uploadAuth realtime created')}),

      'DateWeek': formattedDate1,
      'Distance': distance,
      'pace': (int.parse(minutes) / int.parse(distance)),
      'percent_max': (0.8 +
          0.1894393 * (exp(-0.012778 * int.parse(minutes))) +
          0.2989558 * (exp(-0.1932605 * int.parse(minutes)))),

      'VO2': (((-4.60 +
                  0.182258 *
                      (int.parse(distance) * 1000 / int.parse(minutes))) +
              0.000104 *
                  pow(int.parse(distance) * 1000 / int.parse(minutes), 2)))
          .toString(),
      'VO2 max': ((-4.60 +
                  0.182258 *
                      (int.parse(distance) * 1000 / int.parse(minutes))) +
              0.000104 *
                  pow((int.parse(distance) * 1000 / int.parse(minutes)), 2) /
                  (0.8 +
                      0.1894393 * (exp(-0.012778 * int.parse(minutes))) +
                      0.2989558 * (exp(-0.1932605 * int.parse(minutes)))))
          .toString(),
    }).whenComplete(() => {print('$uploadAuth realtime created')});
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
      body: Column(
        children: <Widget>[
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
                  labelText: 'Minuites',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (String min) {
                minutes = min;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Heart-Rate',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (String ht) {
                heartrate = ht;
              },
            ),
          ),
          Row(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Distance',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (String dist) {
                distance = dist;
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
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
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
                  // isvalue();
                  // writeUserData(userDate, userDistance, userCalories);
                },
              ),
              // RaisedButton(
              //   color: Colors.blue,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(16)),
              //   child: Text("Read"),
              //   textColor: Colors.white,
              //   onPressed: () {
              //     readData();
              //   },
              // ),
              // RaisedButton(
              //   color: Colors.blue,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(16)),
              //   child: Text("Update"),
              //   textColor: Colors.white,
              //   onPressed: () {},
              // ),
              // RaisedButton(
              //   color: Colors.blue,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(16)),
              //   child: Text("Delete"),
              //   textColor: Colors.white,
              //   onPressed: () {},
              // )
            ],
          )
        ],
      ),
    );
  }
}
