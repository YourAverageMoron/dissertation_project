import 'package:dissertation_project/bloc/settings/scaled_application/scaled_app_form_bloc.dart';
import 'package:dissertation_project/bloc/settings/scaled_time/scaled_time_form_bloc.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsEmpty extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final Map<String, ScaledApp> scaledApps;
  final List<ScaledScoreTime> scaledTimes;
  final ScaledAppFormBloc doubleAppBloc;
  final ScaledAppFormBloc halfAppBloc;
  final ScaledTimeFormBloc doubleTimeBloc;
  final ScaledTimeFormBloc halfTimeBloc;

  const SettingsLoaded({
    @required this.scaledApps,
    @required this.scaledTimes,
    @required this.doubleAppBloc,
    @required this.halfAppBloc,
    @required this.doubleTimeBloc,
    @required this.halfTimeBloc,
  }) : assert(scaledApps != null &&
            scaledTimes != null &&
            doubleAppBloc != null &&
            halfAppBloc != null &&
            doubleTimeBloc != null &&
            halfTimeBloc != null);

  @override
  List<Object> get props => [scaledApps, doubleAppBloc, halfAppBloc];
}
