import 'package:dissertation_project/bloc/settings/scaled_time/scaled_time_form_bloc.dart';
import 'package:dissertation_project/bloc/settings/settings_bloc.dart';
import 'package:dissertation_project/widgets/settings/scaled_times/add_scaled_time_field.dart';
import 'package:dissertation_project/widgets/settings/scaled_times/scaled_time_list.dart';
import 'package:flutter/cupertino.dart';

class ScaledTimeExtendCardContent extends StatelessWidget {
  final SettingsBloc settingsBloc;
  final ScaledTimeFormBloc scaledTimeFormBloc;

  ScaledTimeExtendCardContent(
      {@required this.settingsBloc, @required this.scaledTimeFormBloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AddScaledTimeField(
          settingsBloc: settingsBloc,
          scaledTimeFormBloc: scaledTimeFormBloc,
        ),
        SelectedScaledTimeList(
          settingsBloc: settingsBloc,
          scaledTimeFormBloc: scaledTimeFormBloc,
        ),
      ],
    );
  }
}
