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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                  child: Text(
                    'Wir wollen dich dabei unterstützen \n regelmäßig körperlich aktiv zu sein.\n Indem wir deine Lauf-Aktivitätsdaten in \n einer für dich interessanten \n und wertvollen Weise darstellen \n und dir  nützliche Features bieten, hoffen wir dir \n eine kleine Motivationshilfe sein zu \n können.',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        height: 1,
                        fontSize: 18,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
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
