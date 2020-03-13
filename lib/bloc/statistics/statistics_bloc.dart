import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dissertation_project/bloc/statistics/statistics_events.dart';
import 'package:dissertation_project/bloc/statistics/statistics_state.dart';
import 'package:dissertation_project/data/phone_usage/app_usage_statistic.dart';
import 'package:dissertation_project/data/phone_usage/get_app_usage_times.dart';
import 'package:dissertation_project/data/phone_usage/phone_usage_statistics.dart';
import 'package:dissertation_project/helpers/system_packages_info/package_manager_repository.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_package_manager/flutter_package_manager.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final PhoneUsageStatistics _phoneUsageStatistics =
      Injector.resolve<PhoneUsageStatistics>();
  final GetAppUsageTimes _appUsageTime = Injector.resolve<GetAppUsageTimes>();
  PackageManagerRepository _packageManagerRepository =
      Injector.resolve<PackageManagerRepository>();

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
            await getAppScreenTimeBreakdown(appUsageStats);

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

  Future<List<charts.Series>> getAppScreenTimeBreakdown(
      Map<String, AppUsageStat> appUsageStats) async {
    List<AppScreenTimeData> data = [];

    for (AppUsageStat appUsageStat in appUsageStats.values) {
      if ((appUsageStat.getTimeInForground() / 1000 / 60) > 1) {
        PackageInfo packageInfo = await _packageManagerRepository
            .getPackageInfo(appUsageStat.getPackageName());
        data.add(AppScreenTimeData(packageInfo.appName, appUsageStat));
      }
    }

    return [
      new charts.Series<AppScreenTimeData, String>(
        id: 'AppScreenTimeBreakdown',
        domainFn: (AppScreenTimeData stat, _) => stat.appName,
        measureFn: (AppScreenTimeData stat, _) =>
            stat.appUsageStat.getTimeInForground(),
        data: data,
        labelAccessorFn: (AppScreenTimeData row, _) => '${row.appName}',
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

class AppScreenTimeData {
  String appName;
  AppUsageStat appUsageStat;

  AppScreenTimeData(this.appName, this.appUsageStat);
}
