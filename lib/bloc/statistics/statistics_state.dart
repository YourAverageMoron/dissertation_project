import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object> get props => [];
}

class StatsEmpty extends StatsState {}

class StatsLoading extends StatsState {}

class StatsLoaded extends StatsState {
  final int applicationOpens;
  final String appScreenTime;

  const StatsLoaded(
      {@required this.applicationOpens, @required this.appScreenTime})
      : assert(applicationOpens != null && appScreenTime != null);

  @override
  List<Object> get props => [applicationOpens];
}

class StatsError extends StatsState {}
