// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:UBT/screens/progress_screens/progress_chart.dart';

// import 'package:intl/intl.dart';
// import 'package:flutter/services.dart';
// import 'dart:math';

// class Userdata extends StatefulWidget {
//   @override
//   _UserdataState createState() => _UserdataState();
// }

// class _UserdataState extends State<Userdata> {
//   String userUID;
//   //y axis
//   List graphlists = [];
//   // x axis
//   List d = [];
//   // var lists;
//   // var d;
//   int len;
//   double s; //score
//   // C for rounding score values
//   int c;

//   Map abc;
//   var valuesList, keysList;
//   final uploadAuth = FirebaseAuth.instance.currentUser.uid;
//   // List<Map> lists = [];
//   Item selectedUser;
//   List<Item> users = <Item>[
//     const Item(
//         'Jan',
//         Icon(
//           Icons.calendar_today_rounded,
//           color: const Color(0xFF167F67),
//         )),
//     const Item(
//         'Feb',
//         Icon(
//           Icons.calendar_today_rounded,
//           color: const Color(0xFF167F67),
//         )),
//     const Item(
//         'Mar',
//         Icon(
//           Icons.calendar_today_rounded,
//           color: const Color(0xFF167F67),
//         )),
//     const Item(
//         'Apr',
//         Icon(
//           Icons.calendar_today_rounded,
//           color: const Color(0xFF167F67),
//         )),
//     const Item(
//         'May',
//         Icon(
//           Icons.calendar_today_rounded,
//           color: const Color(0xFF167F67),
//         )),
//     const Item(
//         'Jun',
//         Icon(
//           Icons.calendar_today_rounded,
//           color: const Color(0xFF167F67),
//         )),
//     const Item(
//         'Jul',
//         Icon(
//           Icons.calendar_today_rounded,
//           color: const Color(0xFF167F67),
//         )),
//     const Item(
//         'Aug',
//         Icon(
//           Icons.calendar_today_rounded,
//           color: const Color(0xFF167F67),
//         )),
//     const Item(
//         'Sep',
//         Icon(
//           Icons.calendar_today_rounded,
//           color: const Color(0xFF167F67),
//         )),
//     const Item(
//         'Oct',
//         Icon(
//           Icons.calendar_today_rounded,
//           color: const Color(0xFF167F67),
//         )),
//     const Item(
//         'Nov',
//         Icon(
//           Icons.calendar_today_rounded,
//           color: const Color(0xFF167F67),
//         )),
//     const Item(
//         'Dec',
//         Icon(
//           Icons.calendar_today_rounded,
//           color: const Color(0xFF167F67),
//         )),
//   ];

//   Query _ref;

//   @override
//   void initState() {
//     super.initState();
//     // readData();
//     _ref = FirebaseDatabase.instance.reference().child(uploadAuth);
//   }

//   // Future<List> readData() async {
//   // final databaseReference = FirebaseDatabase.instance.reference();
//   // Map<dynamic, dynamic> map;
//   // await databaseReference
//   //     .child(uploadAuth)
//   //     .child('2020')
//   //     .child('10')
//   //     .once()
//   //     .then((DataSnapshot snapshot) {
//   //   map = snapshot.value;
//   // });

//   Future<List> getData() async {
//     final databaseReference = FirebaseDatabase.instance.reference();
//     _ref = FirebaseDatabase.instance.reference().child(uploadAuth);
//     Map<dynamic, dynamic> map;
//     await databaseReference
//         .child(uploadAuth)
//         .child('2020')
//         .child('10')
//         .once()
//         .then((DataSnapshot snapshot) {
//       map = snapshot.value;
//     });

//     // List lists = [];
//     // List d = [];
//     // int len;
//     // double s; //score
//     // Map abc;
//     databaseReference
//       ..child(uploadAuth)
//           .child('2020')
//           .child('10')
//           .once()
//           .then((DataSnapshot snapshot) {
//         //print('Data : ${snapshot.value}');
//         abc = snapshot.value;
//         // print(abc);
//         len = (snapshot.value.length);
//         keysList = abc.keys.toList();
//         d.clear();
//         graphlists.clear();
//         for (int i = 0; i < len; i++) {
//           s = (abc[keysList[i]]['Score']);
//           c = s.truncate();

//           d.add(keysList[i]);
//           graphlists.add(c);
//         }
//         return Container();

//         // print(d);
//         // return _ref;
//       });
//   }

//   // getData();

//   // keysList = map.keys.toList();
//   // valuesList = map.values.toList();
//   // return keysList;
//   // return null;
//   // }

//   List<charts.Series<LinearSales, int>> _createSampleData(lists, d) {
//     final data = [
//       // for (var i = 0; i < lists.length; i++)
//       //   {
//       //     new LinearSales(int.parse(d[i]), int.parse(lists[i].toString())),
//       //   }
//       // new LinearSales(int.parse(d[0]), int.parse(lists[0].toString())),
//       new LinearSales(int.parse(d[1]), int.parse(lists[1].toString())),

//       new LinearSales(int.parse(d[2]), int.parse(lists[2].toString())),
//       new LinearSales(int.parse(d[3]), int.parse(lists[3].toString())),
//       new LinearSales(int.parse(d[4]), int.parse(lists[4].toString())),
//       new LinearSales(int.parse(d[5]), int.parse(lists[5].toString())),
//       new LinearSales(int.parse(d[6]), int.parse(lists[6].toString())),

//       new LinearSales(int.parse(d[7]), int.parse(lists[7].toString())),
//       new LinearSales(int.parse(d[8]), int.parse(lists[8].toString())),
//       new LinearSales(int.parse(d[9]), int.parse(lists[9].toString())),
//       new LinearSales(int.parse(d[10]), int.parse(lists[10].toString())),
//       new LinearSales(int.parse(d[11]), int.parse(lists[11].toString())),

//       new LinearSales(int.parse(d[12]), int.parse(lists[12].toString())),
//       new LinearSales(int.parse(d[13]), int.parse(lists[13].toString())),
//     ];

//     return [
//       new charts.Series<LinearSales, int>(
//         id: 'Sales',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         fillColorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
//         domainFn: (LinearSales sales, _) => sales.year,
//         measureFn: (LinearSales sales, _) => sales.sales,
//         data: data,
//       )
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getData(),
//         builder: (ctx, snapshot) {
//           return Scaffold(
//               appBar: AppBar(
//                 title: Text('Progress Screen'),
//                 centerTitle: true,
//                 backgroundColor: Colors.green,
//               ),
//               body: Column(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 10,
//                         height: 10,
//                       ),
//                       // Text(
//                       //   'Month Progress',
//                       //   textAlign: TextAlign.center,
//                       //   style: TextStyle(
//                       //     fontSize: 24,
//                       //     fontWeight: FontWeight.bold,
//                       //   ),
//                       // ),
//                       DropdownButton(
//                         hint: Text(' Month'),
//                         value: selectedUser,
//                         onChanged: (Item value) {
//                           setState(() {
//                             selectedUser = value;
//                             String m = selectedUser.name;

//                             switch (m) {
//                               case 'Jan':
//                                 {}
//                                 break;
//                             }
//                           });
//                         },
//                         items: users.map((Item user) {
//                           return DropdownMenuItem<Item>(
//                             value: user,

//                             // Row to Cloumn
//                             child: Row(
//                               children: <Widget>[
//                                 user.icon,
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text(
//                                   user.name,
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Column(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.green)),
//                             child: Title(
//                                 color: Colors.blue,
//                                 child: SizedBox(
//                                   width: 380,
//                                   height: 300,
//                                   child: PointsLineChart(
//                                       _createSampleData(graphlists, keysList)),
//                                 )),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.green)),
//                         child: SizedBox(
//                           width: 380,
//                           height: 225,
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     'What is your goal?',
//                                     style: TextStyle(
//                                         height: 1.5,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 22),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     'Think of a certain distance that you would \n like to run in a certain time, \n in one or two months fom now?',
//                                     textAlign: TextAlign.center,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                         height: 1,
//                                         // fontWeight: FontWeight.bold,
//                                         fontSize: 18),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [Text('Hi')],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ));
//         });
//   }
// }

// class Item {
//   const Item(this.name, this.icon);
//   final String name;
//   final Icon icon;
// }
