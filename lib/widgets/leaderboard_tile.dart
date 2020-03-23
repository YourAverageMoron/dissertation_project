import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaderboardTile extends StatelessWidget {
  final String name;
  final String value;
  final IconData icon;


  LeaderboardTile({this.value, this.name, this.icon});

  /*
    TODO https://pub.dev/packages/koukicons
    Get some decent icons that can be used
    TODO MAYBE USE FLUTTER AVATAR https://api.flutter.dev/flutter/material/CircleAvatar-class.html
   */
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(
          value,
          textScaleFactor: 2,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          //TODO this is a bit of a grim way of positioning (is there a better approach?)
          children: <Widget>[
            Icon(icon,
              color: Colors.deepOrange,
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(name))
          ],
        ),
        trailing: Text(value,
          textScaleFactor: 1.5,)
      ),
    );
  }
}
