import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

abstract class ScaledAppListEvent extends Equatable {
  const ScaledAppListEvent();
}

class UpdateScaledAppList extends ScaledAppListEvent {
  final List<ScaledApp> scaledApps;

  const UpdateScaledAppList({@required this.scaledApps})
      : assert(scaledApps != null);

  @override
  List<List<ScaledApp>> get props => [scaledApps];
}

class ScaledAppListBloc extends Bloc<ScaledAppListEvent, List<ScaledApp>> {
  List<ScaledApp> get initialState => [];

  @override
  Stream<List<ScaledApp>> mapEventToState(ScaledAppListEvent event) async* {
    if (event is UpdateScaledAppList) {
      yield List.from(event.scaledApps);
    }
  }
}
