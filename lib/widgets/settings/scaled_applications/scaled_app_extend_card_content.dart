import 'package:dissertation_project/bloc/settings/scaled_application/scaled_app_form_bloc.dart';
import 'package:dissertation_project/bloc/settings/settings_bloc.dart';
import 'package:dissertation_project/widgets/settings/scaled_applications/scaled_app_list.dart';
import 'package:flutter/cupertino.dart';

import 'add_scaled_app_field.dart';

class ScaledAppExtendCardContent extends StatelessWidget {
  final SettingsBloc settingsBloc;
  final ScaledAppFormBloc scaledAppFormBloc;

  ScaledAppExtendCardContent(
      {@required this.settingsBloc, @required this.scaledAppFormBloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AddScaledAppField(
          settingsBloc: settingsBloc,
          scaledAppFormBloc: scaledAppFormBloc,
        ),
        SelectedScaledAppsList(
          settingsBloc: settingsBloc,
          scaledAppFormBloc: scaledAppFormBloc,
        ),
      ],
    );
  }
}
