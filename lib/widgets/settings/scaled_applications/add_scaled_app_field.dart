import 'package:dissertation_project/bloc/settings/scaled_application/add_scaled_app_form_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class AddScaledAppField extends StatelessWidget {
  final AddScaledAppFormBloc bloc;

  AddScaledAppField({this.bloc});

  @override
  Widget build(BuildContext context) {
    return FormBlocListener<AddScaledAppFormBloc, String, String>(
        child: Row(children: <Widget>[
          Expanded(
              child: TextFieldBlocBuilder(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.apps),
                  labelText: "some",
                ),
                textFieldBloc: bloc.textField,
              )),
          IconButton(
            color: Colors.green,
            onPressed: () =>
                Function.apply(bloc.addScaledApp, [2.0]),
            icon: Icon(Icons.add_circle),
          )
        ]));
  }
}