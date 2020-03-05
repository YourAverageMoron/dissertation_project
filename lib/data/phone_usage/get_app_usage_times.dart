import 'dart:convert';

import 'package:dissertation_project/data/phone_usage/app_usage_statistic.dart';
import 'package:flutter/services.dart';

//TODO USE https://pub.dev/packages/flutter_package_manager TO GET NAMES OF APPS

//TODO I THINK THE GET USAGE STATS METHOD MAY NEED A LISTNEER THAT SITS THERE CONSTANTLY
//todo then have a method that gets the usage stats from that listener
// TODO THIS STOPS IT FROM RETURNING AN EMPTY ARRAY
// todo also check why it seems to not get stats for some apps like messaging could it be due to the packageName being longer?
class GetAppUsageTimes {
  static const platform =
      const MethodChannel('uk.ac.bath.dissertation_project/helper_methods');

  Future<List<AppUsageStat>> getUsageStats(
      DateTime startDate, DateTime endDate) async {
    try {
      int startTime = startDate.millisecondsSinceEpoch;
      int endTime = endDate.millisecondsSinceEpoch;

      Map<String, int> interval = {'startTime': startTime, 'endTime': endTime};
      List<dynamic> result = await platform.invokeMethod('getUsageStats', interval);

      List<AppUsageStat> appUsageList = result.map((appUsage) => AppUsageStat.fromJson(jsonDecode(appUsage))).toList();

      return appUsageList;

    } on PlatformException catch (e) {
      //TODO IMPLEMENT (PRINT ERROR MAYBE?)
    }
  }


}
