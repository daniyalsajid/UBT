import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  String error;

  AuthenticationService(this._firebaseAuth);
  // String uid = '';

  /// Changed to idTokenChanges as it updates depending on more cases.
  ///
  ///
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  // Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges().map((event) => CurrentUser.uid);

  // //Get Id
  // Future<String> getCurrentUID() async {
  //   _
  // }

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  // final form = form.Key.currentState;
  // Future<AuthResultStatus> signIn({String email, String password}) async {
  //   try {
  //     final authResult = await _firebaseAuth.signInWithEmailAndPassword(
  //         email: email, password: password);

  //     if (authResult.user != null) {
  //       _status = AuthResultStatus.successful;
  //     } else {
  //       _status = AuthResultStatus.undefined;
  //     }
  //   } catch (e) {
  //     print('Exception @createAccount: $e');
  //     _status = AuthExceptionHandler.handleException(e);
  //   }
  //   return _status;
  // }

  Future<dynamic> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return {"status": true, "message": "Welcome to UBT"};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return {"status": false, "message": "No user found."};
      } else if (e.code == 'wrong-password') {
        return {"status": false, "message": "Invalid email or password."};
      }
    } catch (e) {
       return {"status": false, "message": "Something went worng."};
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      return e.message;
    }
    return null;
  }
}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Email canot be Empty";
    }
    return null;
  }
}

class PassValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "password canot be Empty";
    }
    return null;
  }
}
