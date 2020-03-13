import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dissertation_project/data/phone_usage/app_usage_statistic.dart';
import 'package:dissertation_project/data/phone_usage/phone_usage_statistics.dart';
import 'package:dissertation_project/helpers/system_packages_info/package_manager_repository.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:flutter_package_manager/flutter_package_manager.dart';

PackageManagerRepository _packageManagerRepository =
    Injector.resolve<PackageManagerRepository>();
final PhoneUsageStatistics _phoneUsageStatistics =
    Injector.resolve<PhoneUsageStatistics>();

class AppScreenTimeData {
  String appName;
  AppUsageStat appUsageStat;

  AppScreenTimeData(this.appName, this.appUsageStat);
}

class StatsBlocHelper {
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

  Future<String> getAppScreenTimeString(
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
