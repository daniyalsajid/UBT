import 'package:firebase_database/firebase_database.dart';
import 'package:UBT/states/progress_screen_provider.dart';
import 'package:provider/provider.dart';
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
  var providerProgressScreen;
  double pace, percentmax, vo2, score, distance, height;

  String minutes;
  double totalminuites;

  DateTime mydate = DateTime.now();
  // String userDistance;

  String userUID;
  final uploadAuth = FirebaseAuth.instance.currentUser.uid;

  getUserUID(firebaseAuth) {
    this.userUID = firebaseAuth.UserUID;
  }

  @override
  void initState() {
    super.initState();
    // readData();
    providerProgressScreen =
        Provider.of<ProgressScreenProvider>(context, listen: false);
  }

//RealtimeDatabase
  createData1() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(mydate);
    int day = int.parse(DateFormat('d').format(mydate));
    int month = int.parse(DateFormat('M').format(mydate));
    int year = int.parse(DateFormat('y').format(mydate));
    // double pace, percentmax, vo2, score, distance;
    pace = (totalminuites / distance);
    // int.parse(distance.toString()));
    percentmax = (0.8 +
        0.1894393 * (exp(-0.012778 * totalminuites)) +
        0.2989558 * (exp(-0.1932605 * totalminuites)));

    vo2 = ((-4.60 +
            0.182258 *
                (distance *

                    // (int.parse(distance.toString()) *
                    1000 /
                    totalminuites)) +
        0.000104 *
            pow(
                distance *

                    // int.parse(distance.toString()) *
                    1000 /
                    totalminuites,
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
            // width: 30.0,
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

        // // You get your duration here
        Duration _duration = Duration(
          hours: picker.getSelectedValues()[0],
          minutes: picker.getSelectedValues()[1],
        );
        int hoursnew = num.parse(hours1.toString().substring(0, 1)) * 60;

        int minutesnew = num.parse(minutes1.toString().substring(2, 4));
        // int secondsnew = num.parse(seconds1.toString().substring(5, 6)) ~/ 60;

        String timeForShow =
            "0${picker.getSelectedValues()[0]}:${picker.getSelectedValues()[1].toString().length > 1 ? picker.getSelectedValues()[1] : (0.toString() + picker.getSelectedValues()[1].toString())}:${picker.getSelectedValues()[2].toString().length > 1 ? picker.getSelectedValues()[2] : (0.toString() + picker.getSelectedValues()[2].toString())}";
        // int hoursnew =
        //     num.parse((picker.getSelectedValues()[1] * 60).toString());

        // int minutesnew = num.parse(picker.getSelectedValues()[1].toString());

        double seconds =
            num.parse((picker.getSelectedValues()[2] / 60).toStringAsFixed(2));

        setState(() {
          totalminuites = (hoursnew + minutesnew).toDouble() + seconds;
        });

        // totalminuites = (hoursnew + minutesnew + seconds).toDouble();

        providerProgressScreen.setTotalHourAndMinutes(timeForShow);
      },
    ).showDialog(context);
  }

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
            // Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Text('Total Minutes: $totalminuites'),
            // ),

            Consumer<ProgressScreenProvider>(
                builder: (context, consumer, childWidget) {
              return Row(
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
                        consumer.totalHourWithMinutes == null
                            ? "SELECT Minutes ".toUpperCase()
                            : consumer.totalHourWithMinutes,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.green,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          onTap();
                          // print(totalminuites);
                        });
                      },
                    ),
                  ),
                ],
              );
            }),
            DateTimeField(
              label: 'Datum',
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
                    labelText: 'Distanz',
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
                    labelText: 'Höhenunterschied',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.green, width: 2.0))),
                onChanged: (String hight) {
                  height = double.parse(hight);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Kalorien',
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
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Herzfrequenz',
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.green, width: 2.0))),
                onChanged: (String ht) {
                  heartrate = ht;
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
                  child: Text("erstellen"),
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
