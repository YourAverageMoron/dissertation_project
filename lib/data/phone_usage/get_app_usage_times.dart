import 'dart:convert';

import 'package:app_usage/app_usage.dart';
import 'package:dissertation_project/data/phone_usage/app_usage_statistic.dart';
import 'package:flutter/services.dart';

class GetAppUsageTimes {
  static const platform =
      const MethodChannel('uk.ac.bath.dissertation_project/helper_methods');

  Future<List<AppUsageStat>> getUsageStats(
      DateTime startDate, DateTime endDate) async {
    List<AppUsageStat> appUsageStats =
        await _fetchAppUsageStats(startDate, endDate);

    Map<String, double> appScreenTime =
        await _getScreenTimeStats(startDate, endDate);

    String packageName;
    for (AppUsageStat appUsageStat in appUsageStats) {
      packageName = appUsageStat.getPackageName();
      if (appScreenTime.containsKey(packageName)) {
        appUsageStat.setTimeInForground(appScreenTime[packageName] * 1000);
        appScreenTime.remove(packageName);
      }
    }
    appScreenTime.forEach((key, value) {
      appUsageStats.add(AppUsageStat(key, value * 1000, 0));
    });



    appUsageStats = appUsageStats
        .where((element) =>
            element.getPackageName() != 'uk.ac.bath.dissertation_project')
        .toList();

    return appUsageStats;
  }

  Future<List<AppUsageStat>> _fetchAppUsageStats(
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

      return appUsageList;
    } on PlatformException catch (e) {
      print(e);
      return [];
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
