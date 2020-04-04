import 'package:dissertation_project/bloc/settings/scaled_application/add_scaled_app_form_bloc.dart';
import 'package:dissertation_project/bloc/settings/settings_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class AddScaledAppField extends StatelessWidget {
  final SettingsBloc settingsBloc;
  final AddScaledAppFormBloc addScaledAppFormBloc;

  AddScaledAppField(
      {@required this.settingsBloc, @required this.addScaledAppFormBloc});

  @override
  Widget build(BuildContext context) {
    return FormBlocListener<AddScaledAppFormBloc, String, String>(
        formBloc: addScaledAppFormBloc,
        child: Row(children: <Widget>[
          Expanded(
              child: TextFieldBlocBuilder(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.apps),
              labelText: "some",
            ),
            textFieldBloc: addScaledAppFormBloc.textField,
          )),
          IconButton(
            color: Colors.green,
            onPressed: () => Function.apply(settingsBloc.addScaledApp,
                [addScaledAppFormBloc.scaleFactor, addScaledAppFormBloc]),
            icon: Icon(Icons.add_circle),
          )
        ]));
  }
}
