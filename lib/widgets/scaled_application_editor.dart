
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> items = List<String>.generate(5, (i) => "Item $i");

// TODO Brief description of what these do
// TODO a list of scaled score things => with edit + delete buttons
class ScaledApplicationEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[
        ListTile(
          // TODO MAYBE USE A INFO BUTTON THING
          leading: Text('These applications will scale your score'),
          trailing: Text('PLUS BUTTONhere'),
        ),
        Card(child: ListTile(
            leading: Text("Image"),
            title: Text("Name"),
            trailing: Text('remove button'),
        )),
        Card(child: ListTile(
            title: Text("sda"))),
      ],
    );
  }

}