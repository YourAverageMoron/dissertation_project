import 'package:dissertation_project/widgets/flower/animation_controls.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ScoreState extends Equatable {
  const ScoreState();

  @override
  List<Object> get props => [];
}

class ScoreEmpty extends ScoreState {
  final AnimationControls animationControls;

  ScoreEmpty({@required this.animationControls})
      : assert(animationControls != null);
}

class ScoreLoading extends ScoreState {
  final AnimationControls animationControls;

  ScoreLoading({@required this.animationControls})
      : assert(animationControls != null);
}

class ScoreLoaded extends ScoreState {
  final int score;
  final AnimationControls animationControls;

  const ScoreLoaded({@required this.score, @required this.animationControls})
      : assert(score != null && animationControls != null);

  @override
  List<Object> get props => [score];
}

class ScoreError extends ScoreState {
  final AnimationControls animationControls;

  ScoreError({@required this.animationControls})
      : assert(animationControls != null);
}
