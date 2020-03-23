import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dissertation_project/data/phone_usage/app_usage_statistic.dart';
import 'package:dissertation_project/data/phone_usage/phone_usage_statistics.dart';
import 'package:dissertation_project/data/score/score_repository.dart';
import 'package:dissertation_project/helpers/datetime_helpers.dart';
import 'package:dissertation_project/helpers/system_packages_info/package_manager_repository.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:flutter_package_manager/flutter_package_manager.dart';

//TODO THERSE SHOULDN'T BE HERE
PackageManagerRepository _packageManagerRepository =
    Injector.resolve<PackageManagerRepository>();
final PhoneUsageStatistics _phoneUsageStatistics =
    Injector.resolve<PhoneUsageStatistics>();
final ScoreRepository _scoreRepository = Injector.resolve<ScoreRepository>();

class DailyScore {
  String day;
  int score;

  DailyScore(this.day, this.score);
}

class AppScreenTimeData {
  String appName;
  AppUsageStat appUsageStat;

  AppScreenTimeData(this.appName, this.appUsageStat);
}

class StatsBlocHelper {
  DateTimeHelpers _dateTimeHelpers = Injector.resolve<DateTimeHelpers>();

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

  Future<List<DailyScore>> getListOfScores() async {
    DateTime now = DateTime.now();

    DateTime dateTime = now;
    List<DailyScore> scores = [
      DailyScore(_dateTimeHelpers.getWeekday(dateTime).substring(0, 3),
          await _scoreRepository.generateScore(dateTime))
    ];

    for (int i = 1; i < 7; i++) {
      dateTime = DateTime(now.year, now.month, now.day - i, 23, 59, 59);
      scores.add(DailyScore(
          _dateTimeHelpers.getWeekday(dateTime).substring(0, 3),
          await _scoreRepository.generateScore(dateTime)));
    }
    return scores.reversed.toList();
  }

  Future<List<charts.Series<DailyScore, String>>> getWeeklyScores() async {
    final data = await getListOfScores();

    return [
      new charts.Series<DailyScore, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        domainFn: (DailyScore sales, _) => sales.day,
        measureFn: (DailyScore sales, _) => sales.score,
        data: data,
      )
    ];
  }
}
