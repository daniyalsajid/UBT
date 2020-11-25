import 'package:UBT/states/progress_screen_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:UBT/screens/progress_screens/progress_chart.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:provider/provider.dart';
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
  double totalminuites;
  int totaldistance;
  double distance;
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
  var providerProgressScreen;
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
    providerProgressScreen =
        Provider.of<ProgressScreenProvider>(context, listen: false);
    _ref = FirebaseDatabase.instance.reference().child(uploadAuth);

    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    monthnow = formatter.format(now);
    // print(monthnow);
  }

  createData1() {
    double percentmax, vo2;

    percentmax = (0.8 +
        0.1894393 * (exp(-0.012778 * totalminuites)) +
        0.2989558 * (exp(-0.1932605 * totalminuites)));

    vo2 = ((-4.60 +
            0.182258 *
                (totaldistance *

                    // (int.parse(totaldistance.toString()) *
                    1000 /
                    totalminuites)) +
        0.000104 * pow(totaldistance * 1000 / totalminuites, 2));

    setState(() {
      score = vo2 / percentmax;
    });

    providerProgressScreen.setScoreAndGoalToAchieve(score);
    // return score;
  }

  Widget onTab() {
    Picker(
      adapter: NumberPickerAdapter(data: <NumberPickerColumn>[
        const NumberPickerColumn(begin: 1, end: 42, suffix: Text(' Km')),
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

        // String a = picker.getSelectedValues()[0].toString();
        totaldistance = num.parse(picker.getSelectedValues()[0].toString());
        providerProgressScreen.setTotalDistance(totaldistance);
      },
    ).showDialog(context);
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
        } catch (_) {
          date = ["0"];
          score = [0];
          print(uploadAuth);
        }

        setState(() {
          graphlists = date;
          keysList = score;
          d = score;
        });

        return PointsLineChart(_createSampleData(d, graphlists));
      });
  }

  List<charts.Series<LinearSales, int>> _createSampleData(date, score) {
    List<LinearSales> data = [];
    if (score.length != 0 && date.length != 0) {
      for (var i = 0; i < score.length; i++) {
        data.add(new LinearSales(
          int.parse(date[i].toString()),
          int.parse(score[i].toString()),
        ));
      }
    } else {
      data.add(new LinearSales(0, 0));
    }

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

  Future<void> openDialog() async {
    switch (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
            // title: const Text(
            //   'Hi',
            //   textAlign: TextAlign.center,
            // ),
            children: [
              Text(
                'Willst Du in absehbarer Zeit \n eine konkrete Strecke in einer \n bestimmten Zeit laufen?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.5, fontWeight: FontWeight.w400, fontSize: 18),
              ),
              Text(
                "Hast du kein konkretes Ziel eine \n bestimmte Zeit laufen zu wollen,\n aber eine Idee über eine persönliche\n virtuelle Marke (Distanz / Zeit),\n die Du ab und an herausfordern willst?",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    height: 1.5,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ]);
      },
    )) {
    }
  }

  Future<void> openDialog1() async {
    switch (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
            // title: const Text(
            //   'Hi',
            //   textAlign: TextAlign.center,
            // ),
            children: [
              Text(
                'Egal ob Du ein ambitioniertes \nZiel verfolgst oder läufst,\n um einen Ausgleich zu haben\n sowie aktiv zu sein,\n wir wollen Dir zeigen,\n dass es sich lohnt regelmäßig\n laufen zu gehen.',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    height: 1.2,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                "Wie? Indem wir dir zeigen\ndass dein Körper sich an deine\n Anstrengungen anpasst und\n mit dir wächst - ganz egal ob\n Du ans Limit gehst oder nach\n einem stressigen Tag den\n Kopf frei kriegen willst.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ]);
      },
    )) {
    }
  }

  Future<void> openDialog2() async {
    switch (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
            // title: const Text(
            //   'Hi',
            //   textAlign: TextAlign.center,
            // ),
            children: [
              Text(
                'In Abhängigkeit von der Distanz \nund der Dauer variiert dein Score\n je Aktivität. Wenn Du eine gleiche\n Strecke in kürzerer Zeit läufst,\n steigt der Score. Zum Beispiel\n wäre der Score für 10 km\n in 55 Minuten 35,7 - für 10 km\n in 50 Minuten 40. ',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    height: 1.2,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                "Die Berechnung berücksichtigt aber auch, dass es für eine längere Strecke schwieriger ist die gleiche Pace zu laufen. Für 5 km in 27:30 Minuten (gleiche Pace wie 55 Minuten in 10 km) wäre der Score 34,2 - der Score steigt also um 1,5 Punkte, weil Du die Pace über einen längeren Zeitraum halten konntest.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.2,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ]);
      },
    )) {
    }
  }

  Future<void> openDialog3() async {
    switch (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
            // title: const Text(
            //   'Hi',
            //   textAlign: TextAlign.center,
            // ),
            children: [
              Text(
                'Mit deinem Zielwert kannst \nDu überprüfen, wie Du dich \n bezüglich einer gewünschten Leistung\n oder virtuellen Marke entwickelst\n und Du kannst dich für einzelne\n Aktivitäten herausfordern diese Marke\n zu erreichen.',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    height: 1.2,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ]);
      },
    )) {
    }
  }

  Future<void> openDialog4() async {
    switch (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
            // title: const Text(
            //   'Hi',
            //   textAlign: TextAlign.center,
            // ),
            children: [
              Text(
                'Der Score ermöglicht es dir\nAktivitäten mit unterschiedlichen\n Distanzen und Geschwindigkeiten\n zu vergleichen\ und\n deine Entwicklung zu \nverfolgen. Oft ist es dir \nvielleicht gar nicht bewusst,\n welche Auswirkungen das regelmäßige\n Laufen gehen auf deinen Körper\n hat und welche großartigen Scores Du\n bereits erzielt hast.\n Ziel es nicht, in jeder Aktivität einen\n besseren Score zu erzielen.',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    height: 1.2,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                'Ganz wie im Spitzensport auch\n kannst Du nicht in jedem Training\n einen neuen Weltrekord aufstellen.\n Aber gelegentliche\n individuelle Spitzenleistungen\n (hohe Scores) zeigen dir,\n dass sich dein Körper mit\n dir entwickelt\n und langfristig zahlen sich\n deine Anstrengungen aus.',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    height: 1.2,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ]);
      },
    )) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Progress Screen'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
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
                      IconButton(
                        alignment: Alignment.topRight,
                        icon: Icon(Icons.info_outline),
                        color: Colors.green,
                        tooltip: 'Graph Info',
                        onPressed: () {
                          openDialog3();
                        },
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
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green)),
                      child: PointsLineChart(_createSampleData(
                        graphlists,
                        d,
                      )),
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ' Setze eine virtuelle Marke',
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                IconButton(
                                  icon: Icon(Icons.info_outline),
                                  color: Colors.green,
                                  tooltip: 'More Info',
                                  onPressed: () {
                                    openDialog();
                                  },

                                  //   return SimpleDialog(
                                  //     title: const Text('Select assignment'),
                                  //     children: [
                                  //       Text(
                                  //         'Think of a certain distance that you would \n like to run in a certain time, \n in one or two months fom now?',
                                  //         textAlign: TextAlign.center,
                                  //         overflow: TextOverflow.ellipsis,
                                  //         style: TextStyle(
                                  //             height: 1,
                                  //             // fontWeight: FontWeight.bold,
                                  //             fontSize: 18),
                                  //       ),
                                  //     ],
                                  //   );
                                  // },
                                ),

                                // Text('Volume : $_volume')
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       '  ',
                            //       style: TextStyle(
                            //           height: 1.5,
                            //           fontWeight: FontWeight.normal,
                            //           fontSize: 18),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            Consumer<ProgressScreenProvider>(
                                builder: (context, consumer, childWidget) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: RaisedButton(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        child: Text(
                                          consumer.totaldistance == null
                                              ? "Distanz auswählen"
                                                  .toUpperCase()
                                              : consumer.totaldistance
                                                      .toString() +
                                                  " Km",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.green,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            onTab();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: RaisedButton(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        child: Text(
                                          consumer.totalHourWithMinutes == null
                                              ? "Zeit auswählen $totalminuites"
                                                  .toUpperCase()
                                              : consumer.totalHourWithMinutes,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.green,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            onTap();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RaisedButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Consumer<ProgressScreenProvider>(
                                      builder:
                                          (context, consumer, childWidget) {
                                    return Row(
                                      children: [
                                        Text(
                                          consumer.score != null &&
                                                  consumer.score.isFinite
                                              ? "Score: ${consumer.score.toStringAsFixed(2)}"
                                                  .toUpperCase()
                                              : "Score berechnen",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                  onPressed: () {
                                    createData1();
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.info_outline),
                                  color: Colors.green,
                                  tooltip: 'More Info',
                                  onPressed: () {
                                    openDialog2();
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text(
                    //   ' Egal ob Du ein ambitioniertes Ziel verfolgst\n oder läufst, um einen Ausgleich zu haben \nsowie aktiv zu sein, wir wollen Dir zeigen,\n dass es sich lohnt regelmäßig laufen zu gehen.  ',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //       height: 1.2,
                    //       fontWeight: FontWeight.normal,
                    //       fontSize: 18),
                    // ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text(
                    //   ' Wie? Indem wir dir zeigen, dass dein Körper \n sich an deine Anstrengungen anpasst \nund mit dir wächst - ganz egal\n ob Du ans Limit gehst oder nach einem\n stressigen Tag den Kopf frei kriegen willst.',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //       height: 1.2,
                    //       fontWeight: FontWeight.w300,
                    //       fontSize: 18),
                    // ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' Unsere Vision',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    IconButton(
                      icon: Icon(Icons.info_outline),
                      color: Colors.green,
                      tooltip: 'More Info',
                      onPressed: () {
                        openDialog1();
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Wie kannst Du den Score nutzen',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    IconButton(
                      icon: Icon(Icons.info_outline),
                      color: Colors.green,
                      tooltip: 'More Info',
                      onPressed: () {
                        openDialog4();
                      },
                    ),
                  ],
                ),
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
