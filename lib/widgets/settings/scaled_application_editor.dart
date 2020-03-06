import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> items = List<String>.generate(5, (i) => "Item $i");

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
    // MAP THAT LIST USING PACKAGE INFO TO GET IMAGE AND APP NAME
    // PASS THAT MAPPED LIST INTO EditScaledApplicationCard if scale factor != 1
  @override
  Widget build(BuildContext context) {

    //TODO LISTVIEW BUILDER? -> LOOK AT THE LEADERBOARD
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[
        EditScaledApplicationCard("package","Instagram",0.5),
        EditScaledApplicationCard("package","Twitter",0.5),
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

  EditScaledApplicationCard(String packageName, String applicationName,
      double scaleFactor){
    _packageName = packageName;
    _applicationName = applicationName;
    _scaleFactor = scaleFactor;
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
      //TODO IT WILL NEED A BUTTON TO REMOVE
    ));
  }
}