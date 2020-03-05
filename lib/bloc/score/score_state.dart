import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ScoreState extends Equatable {
  const ScoreState();

  @override
  List<Object> get props => [];
}

class ScoreEmpty extends ScoreState {}

class ScoreLoading extends ScoreState {}

class ScoreLoaded extends ScoreState {
  final int score;

  const ScoreLoaded({@required this.score}) : assert(score != null);

  @override
  List<Object> get props => [score];
}

class ScoreError extends ScoreState {}
