import 'package:dissertation_project/bloc/settings/settings_bloc.dart';
import 'package:dissertation_project/bloc/settings/settings_event.dart';
import 'package:dissertation_project/bloc/settings/settings_state.dart';
import 'package:dissertation_project/widgets/settings/scaled_applications/scaled_app_extend_card_content.dart';
import 'package:dissertation_project/widgets/settings/settings_expand_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (BuildContext context, SettingsState state) {
          if(state is SettingsLoaded){
            return ListView(children: <Widget>[
              SettingsExpandCard(
                title: "Your 'bad' applications",
                description: "some description of what this does",
                child: ScaledAppExtendCardContent(
                    settingsBloc: context.bloc(),
                    addScaledAppFormBloc: state.doubleAppBloc,
                ),
              ),
              SettingsExpandCard(
                title: "Your 'good' applications",
                description: "some description of what this does",
                child: ScaledAppExtendCardContent(
                  settingsBloc: context.bloc(),
                  addScaledAppFormBloc: state.halfAppBloc,
                ),
              ),
            ]);
          }
          BlocProvider.of<SettingsBloc>(context).add(LoadSettings());
          return Text('Loading');
        },

      )
    );
  }
}
