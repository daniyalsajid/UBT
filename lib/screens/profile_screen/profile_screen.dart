import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:UBT/screens/firebase_services/authentication_service.dart';
// import 'package:UBT/screens/progress/progress_screen.dart';
// import 'package:UBT/screens/progress/WeekReportSubPage.dart';
// import 'package:UBT/screens/progress_screens/user_entry.dart';
// import 'package:UBT/screens/progress_screens/graph_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: Column(
                children: [
                  Text(
                    'Egal ob Du ein ambitioniertes Ziel verfolgst\n oder läufst, um einen Ausgleich zu haben sowie\n aktiv zu sein, wir wollen Dir zeigen,\n dass es sich lohnt regelmäßig laufen zu gehen\n.Wie? Indem wir dir zeigen, \ndass dein Körper sich an deine Anstrengungen anpasst und mit dir wächst\n - ganz egal ob Du ans Limit gehst oder nach\n einem stressigen Tag den Kopf frei kriegen willst.',
                    textAlign: TextAlign.center,
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        height: 1,
                        fontSize: 18,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(150, 150, 0, 0),
                  child: RaisedButton(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    onPressed: () {
                      context.read<AuthenticationService>().signOut();
                    },
                    child: Text(
                      "Sign out",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
