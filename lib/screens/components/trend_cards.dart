import 'package:flutter/material.dart';

class TrendCards extends StatelessWidget {
  final Icon icons;
  final String title;
  final String value;
  final String description;
  final Icon icon;
  const TrendCards(
      {Key key,
      this.icons,
      this.title = "",
      this.value = "",
      this.description = "",
      this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        decoration: new BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icons != null ? icons : Icon(Icons.trending_down),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Icon(Icons.navigation),
            // ),
            Text(
              title,
              style: TextStyle(
                  height: 1, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              value,
              style: TextStyle(
                  height: 1, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            icon != null ? icon : Icon(Icons.trending_flat),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(description),
            ),
          ],
        ));
  }
}
