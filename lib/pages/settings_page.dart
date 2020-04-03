import 'package:dissertation_project/widgets/settings/scaled_applications/scaled_app_extend_card_content.dart';
import 'package:dissertation_project/widgets/settings/settings_expand_card.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(children: <Widget>[
        SettingsExpandCard(
          title: "Your 'bad' applications",
          description: "some description of what this does",
          child: ScaledAppExtendCardContent(),
        ),
      ]),
    );
  }
}
