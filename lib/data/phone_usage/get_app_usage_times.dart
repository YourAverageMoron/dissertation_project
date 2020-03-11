import 'dart:convert';

import 'package:app_usage/app_usage.dart';
import 'package:dissertation_project/data/phone_usage/app_usage_statistic.dart';
import 'package:flutter/services.dart';

class GetAppUsageTimes {
  static const platform =
      const MethodChannel('uk.ac.bath.dissertation_project/helper_methods');

  Future<Map<String, AppUsageStat>> getUsageStats(
      DateTime startDate, DateTime endDate) async {
    Map<String, AppUsageStat> appUsageStats =
        await _fetchAppUsageStats(startDate, endDate);

    Map<String, double> appScreenTimes =
        await _getScreenTimeStats(startDate, endDate);

    appScreenTimes.forEach((key, value) {
      appUsageStats[key] = (appUsageStats.containsKey(key))
          ? AppUsageStat(key, value, appUsageStats[key].getLaunchCount())
          : AppUsageStat(key, value, 0);
    });

//    String packageName;
//    for (AppUsageStat appUsageStat in appUsageStats) {
//      packageName = appUsageStat.getPackageName();
//      if (appScreenTime.containsKey(packageName)) {
//        appUsageStat.setTimeInForground(appScreenTime[packageName] * 1000);
//        appScreenTime.remove(packageName);
//      }
//    }
//    appScreenTime.forEach((key, value) {
//      appUsageStats.add(AppUsageStat(key, value * 1000, 0));
//    });

    appUsageStats.remove('uk.ac.bath.dissertation_project');

    return appUsageStats;
  }

  Future<Map<String, AppUsageStat>> _fetchAppUsageStats(
      DateTime startDate, DateTime endDate) async {
    try {
      int startTime = startDate.millisecondsSinceEpoch;
      int endTime = endDate.millisecondsSinceEpoch;

      Map<String, int> interval = {'startTime': startTime, 'endTime': endTime};
      List<dynamic> result =
          await platform.invokeMethod('getUsageStats', interval);

      List<AppUsageStat> appUsageList = result
          .map((appUsage) => AppUsageStat.fromJson(jsonDecode(appUsage)))
          .toList();

      Map<String, AppUsageStat> mapAppUsageStats = Map.fromIterable(
          appUsageList,
          key: (appUsage) => appUsage.getPackageName(),
          value: (appUsage) => appUsage);

      return mapAppUsageStats;
    } on PlatformException catch (e) {
      print(e);
      return {};
    }
  }

  Future<Map<String, double>> _getScreenTimeStats(
      DateTime startDate, DateTime endDate) async {
    AppUsage appUsage = new AppUsage();
    try {
      Map<String, double> usage = await appUsage.fetchUsage(startDate, endDate);
      usage.removeWhere((key, val) => val == 0);
      return usage;
    } on AppUsageException catch (exception) {
      print(exception);
      return {};
    }
  }
}
