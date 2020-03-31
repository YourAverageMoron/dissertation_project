import 'package:dissertation_project/data/time_scaler/comparable_time_of_day.dart';
import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';

DateTime date = DateTime(1998, 04, 20, 12, 00);

List<ScaledScoreTime> scaledTimes = [
  ScaledScoreTime(ComparableTimeOfDay(hour: 0, minute: 0),
      ComparableTimeOfDay(hour: 12, minute: 0), 1),
  ScaledScoreTime(ComparableTimeOfDay(hour: 12, minute: 1),
      ComparableTimeOfDay(hour: 16, minute: 0), 2),
  ScaledScoreTime(ComparableTimeOfDay(hour: 16, minute: 1),
      ComparableTimeOfDay(hour: 23, minute: 59), 1)
];
final Future<List<ScaledScoreTime>> futureScaledTimes =
    new Future(() => scaledTimes);

DateTime startDate1 = DateTime(date.year, date.month, date.day, 0, 0);
DateTime endDate1 = DateTime(date.year, date.month, date.day, 12, 0);
final Future<double> futureAppUsageTime1 =
new Future(() => 20000);
final Future<double> futureApplicationOpens1 =
new Future(() => 20);

DateTime startDate2 = DateTime(date.year, date.month, date.day, 12, 1);
DateTime endDate2 = DateTime(date.year, date.month, date.day, 16, 0);
final Future<double> futureAppUsageTime2 =
new Future(() => 40000);
final Future<double> futureApplicationOpens2 =
new Future(() => 10);

DateTime startDate3 = DateTime(date.year, date.month, date.day, 16, 1);
DateTime endDate3 = DateTime(date.year, date.month, date.day, 23, 59);
final Future<double> futureAppUsageTime3 =
new Future(() => 10800000);
final Future<double> futureApplicationOpens3 =
new Future(() => 5);