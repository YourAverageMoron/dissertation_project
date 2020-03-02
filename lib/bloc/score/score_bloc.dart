import 'package:dissertation_project/bloc/score/score_event.dart';
import 'package:dissertation_project/data/score/score.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  final ScoreRepository scoreRepository = Injector.resolve<ScoreRepository>();

  @override
  ScoreState get initialState => ScoreEmpty();

  @override
  Stream<ScoreState> mapEventToState(ScoreEvent event) async* {
    if (event is FetchScore) {
      yield ScoreLoading();
    }
    try {
      final int score = await scoreRepository.generateScore(DateTime.now());
      yield ScoreLoaded(score: score);
    } catch (_) {
      yield ScoreError();
    }
  }
}
