import 'package:dissertation_project/data/phone_usage/phone_usage_statistics.dart';
import 'package:dissertation_project/data/time_scaler/comparable_time_of_day.dart';
import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';
import 'package:dissertation_project/helpers/datetime_helpers.dart';
import 'package:dissertation_project/helpers/shared_preferences/scaled_score_times_preferences.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';

class ScoreRepository {
  final PhoneUsageStatistics _phoneUsageStatistics =
      Injector.resolve<PhoneUsageStatistics>();
  final ScaledScoreTimesPreferences _scaledScoreTimesPreferences =
      Injector.resolve<ScaledScoreTimesPreferences>();
  final DateTimeHelpers _dateTimeHelpers = Injector.resolve<DateTimeHelpers>();

  double _totalScreenTime = 0;
  double _totalApplicationsOpened = 0;

  Future<int> generateScore(DateTime date) async {
    await _updateScoreParameters(date);
    return _calculateScore();
  }

  int _calculateScore() {
    int appOpenScore = _getApplicationOpensScore();
    int screenTimeScore = _getScreenTimeScore();

    return ((appOpenScore + screenTimeScore) /2).round().toInt();
  }

  Future<void> _updateScoreParameters(DateTime date) async {
    ComparableTimeOfDay endTime =
        ComparableTimeOfDay(hour: date.hour, minute: date.minute);
    List<ScaledScoreTime> scaledScoreTimeList =
        await _scaledScoreTimesPreferences.getAllTimesScaled(endTime);

    double totalScreenTime = 0;
    double totalApplicationsOpened = 0;

    for (ScaledScoreTime scaledScoreTime in scaledScoreTimeList) {
      DateTime startDate = _dateTimeHelpers.timeOfDayToDate(
          date, scaledScoreTime.getStartTime());
      DateTime endDate =
          _dateTimeHelpers.timeOfDayToDate(date, scaledScoreTime.getEndTime());
      double scaleFactor = scaledScoreTime.getScaleFactor();

      totalApplicationsOpened += await _phoneUsageStatistics
          .getTotalApplicationOpens(startDate, endDate,
              scaleFactor: scaleFactor);
      totalScreenTime += await _phoneUsageStatistics
          .getTotalAppUsageTime(startDate, endDate, scaleFactor: scaleFactor);
    }
    _totalScreenTime = totalScreenTime;
    _totalApplicationsOpened = totalApplicationsOpened;
  }

  /// Scales score between 10 and 60 app opens
  /// <= 10 = 100 points | >= 60 = 0 points
  /// every app open is 2 points
  int _getApplicationOpensScore(){
    double score = 100;

    double appOpensMinusTen = _totalApplicationsOpened - 10;

    if(appOpensMinusTen > 0){ score -= appOpensMinusTen * 2; }

    if(score < 0){ score = 0; }

    return score.round().toInt();
  }

  /// Scales score between 2:30h and 5h for screen time
  /// <= 2:30h = 100 points | >=5h = 0 points
  /// every 1.5 mins = 1 point
  int _getScreenTimeScore(){
    double score = 100;

    double screenTimeMinusTwoHoursThirty = _totalScreenTime - 9000000;

    if(screenTimeMinusTwoHoursThirty > 0){
      score -= screenTimeMinusTwoHoursThirty / 90000;
    }

    if(score < 0){ score = 0; }

    return score.round().toInt();
  }
}
