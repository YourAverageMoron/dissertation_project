import 'dart:async';

import 'package:dissertation_project/kiwi_di/injector.dart';

import 'app_usage_statistic.dart';
import 'get_app_usage_times.dart';

class PhoneUsageStatistics {

  final GetAppUsageTimes _appUsageTime = Injector.resolve<GetAppUsageTimes>();

  Future<double> getTotalAppUsageTime(DateTime startDate, DateTime endDate,
      {double scaleFactor = 1}) async {

    List<AppUsageStat> appUsageStats =
        await _appUsageTime.getUsageStats(startDate, endDate);

    double totalScreenTime = 0;
    for (AppUsageStat appUsageStat in appUsageStats) {
      totalScreenTime += appUsageStat.getTimeInForground() * scaleFactor;
    }
    return totalScreenTime;
  }

  Future<double> getTotalApplicationOpens(DateTime startDate, DateTime endDate,
      {double scaleFactor = 1}) async {
    List<AppUsageStat> appUsageStats =
        await _appUsageTime.getUsageStats(startDate, endDate);

    double totalApplicationsOpened = 0;
    for (AppUsageStat appUsageStat in appUsageStats) {
      totalApplicationsOpened += appUsageStat.getLaunchCount() * scaleFactor;
    }
    return totalApplicationsOpened;
  }
}
