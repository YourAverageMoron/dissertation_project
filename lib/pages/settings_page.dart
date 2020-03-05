import 'package:dissertation_project/widgets/scaled_application_editor.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  //TODO Scaled score times
  //TODO Link to the settings page for turning on application tracking stuff
  //Look at the app_usage api to find how to do this

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(children: <Widget>[
        Card(
          child: Padding(
            padding: EdgeInsets.only(
                top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
            child: ExpansionTile(
              title: Text('Applications that scale your score'),
              children: <Widget>[
                ScaledApplicationEditor(),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
