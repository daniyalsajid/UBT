import 'package:flutter/material.dart';
import 'package:UBT/screens/components/already_have_an_account_acheck.dart';
import 'package:UBT/screens/home//login_page.dart';
import 'package:provider/provider.dart';
import 'package:UBT/screens/firebase_services/authentication_service.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String _error;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height * 0.03,
            ),
            showAlert(),
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            SizedBox(height: size.height * 0.03),
            TextFormField(
              validator: EmailValidator.validate,
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
            ),
            TextFormField(
              validator: PassValidator.validate,
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
            ),
            RaisedButton(
              onPressed: () {
                context.read<AuthenticationService>().signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
              },
              child: Text("Sign Up"),
            ),
            // RoundedButton(
            //   text: "SIGNUP",
            //   press: () {},
            // ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignInPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}
