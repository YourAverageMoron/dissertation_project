import 'package:dissertation_project/bloc/score/score_event.dart';
import 'package:dissertation_project/data/score/score_repository.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:dissertation_project/widgets/flower/animation_controls.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  final ScoreRepository _scoreRepository = Injector.resolve<ScoreRepository>();

  AnimationControls _animationControls = AnimationControls();

  @override
  ScoreState get initialState =>
      ScoreEmpty(animationControls: _animationControls);

  @override
  Stream<ScoreState> mapEventToState(ScoreEvent event) async* {
    if (event is FetchScore) {
      yield ScoreLoading(animationControls: _animationControls);
    }
    try {
      final int score = await _scoreRepository.generateScore(DateTime.now());
      _animationControls.updateScore(score.toDouble());
      yield ScoreLoaded(score: score, animationControls: _animationControls);
    } catch (e) {
      print(e);
      yield ScoreError(animationControls: _animationControls);
    }
  }
}
