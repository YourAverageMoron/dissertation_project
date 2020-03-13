import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dissertation_project/bloc/statistics/statistics_bloc_helper.dart';
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
  final StatsBlocHelper _statsBlocHelper = Injector.resolve<StatsBlocHelper>();

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
            await _statsBlocHelper.getAppScreenTimeString(startOfDay, now);

        Map<String, AppUsageStat> appUsageStats =
            await _appUsageTime.getUsageStats(startOfDay, now);

        List<charts.Series> appScreenTimePieData =
            await _statsBlocHelper.getAppScreenTimeBreakdown(appUsageStats);

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
}
