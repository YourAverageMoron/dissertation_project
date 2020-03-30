import 'package:dissertation_project/bloc/leaderboard/leaderboard_event.dart';
import 'package:dissertation_project/bloc/leaderboard/leaderboard_state.dart';
import 'package:dissertation_project/data/leaderboard/leaderboard_data.dart';
import 'package:dissertation_project/data/score/score_repository.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  //TODO MIGHT NEED TO BE INJECTED IN SOME WAY?
  LeaderboardEntries _leaderboardEntries = LeaderboardEntries.createMockData();
  final ScoreRepository _scoreRepository = Injector.resolve<ScoreRepository>();

  @override
  LeaderboardState get initialState => LeaderboardEmpty();

  @override
  Stream<LeaderboardState> mapEventToState(LeaderboardEvent event) async* {
    if (event is FetchLeaderboard) {
      yield LeaderboardLoading();
      try {
        final int score = await _scoreRepository.generateScore(event.date);
        LeaderboardData userEntry = LeaderboardData(name: 'You', score: score);
        _leaderboardEntries.addToList(name: "You", entry: userEntry);
        List<RankedLeaderboardData> entryList =
            _leaderboardEntries.getOrderedList();

        List<RankedLeaderboardData> topEightList = entryList.sublist(0, 8);

        if (!_listContainsEntry(userEntry, topEightList)) {
          topEightList.removeLast();
          topEightList.add(RankedLeaderboardData.fromLeaderboardData(
              userEntry, _getIndexOfData(userEntry, entryList)));
        }

        yield LeaderboardLoaded(leaderboardRows: topEightList);
      } catch (e) {
        print(e);
        yield LeaderboardError();
      }
    }
  }

  int _getIndexOfData(LeaderboardData data, List<LeaderboardData> list) {
    for (int i = 0; i < list.length; i++) {
      if (data.name == list[i].name && data.score == list[i].score) {
        return i;
      }
    }
    return null;
  }

  bool _listContainsEntry(LeaderboardData data, List<LeaderboardData> list) {
    for (int i = 0; i < list.length; i++) {
      if (data.name == list[i].name && data.score == list[i].score) {
        return true;
      }
    }
    return false;
  }
}
