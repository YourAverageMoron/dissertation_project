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
          ? AppUsageStat(key, value * 1000, appUsageStats[key].getLaunchCount())
          : AppUsageStat(key, value * 1000, 0);
    });

    appUsageStats.remove('uk.ac.bath.dissertation_project');

    //com.google.android.apps.nexuslauncher SEEMS TO BE THE OS
    // You dont really want to look at every time the os is opened (essentially doubles all app opens)
    if (appUsageStats.containsKey('com.google.android.apps.nexuslauncher')) {
      appUsageStats['com.google.android.apps.nexuslauncher'] = AppUsageStat(
          'com.google.android.apps.nexuslauncher',
          appUsageStats['com.google.android.apps.nexuslauncher']
              .getTimeInForground(),
          0);
    }
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
