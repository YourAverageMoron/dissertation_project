import 'package:charts_flutter/flutter.dart' as charts;
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
  final List<charts.Series> appScreenTimePieData;
  final List<charts.Series> barChartScoreData;
  final String heuristicString;

  const StatsLoaded(
      {@required this.appScreenTimePieData,
      @required this.applicationOpens,
      @required this.appScreenTime,
      @required this.barChartScoreData,
      @required this.heuristicString})
      : assert(applicationOpens != null &&
            appScreenTime != null &&
            appScreenTimePieData != null &&
            barChartScoreData != null &&
            heuristicString != null);

  @override
  List<Object> get props => [
        applicationOpens,
        appScreenTimePieData,
        appScreenTime,
        barChartScoreData,
        heuristicString
      ];
}

class StatsError extends StatsState {}
