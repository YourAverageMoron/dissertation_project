import 'package:dissertation_project/data/leaderboard/leaderboard_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object> get props => [];
}

class LeaderboardError extends LeaderboardState {}

class LeaderboardEmpty extends LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardLoaded extends LeaderboardState {
  final List<RankedLeaderboardData> leaderboardRows;

  LeaderboardLoaded({@required this.leaderboardRows});

  @override
  List<Object> get props => [leaderboardRows];
}
