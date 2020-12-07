import 'dart:io' show Platform;

import 'package:UBT/states/progress_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:UBT/screens/firebase_services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:UBT/screens/home/login_page.dart';
import 'package:UBT/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // print(Platform.isWindows);
  // await Firebase.initializeApp(
  //         name: "ubt",
  //         options: FirebaseOptions(
  //             apiKey: "AIzaSyAxpUpSzD0ROvWiZ3i0Bj1UiPszklhB9g4",
  //             authDomain: "ubt-running.firebaseapp.com",
  //             databaseURL: "https://ubt-running.firebaseio.com",
  //             projectId: "ubt-running",
  //             storageBucket: "ubt-running.appspot.com",
  //             messagingSenderId: "538243409391",
  //             appId: "1:538243409391:web:3d97947d99e59b7411c21a",
  //             measurementId: "G-K5JB1BYW35"))
  //     .then((value) {
  //   print(value);
  //   return
  runApp(MyApp());
  // });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
        ChangeNotifierProvider(
          create: (_) => ProgressScreenProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'UBT-Running',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            firebaseUser != null) {
          return HomeScreen();
        } else if (snapshot.hasError) {
          return SignInPage();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (firebaseUser == null &&
            snapshot.connectionState == ConnectionState.done) {
          return SignInPage();
        }
      },
    );
  }
}
