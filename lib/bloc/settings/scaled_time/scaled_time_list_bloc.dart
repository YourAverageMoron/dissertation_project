import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ScaledTimeListEvent extends Equatable {
  const ScaledTimeListEvent();
}

class UpdateScaledTimesList extends ScaledTimeListEvent {
  final List<ScaledScoreTime> scaledTimes;

  const UpdateScaledTimesList({@required this.scaledTimes})
      : assert(scaledTimes != null);

  @override
  List<List<ScaledScoreTime>> get props => [scaledTimes];
}

class ScaledTimeListBloc
    extends Bloc<ScaledTimeListEvent, List<ScaledScoreTime>> {
  @override
  List<ScaledScoreTime> get initialState => [];

  @override
  Stream<List<ScaledScoreTime>> mapEventToState(
      ScaledTimeListEvent event) async* {
    if (event is UpdateScaledTimesList) {
      yield List.from(event.scaledTimes);
    }
  }
}
