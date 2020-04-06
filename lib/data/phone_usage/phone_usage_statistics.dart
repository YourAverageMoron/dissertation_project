import 'dart:async';

import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:dissertation_project/repositories/scaled_app_repository.dart';

import 'app_usage_statistic.dart';
import 'get_app_usage_times.dart';

class PhoneUsageStatistics {
  final GetAppUsageTimes _appUsageTime = Injector.resolve<GetAppUsageTimes>();
  final ScaledAppRepository _scaledAppRepository =
      Injector.resolve<ScaledAppRepository>();

  Future<double> getTotalAppUsageTime(DateTime startDate, DateTime endDate,
      {double scaleFactor = 1}) async {
    Map<String, AppUsageStat> appUsageStats =
        await _appUsageTime.getUsageStats(startDate, endDate);
    Map<String, ScaledApp> scaledApps =
        await _scaledAppRepository.getAllScaledApps();
    ScaledApp scaledApp;

    double totalScreenTime = 0;
    appUsageStats.forEach((key, value) {
      scaledApp = scaledApps[value.getPackageName()];
      if (scaledApp != null) {
        totalScreenTime += value.getTimeInForground() *
            scaleFactor *
            scaledApp.getScaleFactor();
      } else {
        totalScreenTime += value.getTimeInForground() * scaleFactor;
      }
    });

    return totalScreenTime;
  }

  Future<double> getTotalApplicationOpens(DateTime startDate, DateTime endDate,
      {double scaleFactor = 1}) async {
    Map<String, AppUsageStat> appUsageStats =
        await _appUsageTime.getUsageStats(startDate, endDate);
    Map<String, ScaledApp> scaledApps =
        await _scaledAppRepository.getAllScaledApps();
    ScaledApp scaledApp;
    double totalApplicationsOpened = 0;
    appUsageStats.forEach((key, value) {
      scaledApp = scaledApps[value.getPackageName()];
      if (scaledApp != null) {
        totalApplicationsOpened +=
            value.getLaunchCount() * scaleFactor * scaledApp.getScaleFactor();
      } else {
        totalApplicationsOpened += value.getLaunchCount() * scaleFactor;
      }
    });
    return totalApplicationsOpened;
  }
}
