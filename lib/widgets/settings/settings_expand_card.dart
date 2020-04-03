import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsExpandCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  SettingsExpandCard(
      {@required this.title, this.description = "", @required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text(title),
          children: [
            Container(
              child: Text(description,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey[700])),
            ),
            child
          ],
        ),
      ),
    );
  }
}
