import 'package:dissertation_project/bloc/settings/scaled_time/scaled_time_list_bloc.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ScaledTimeFormBloc extends FormBloc<String, String> {
  /// Blocs
  final ScaledTimeListBloc scaledTimeListBloc = ScaledTimeListBloc();
  // ignore: close_sinks
  InputFieldBloc startTimeFieldBloc;
  // ignore: close_sinks
  InputFieldBloc endTimeFieldBloc;
  List<ScaledApp> selectedTimes = [];
  double scaleFactor;

  ScaledTimeFormBloc({@required Map<String, ScaledScoreTime> scaledTimes,
    @required this.scaleFactor}) {
    startTimeFieldBloc = InputFieldBloc<TimeOfDay, Object>();
    endTimeFieldBloc = InputFieldBloc<TimeOfDay, Object>();

    addFieldBlocs(fieldBlocs: [startTimeFieldBloc, endTimeFieldBloc]);
  }

  void updateScaledTimes(){

  }


  @override
  void onSubmitting() {}
}
