import 'package:dissertation_project/bloc/settings/scaled_application/add_scaled_app_form_bloc.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
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
  final AddScaledAppFormBloc doubleAppBloc;
  final AddScaledAppFormBloc halfAppBloc;

  const SettingsLoaded({
    @required this.scaledApps,
    @required this.doubleAppBloc,
    @required this.halfAppBloc,
  }) : assert(scaledApps != null && doubleAppBloc != null &&
      halfAppBloc != null);

  @override
  List<Object> get props => [scaledApps, doubleAppBloc, halfAppBloc];
}
