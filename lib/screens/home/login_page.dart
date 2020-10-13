import 'package:UBT/screens/firebase_services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("University of Bayreuth"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "UBT-LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                SizedBox(height: size.height * 0.03),
                TextFormField(
                  obscureText: false,
                  validator: EmailValidator.validate,
                  controller: emailController,
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                TextFormField(
                  validator: PassValidator.validate,
                  controller: passwordController,
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),

                // RoundedInputField(
                //   hintText: "Your Email",
                //   onChanged: (value) {},
                // ),
                // RoundedPasswordField(
                //   onChanged: (value) {},
                // ),
                SizedBox(height: size.height * 0.03),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  elevation: 5.0,
                  onPressed: () {
                    context.read<AuthenticationService>().signIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                  },
                  child: Text(
                    "Sign in",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.40,
                  child: Image.asset('assets/images/ubt.png'),
                ),

                // AlreadyHaveAnAccountCheck(
                //   login: true,
                //   press: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) {
                //           return SignUpScreen();
                //         },
                //       ),
                //     );
                //   },
                // ),
                // RoundedButton(
                //   text: "SIGN UP",
                //   textColor: Colors.black,
                //   press: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) {
                //           return SignUpScreen();
                //         },
                //       ),
                //     );
                //   },
                // ),
                // Positioned(
                //   bottom: 0,
                //   right: 0,
                //   child: Image.asset(
                //     "assets/ubt.png",
                //     width: size.width * 0.4,
                //   ),
                // ),
              ],
            ),
          ),
        ));
  }
}
