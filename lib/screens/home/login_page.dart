import 'package:UBT/screens/firebase_services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:owesome_validator/owesome_validator.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInPage extends StatefulWidget {
  // final formKey = new GlobalKey<FormState>();
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  bool loader = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("University of Bayreuth"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKeyLogin,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "UBT-LOGIN",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  SizedBox(height: size.height * 0.03),
                  TextFormField(
                    // key: formKey,
                    validator: (value) {
                      if (!OwesomeValidator.email(
                          value, OwesomeValidator.patternEmail)) {
                        return "Invalid Email";
                      } else {
                        return null;
                      }
                    },
                    controller: emailController,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Email',
                      errorStyle: TextStyle(fontSize: 14.0, color: Colors.red),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  TextFormField(
                    // key: formKey,
                    validator: (value) {
                      if (value == "") {
                        return "Password field can't be empty.";
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                    controller: passwordController,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  loader == false
                      ? MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          // color: Colors.green,
                          elevation: 5.0,
                          onPressed: () async {
                            emailController.text = "daniyalsajid1@gmail.com";
                            passwordController.text = "abc12345.";
                            final FormState form = formKeyLogin.currentState;

                            if (form.validate()) {
                              setState(() {
                                loader = true;
                              });
                              try {
                                var res = await context
                                    .read<AuthenticationService>()
                                    .signIn(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                setState(() {
                                  loader = false;
                                });
                                if (res["status"] == true) {
                                  toast(res);
                                } else {
                                  toast(res);
                                }
                              } catch (_) {
                                setState(() {
                                  loader = false;
                                });
                              }
                            }
                          },
                          child: Text(
                            "Sign In",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        )
                      : CircularProgressIndicator(
                          backgroundColor: Colors.green,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                        ),
                  SizedBox(
                    height: 100.0,
                    child: Image.asset('assets/images/ubt.png'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void toast(res) {
    Fluttertoast.showToast(
        msg: res["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.lightGreen,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
