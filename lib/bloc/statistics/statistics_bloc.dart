import 'package:dissertation_project/bloc/statistics/statistics_events.dart';
import 'package:dissertation_project/bloc/statistics/statistics_state.dart';
import 'package:dissertation_project/data/phone_usage/phone_usage_statistics.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final PhoneUsageStatistics _phoneUsageStatistics =
      Injector.resolve<PhoneUsageStatistics>();

  @override
  StatsState get initialState => StatsEmpty();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is FetchStats) {
      yield StatsLoading();
      try {
        DateTime now = DateTime.now();
        DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);

        final double applicationOpens = await _phoneUsageStatistics
            .getTotalApplicationOpens(startOfDay, now);

        final String applicationScreenTime =
            await _getAppScreenTimeString(startOfDay, now);

        yield StatsLoaded(
          applicationOpens: applicationOpens.round().toInt(),
          appScreenTime: applicationScreenTime,
        );
      } catch (_) {
        yield StatsError();
      }
    }
  }

  Future<String> _getAppScreenTimeString(
      DateTime startTime, DateTime endTime) async {
    final Duration appScreenTime = Duration(
        milliseconds: (await _phoneUsageStatistics.getTotalAppUsageTime(
                startTime, endTime))
            .round()
            .toInt());

    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(appScreenTime.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(appScreenTime.inSeconds.remainder(60));
    return "${twoDigits(appScreenTime.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
