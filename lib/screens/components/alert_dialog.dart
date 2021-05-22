import 'package:flutter/material.dart';

// Custom Alert Dialog Component for showing dialog in all over the application
class CustomAlertDialog {
  static showDialogPopup({
    @required BuildContext context,
    @required String text,
    String text2 = "",
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(children: [
          Text(
            text,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(height: 1.2, fontSize: 18),
          ),
          Text(
            text2,
            textAlign: TextAlign.center,
            style: TextStyle(height: 1.2, fontSize: 18),
          ),
        ]);
      },
    );
  }
}
