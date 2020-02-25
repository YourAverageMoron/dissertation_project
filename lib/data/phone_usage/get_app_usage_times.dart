import 'dart:convert';

import 'package:dissertation_project/data/phone_usage/app_usage_time.dart';
import 'package:flutter/services.dart';

//TODO USE https://pub.dev/packages/flutter_package_manager TO GET NAMES OF APPS
class GetAppUsageTimes {
  static const platform =
      const MethodChannel('uk.ac.bath.dissertation_project/helper_methods');

  Future<List<AppUsageTime>> getUsageStats(
      DateTime startDate, DateTime endDate) async {
    try {
      int startTime = startDate.millisecondsSinceEpoch;
      int endTime = endDate.millisecondsSinceEpoch;

      Map<String, int> interval = {'startTime': startTime, 'endTime': endTime};
      List<String> result = await platform.invokeMethod('getUsageStats', interval);

      List<AppUsageTime> appUsageList = result.map((appUsage) => AppUsageTime.fromJson(jsonDecode(appUsage))).toList();

      return appUsageList;

    } on PlatformException catch (e) {
      //TODO IMPLEMENT (PRINT ERROR MAYBE?)
    }
  }


}
