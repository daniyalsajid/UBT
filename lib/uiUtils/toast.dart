import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///Generic [Toast] for showing messages to the user
showToast({@required String message}) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey,
    textColor: Colors.white,
    fontSize: 16.0);
