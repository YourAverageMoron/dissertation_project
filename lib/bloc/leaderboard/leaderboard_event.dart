import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();
}

class FetchLeaderboard extends LeaderboardEvent{
  final DateTime date;

  const FetchLeaderboard({@required this.date}) : assert(date != null);

  @override
  List<Object> get props => [date];
}