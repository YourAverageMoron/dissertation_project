import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ScaledTimeFormBloc extends FormBloc<String, String> {
  /// Blocs
  //Scaled time list bloc
  // ignore: close_sinks
  InputFieldBloc timeFieldBloc;
  List<ScaledApp> selectedTimes = [];
  double scaleFactor;

  ScaledTimeFormBloc({@required Map<String, ScaledApp> scaledApps,
    @required this.scaleFactor}) {
    timeFieldBloc = InputFieldBloc<TimeOfDay, Object>();

    addFieldBlocs(fieldBlocs: [timeFieldBloc]); //TODO ADD THE FIELDBLOCS HERE
  }

  void updateScaledTimes(){

  }


  @override
  void onSubmitting() {}
}
