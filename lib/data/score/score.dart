import 'package:dissertation_project/data/phone_usage/phone_usage_statistics.dart';
import 'package:dissertation_project/data/shared_preferences/scaled_score_times_preferences.dart';
import 'package:dissertation_project/data/time_scaler/comparable_time_of_day.dart';
import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';
import 'package:dissertation_project/helpers/datetime_helpers.dart';

class Score {

  final PhoneUsageStatistics _phoneUsageStatistics = PhoneUsageStatistics();
  final ScaledScoreTimesPreferences _scaledScoreTimesPreferences =
  ScaledScoreTimesPreferences();
  final DateTimeHelpers _dateTimeHelpers = DateTimeHelpers();

  double _totalTime = 0;
  double _totalScreenTime = 0;
  double _totalApplicationsOpened = 0;


  Future<int> generateScore(DateTime date) async {
    await _updateScoreParameters(date);


    return _calculateScore();
  }

  int _calculateScore() {
    return (_totalScreenTime / _totalTime).round().toInt();
  }

  //TODO THIS NEEDS TO FACTOR FOR THAT BEING IN THE MIDDLE OF THE DAY
  //todo it current just looks at the total time in the day
  //todo THIS MIGHT want to do this in the get preferences thing
  Future<void> _updateScoreParameters(DateTime date) async {
    ComparableTimeOfDay endTime = ComparableTimeOfDay(
        hour: date.hour, minute: date.minute);
    List<ScaledScoreTime> scaledScoreTimeList =
    await _scaledScoreTimesPreferences.getAllTimesScored(endTime);

    double totalTime = 0;
    double totalScreenTime = 0;
    double totalApplicationsOpened = 0;

    for (ScaledScoreTime scaledScoreTime in scaledScoreTimeList) {
      DateTime startDate =
      _dateTimeHelpers.timeOfDayToDate(date, scaledScoreTime.getStartTime());
      DateTime endDate =
      _dateTimeHelpers.timeOfDayToDate(date, scaledScoreTime.getEndTime());
      double scaleFactor = scaledScoreTime.getScaleFactor();

      totalTime += scaledScoreTime.calculateTimeDifference() * scaleFactor;
      totalApplicationsOpened += await _phoneUsageStatistics
          .getTotalApplicationOpens(startDate, endDate,
          scaleFactor: scaleFactor);
      totalScreenTime += await _phoneUsageStatistics
          .getTotalAppUsageTime(startDate, endDate, scaleFactor: scaleFactor);
    }
    _totalTime = totalTime;
    _totalScreenTime = totalScreenTime;
    _totalApplicationsOpened = totalApplicationsOpened;
  }
}
