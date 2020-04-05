import 'package:dissertation_project/bloc/settings/scaled_application/scaled_app_form_bloc.dart';
import 'package:dissertation_project/bloc/settings/settings_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class AddScaledAppField extends StatelessWidget {
  final SettingsBloc settingsBloc;
  final ScaledAppFormBloc scaledAppFormBloc;

  AddScaledAppField(
      {@required this.settingsBloc, @required this.scaledAppFormBloc});

  @override
  Widget build(BuildContext context) {
    return FormBlocListener<ScaledAppFormBloc, String, String>(
        formBloc: scaledAppFormBloc,
        child: Row(children: <Widget>[
          Expanded(
              child: TextFieldBlocBuilder(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.apps),
              labelText: "Select an application",
            ),
            textFieldBloc: scaledAppFormBloc.textField,
          )),
          IconButton(
            color: Colors.green,
            onPressed: () => Function.apply(settingsBloc.addScaledApp,
                [scaledAppFormBloc.scaleFactor, scaledAppFormBloc]),
            icon: Icon(Icons.add_circle),
          )
        ]));
  }
}
