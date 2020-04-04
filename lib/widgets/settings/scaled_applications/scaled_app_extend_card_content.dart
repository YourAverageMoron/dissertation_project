import 'package:dissertation_project/bloc/settings/scaled_application/add_scaled_app_form_bloc.dart';
import 'package:dissertation_project/bloc/settings/settings_bloc.dart';
import 'package:dissertation_project/widgets/settings/scaled_applications/scaled_app_list.dart';
import 'package:flutter/cupertino.dart';

import 'add_scaled_app_field.dart';

class ScaledAppExtendCardContent extends StatelessWidget {
  final SettingsBloc settingsBloc;
  final AddScaledAppFormBloc addScaledAppFormBloc;

  ScaledAppExtendCardContent(
      {@required this.settingsBloc, @required this.addScaledAppFormBloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AddScaledAppField(
          settingsBloc: settingsBloc,
          addScaledAppFormBloc: addScaledAppFormBloc,
        ),
        SelectedScaledAppsList(
          settingsBloc: settingsBloc,
          addScaledAppFormBloc: addScaledAppFormBloc,
        ),
      ],
    );
  }
}
