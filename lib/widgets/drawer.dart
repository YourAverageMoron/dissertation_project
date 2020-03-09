import 'package:dissertation_project/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return(
      Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Leaderboard'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, LEADERBOARD);
              },
            ),
            ListTile(
              leading: Icon(Icons.touch_app),
              title: Text('App Usage'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, APPUSAGE);
              },
            ),
            ListTile(
              leading: Icon(Icons.insert_chart),
              title: Text('Statistics'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, STATISTICS);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, SETTINGS);
              },
            ),
          ],
        ),
      )
    );
  }
}