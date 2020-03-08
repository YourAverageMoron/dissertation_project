import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:equatable/equatable.dart';

abstract class ScaledApplicationState extends Equatable {
  const ScaledApplicationState();

  @override
  List<Object> get props => [];
}

class ScaledApplicationsLoading extends ScaledApplicationState {}

class ScaledApplicationsLoaded extends ScaledApplicationState {
  final Map<String, ScaledApp> scaledApps;
  const ScaledApplicationsLoaded([this.scaledApps = const {}]);

  List<Object> get props => [scaledApps];
}

class ScaledApplicationsNotLoaded extends ScaledApplicationState {}