import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dissertation_project/bloc/statistics/statistics_events.dart';
import 'package:dissertation_project/bloc/statistics/statistics_state.dart';
import 'package:dissertation_project/data/phone_usage/app_usage_statistic.dart';
import 'package:dissertation_project/data/phone_usage/get_app_usage_times.dart';
import 'package:dissertation_project/data/phone_usage/phone_usage_statistics.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final PhoneUsageStatistics _phoneUsageStatistics =
      Injector.resolve<PhoneUsageStatistics>();
  final GetAppUsageTimes _appUsageTime = Injector.resolve<GetAppUsageTimes>();

  @override
  StatsState get initialState => StatsEmpty();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is FetchStats) {
      yield StatsLoading();
      try {
        DateTime now = DateTime.now();
        DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0);

        final double applicationOpens = await _phoneUsageStatistics
            .getTotalApplicationOpens(startOfDay, now);

        final String applicationScreenTime =
            await _getAppScreenTimeString(startOfDay, now);

        Map<String, AppUsageStat> appUsageStats =
            await _appUsageTime.getUsageStats(startOfDay, now);

        List<charts.Series> appScreenTimePieData =
            getAppScreenTimeBreakdown(appUsageStats);
        print(appScreenTimePieData);

        appUsageStats.forEach((key, value) {
          print('${value.getPackageName()} ${value.getTimeInForground()}');
        });

        yield StatsLoaded(
          appScreenTimePieData: appScreenTimePieData,
          applicationOpens: applicationOpens.round().toInt(),
          appScreenTime: applicationScreenTime,
        );
      } catch (_) {
        yield StatsError();
      }
    }
  }

  List<charts.Series> getAppScreenTimeBreakdown(
      Map<String, AppUsageStat> appUsageStats) {
    List<AppUsageStat> data = [];
    appUsageStats.forEach((key, value) {
      data.add(value);
    });
    return [
      new charts.Series<AppUsageStat, int>(
        id: 'AppScreenTimeBreakdown',
        domainFn: (AppUsageStat stat, _) =>
            stat.getTimeInForground().round().toInt(),
        measureFn: (AppUsageStat stat, _) => stat.getTimeInForground(),
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (AppUsageStat row, _) =>
            '${row.getPackageName()}: ${row.getTimeInForground()}',
      )
    ];
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
