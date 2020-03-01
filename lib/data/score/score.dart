import 'package:dissertation_project/data/phone_usage/phone_usage_statistics.dart';
import 'package:dissertation_project/data/shared_preferences/scaled_score_times_preferences.dart';
import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';
import 'package:dissertation_project/helpers/datetime_helpers.dart';

class Score {
  //TODO create a constructor?
  //TODO MAYBE HAVE THE VARIABLES STORED IN THIS, THEN UPDATE THEM WHEN ACCESSING? -> might be more efficient as you can count stuff in one loop
  final PhoneUsageStatistics _phoneUsageStatistics = PhoneUsageStatistics();
  final ScaledScoreTimesPreferences _scaledScoreTimesPreferences =
      ScaledScoreTimesPreferences();
  final DateTimeHelpers _dateTimeHelpers = DateTimeHelpers();

  Future<int> _getTotalTimeScore(DateTime date) async {
    List<ScaledScoreTime> scaledScoreTimeList =
        await _scaledScoreTimesPreferences.getAllTimesScored();

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
    // Sum of the open numbers
    print('Total: $totalTime');
    print('Screentime: $totalScreenTime');
    print('Opens: $totalApplicationsOpened');

    return null;
  }

  Future<int> generateScore(DateTime date) {
    return _getTotalTimeScore(date);
  }
}
