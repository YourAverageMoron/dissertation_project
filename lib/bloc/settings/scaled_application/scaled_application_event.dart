import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:equatable/equatable.dart';

abstract class ScaledApplicationEvent extends Equatable {

  const ScaledApplicationEvent();

  @override
  List<Object> get props => [];
}

class LoadScaledApp extends ScaledApplicationEvent {}

class AddScaledApp extends ScaledApplicationEvent {
  final ScaledApp scaledApp;

  const AddScaledApp(this.scaledApp);

  @override
  List<Object> get props => [scaledApp];
}

class UpdateScaledApp extends ScaledApplicationEvent {
  final ScaledApp scaledApp;

  const UpdateScaledApp(this.scaledApp);

  @override
  List<Object> get props => [scaledApp];
}

class DeleteScaledApp extends ScaledApplicationEvent {
  final ScaledApp scaledApp;

  const DeleteScaledApp(this.scaledApp);

  @override
  List<Object> get props => [scaledApp];
}

class ScaledAppFormEvent extends ScaledApplicationEvent {
  final ScaledApp scaledApp;

  const ScaledAppFormEvent(this.scaledApp);

  @override
  List<Object> get props => [scaledApp];
}