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
            RaisedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Text("Sign out"),
            ),
          ],
        )),
      ),
    );
  }
}
