// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Weekprogress extends StatefulWidget {
//   @override
//   _WeekprogressState createState() => _WeekprogressState();
// }

// class _WeekprogressState extends State<Weekprogress> {
//   String userUID;
//   final uploadAuth = FirebaseAuth.instance.currentUser.uid;

//   Query _ref;

//   @override
//   void initState() {
//     super.initState();
//     _ref = FirebaseDatabase.instance.reference().child(uploadAuth);
//   }

//   Widget _buildUseritem({Map userdata}) {
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               SizedBox(
//                 width: 30,
//               ),
//               Text(
//                 userdata['Date'],
//                 style:
//                     TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               Text(
//                 userdata['Distance'],
//                 style:
//                     TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               Text(
//                 userdata['Minutes'],
//                 style:
//                     TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Row(
//   //           mainAxisAlignment: MainAxisAlignment.spaceAround,
//   //           children: [
//   //             Row(
//   //               children: [
//   // Icon(
//   //   Icons.date_range_rounded,
//   //   color: Theme.of(context).primaryColor,
//   //   size: 50,
//   // ),
//   // Icon(
//   //   Icons.add_road,
//   //   color: Theme.of(context).primaryColor,
//   // ),
//   // Icon(
//   //   Icons.access_time,
//   //   color: Theme.of(context).primaryColor,
//   // ),
//   //               ],
//   //             ),
//   //           ],
//   //         )
//   // Tween<Offset> _offset = Tween(begin: Offset(0, 0), end: Offset(0, 0));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Deine Aktivitaten'),
//           backgroundColor: Colors.green,
//           centerTitle: true,
//         ),
//         body: Column(
//           children: <Widget>[
//   Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Align(
//           alignment: Alignment.centerLeft,
//           child: Icon(
//             Icons.date_range_rounded,
//             size: 60,
//           )),
//       Align(
//           alignment: Alignment.center,
//           child: Icon(
//             Icons.trending_up_outlined,
//             size: 60,
//           )),
//       Align(
//           alignment: Alignment.center,
//           child: Icon(
//             Icons.access_time,
//             size: 60,
//           )),
//       Align(
//           alignment: Alignment.center,
//           child: Icon(
//             Icons.speed_rounded,
//             size: 60,
//           )),
//       Align(
//           alignment: Alignment.centerRight,
//           child: Icon(
//             Icons.score_outlined,
//             size: 60,
//           )),
//     ],
//   ),
//   Expanded(
//     child: FirebaseAnimatedList(
//         query: _ref,
//         itemBuilder: (BuildContext context, DataSnapshot snapshot,
//             Animation<double> animation, int index) {
//           // position:
//           // animation.drive(_offset);
//           Map userdata = snapshot.value;

//           return _buildUseritem(userdata: userdata);
//         }),
//   )
// ],
//         )

//         // Container( //to put aginst child runing
//         //   height: double.infinity,
//         //   child: FirebaseAnimatedList(
//         //       query: _ref,
//         //       itemBuilder: (BuildContext context, DataSnapshot snapshot,
//         //           Animation<double> animation, int index) {
//         //         // position:
//         //         // animation.drive(_offset);
//         //         Map userdata = snapshot.value;

//         //         return _buildUseritem(userdata: userdata);
//         //       }),
//         // ),

//         // floatingActionButton: FloatingActionButton(
//         //   onPressed: () {},
//         );
//   }
// }
