import 'package:UBT/Utils/CaloriesCalculator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Weekprogress extends StatefulWidget {
  @override
  _WeekprogressState createState() => _WeekprogressState();
}

class _WeekprogressState extends State<Weekprogress> {
  String userUID;
  final uploadAuth = FirebaseAuth.instance.currentUser.uid;
  String pace;

  Query _ref;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child(uploadAuth);
  }

  Widget _buildUseritem({Map userdata}) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
                height: 30,
              ),
              Text(
                userdata['Date'.toString()],
                style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 22,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                userdata['Distance'.toString()],
                style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 22,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                userdata['Minutes'.toString()],
                style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 22,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                userdata['Calories'.toString()],
                style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 22,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                userdata['Calories'.toString()],
                style: TextStyle(
                    color: Colors.green[900],
                    fontSize: 22,
                    fontWeight: FontWeight.w800),
              ),
            ],
          )
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
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
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
                width: 30,
              ),
              Text('Distance'),
              SizedBox(
                width: 30,
              ),
              Text('Minutes'),
              SizedBox(
                width: 30,
              ),
              Text('Distance/Min'),
              SizedBox(
                width: 30,
              ),
              Text('Score'),
            ],
          ),
          Expanded(
              child: Container(
                  child: Center(
                    child: FirebaseAnimatedList(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.only(bottom: 20),
                        query: _ref,
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          // position:
                          // animation.drive(_offset);
                          Map userdata = snapshot.value;

                          return _buildUseritem(userdata: userdata);
                        }),
                  ),
                  color: Colors.white))
        ],
      ),
    );
  }
}

//  Container(
//           child: Center(
//             child: FirebaseAnimatedList(
//                 scrollDirection: Axis.vertical,
//                 padding: const EdgeInsets.only(bottom: 20),
//                 query: _ref,
//                 itemBuilder: (BuildContext context, DataSnapshot snapshot,
//                     Animation<double> animation, int index) {
//                   // position:
//                   // animation.drive(_offset);
//                   Map userdata = snapshot.value;

//                   return _buildUseritem(userdata: userdata);
//                 }),
//           ),
//           color: Colors.white)
