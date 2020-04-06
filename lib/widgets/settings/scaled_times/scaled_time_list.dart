import 'package:dissertation_project/bloc/settings/scaled_application/scaled_app_form_bloc.dart';
import 'package:dissertation_project/bloc/settings/scaled_application/scaled_app_list_bloc.dart';
import 'package:dissertation_project/bloc/settings/scaled_time/scaled_time_form_bloc.dart';
import 'package:dissertation_project/bloc/settings/scaled_time/scaled_time_list_bloc.dart';
import 'package:dissertation_project/bloc/settings/settings_bloc.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedScaledTimeList extends StatelessWidget {
  final SettingsBloc settingsBloc;
  final ScaledTimeFormBloc scaledTimeFormBloc;

  SelectedScaledTimeList(
      {@required this.settingsBloc, @required this.scaledTimeFormBloc});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<ScaledTimeListBloc, List<ScaledScoreTime>>(
        bloc: scaledTimeFormBloc.scaledTimeListBloc,
        builder: (context, state) {
          return ListView.builder(
              itemCount: state.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _ScaledTimeCard(
                  scaledScoreTime: state[index],
                  bloc: settingsBloc,
                );
              });
        });
  }
}

class _ScaledTimeCard extends StatelessWidget {
  final ScaledScoreTime scaledScoreTime;
  final SettingsBloc bloc;

  _ScaledTimeCard({this.scaledScoreTime, this.bloc});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          //leading: scaledScoreTime,
          title: Text(scaledScoreTime.toString()),
          subtitle: Text(scaledScoreTime.getScaleFactor().toString()),
          trailing: IconButton(
            icon: Icon(Icons.remove),
            color: Colors.red,
            onPressed: () {
              Function.apply(
                  bloc.removeScaledTime, [scaledScoreTime]);
            },
          ),
        ));
  }
}
