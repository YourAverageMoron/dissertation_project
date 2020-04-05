import 'package:dissertation_project/bloc/settings/scaled_time/scaled_time_form_bloc.dart';
import 'package:dissertation_project/bloc/settings/settings_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class AddScaledTimeField extends StatelessWidget {
  final SettingsBloc settingsBloc;
  final ScaledTimeFormBloc scaledTimeFormBloc;

  AddScaledTimeField(
      {@required this.settingsBloc, @required this.scaledTimeFormBloc});

  @override
  Widget build(BuildContext context) {
    return FormBlocListener<ScaledTimeFormBloc, String, String>(
        formBloc: scaledTimeFormBloc,
        child: Row(children: <Widget>[
          Expanded(
              child: Text("FIELDS HERE")//TODO TIME FIELDS HERE,
          ),
          IconButton(
            color: Colors.green,
            onPressed: () => Function.apply(settingsBloc.addScaledApp,
                [scaledTimeFormBloc.scaleFactor, scaledTimeFormBloc]),
            icon: Icon(Icons.add_circle),
          )
        ]));
  }
}
