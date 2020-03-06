import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<ScaledApp> scaledApps = [
  ScaledApp("Package", "Instagram", 5),
  ScaledApp("Package", "Medium", 0.4),
  ScaledApp("Package", "Facebook", 2),
  ScaledApp("Package", "Twitter", 3),
];

//TODO COULD MAKE THIS GENERIC?
  //PASS IN TEXT AND INSIDE WIDGET?
class ScaledApplicationEditorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(
            top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text('Applications that scale your score'),
          children: <Widget>[
            DropdownContent(),
          ],
        ),
      ),
    );
  }

}

// TODO Brief description of what these do
// TODO a list of scaled score things => with edit + delete buttons
class DropdownContent extends StatelessWidget {

  //TODO THIS SHOULD USE PACKAGE INFO REPO TO GET ALL INSTALLED APPS AS A LIST
    // Will need to access the shared preferences to find the package names and scores
    // MAP THAT LIST USING PACKAGE INFO TO GET IMAGE AND APP NAME
    // PASS THAT MAPPED LIST INTO EditScaledApplicationCard if scale factor != 1
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView.builder(
          itemCount: scaledApps.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return EditScaledApplicationCard(scaledApps[index]);
          }
        ),
        RaisedButton(
          child: Text("Add a new scaled application"),
          color: Colors.green,
          textColor: Colors.white,
          onPressed: () => print("Add new scaled app popup"),
        ),
      ],
    );
  }
}

class EditScaledApplicationCard extends StatelessWidget {
  //TODO THESE WILL CHANGE, YOU MIGHT WANT TO PASS IN A CALLBACK FOR THE EDIT/DELETE?
  //OR THIS MIGHT BE HANDLED BY BLOC -> ADD EVENT DELETE("INSTAGRAM")
  String _packageName;
  String _applicationName;
  double _scaleFactor;

  EditScaledApplicationCard(ScaledApp scaledApp){
    _packageName = scaledApp.getPackageName();
    _applicationName = scaledApp.getAppName();
    _scaleFactor = scaledApp.getScaleFactor();
  }

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(
      onTap: () => print("bring up edit popup"),
      leading: Icon(Icons.apps),
      title: Text(_applicationName),
      subtitle: Text(_scaleFactor.toString()),
      trailing: IconButton(
        icon: Icon(Icons.remove),
        color: Colors.red,
        onPressed: () { print("Remove"); },
      ),
    ));
  }
}