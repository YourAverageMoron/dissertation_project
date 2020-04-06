import 'package:dissertation_project/bloc/settings/scaled_application/scaled_app_form_bloc.dart';
import 'package:dissertation_project/bloc/settings/scaled_application/scaled_app_list_bloc.dart';
import 'package:dissertation_project/bloc/settings/settings_bloc.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedScaledAppsList extends StatelessWidget {
  final SettingsBloc settingsBloc;
  final ScaledAppFormBloc scaledAppFormBloc;

  SelectedScaledAppsList(
      {@required this.settingsBloc, @required this.scaledAppFormBloc});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<ScaledAppListBloc, List<ScaledApp>>(
        bloc: scaledAppFormBloc.scaledAppListBloc,
        builder: (context, state) {
          return ListView.builder(
              itemCount: state.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _ScaledApplicationCard(
                  scaledApp: state[index],
                  bloc: settingsBloc,
                );
              });
        });
  }
}

class _ScaledApplicationCard extends StatelessWidget {
  final ScaledApp scaledApp;
  final SettingsBloc bloc;

  _ScaledApplicationCard({this.scaledApp, this.bloc});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: scaledApp.getIcon(),
      title: Text(scaledApp.getAppName()),
      subtitle: Text(scaledApp.getScaleFactor().toString()),
      trailing: IconButton(
        icon: Icon(Icons.remove),
        color: Colors.red,
        onPressed: () {
          Function.apply(
              bloc.removeScaledApp, [scaledApp]); //TODO implement this
        },
      ),
    ));
  }
}
