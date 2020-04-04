import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class LoadSettings extends SettingsEvent {
  List<Object> get props => [];
}

class AddDoubledApp extends SettingsEvent {
  final ScaledApp scaledApp;

  const AddDoubledApp({@required this.scaledApp})
      : assert(scaledApp != null);

  @override
  List<Object> get props => [scaledApp];
}
