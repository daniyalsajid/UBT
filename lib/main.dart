import 'dart:io' show Platform;

import 'package:UBT/states/progress_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:UBT/screens/firebase_services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:UBT/screens/home/login_page.dart';
import 'package:UBT/screens/home/home_screen.dart';

/// [MAIN FUNCTION] The entrance function of an application
void main() async {
  /// Returns an instance of the [WidgetsBinding], creating and
  /// initializing it if necessary. If one is created, it will be a
  /// [WidgetsFlutterBinding]. If one was previously initialized, then
  /// it will at least implement [WidgetsBinding].
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase initialization
  await Firebase.initializeApp();

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

  ///[RunApp] its takes the root widget to create UI
  runApp(MyApp());
  // });
}

/// Root Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///Wrapping up the [Material App] into [MultiProvider] for State Management
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

///[AuthenticationWrapper] class ensures that which screen will render
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
        } else {
          return SizedBox();
        }
      },
    );
  }
}
