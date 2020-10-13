import 'package:flutter/material.dart';
import 'package:UBT/screens/firebase_services/authentication_service.dart';
import 'package:provider/provider.dart';

import 'package:firebase_database/firebase_database.dart';

class Userdata extends StatefulWidget {
  @override
  _UserdataState createState() => _UserdataState();
}

class _UserdataState extends State<Userdata> {
  final TextEditingController distance = TextEditingController();
  final TextEditingController calories = TextEditingController();
  final TextEditingController minutes = TextEditingController();
  final mainReference = FirebaseDatabase.instance.reference();
  DateTime dateTime;
  String note;

  adddata() {
    return {
      "distance": distance,
      'calories': calories,
      'minutes': minutes,
      // 'date': dateTime.millisecondsSinceEpoch,
      'note': note
    };
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Progress'),
        // backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'UBT-Running Manual Data Enrty',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.03),
              TextField(
                controller: distance,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Distance",
                ),
              ),
              TextField(
                controller: calories,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Calories",
                ),
              ),
              TextField(
                controller: minutes,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Minutes",
                ),
              ),
              // TextField(
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: "pace",
              //   ),
              // ),
              RaisedButton(
                  onPressed: () {
                    mainReference
                        .push()
                        .set(MapEntry('ubt-running', adddata()));
                  },
                  child: Text('Save data')),
              RaisedButton(
                onPressed: () {
                  context.read<AuthenticationService>().signOut();
                },
                child: Text("Sign out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
