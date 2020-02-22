import 'package:dissertation_project/data/phone_usage/app_usage_time.dart';
import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';

// TODO Store this as a shared preference
var timeOfDay = [
  {
    'startTime': {
      'hour': 4,
      'minute':0,
    },
    'endTime': {
      'hour': 5,
      'minute':0,
    },
    'scaleFactor': 0.5
  },
  {
    'startTime': {
      'hour': 14,
      'minute':0,
    },
    'endTime': {
      'hour': 16,
      'minute':0,
    },
    'scaleFactor': 5
  },
];

// TODO Static?
class Score {

  AppUsageTime appUsageTime = AppUsageTime();

  List<ScaledScoreTime> _getScaledScoreTimes() {
    //TODO you will need to get the scaled score from shared preferences

    return timeOfDay.map((json) => ScaledScoreTime.fromJson(json)).toList();
    }

  Future<int> _getTotalTimeScore(DateTime date) async {

    List<ScaledScoreTime> SST = _getScaledScoreTimes();
    SST.forEach((time) => print("${time.getStartTime()} ${time.getEndTime()} + ${time.getScaleFactor()}"));

    int year = date.year;
    int month = date.month;
    int day = date.day;

    DateTime startTime = new DateTime(year, month, day, 0, 0);
    DateTime endTime = new DateTime(year, month, day, 23, 59);

    double totalTime = 0;

    Map<String, double> usageTimes = await appUsageTime.getUsageStats(
        startTime, endTime);

    usageTimes.forEach((name, time) =>
    {
      totalTime += time // TODO CHECK THAT THIS IS THE BEST WAY TO DO THIS
    });

    return _calculateTotalTimeScore(totalTime);
  }


  int _calculateTotalTimeScore(double timeUsed) {
    // TODO THIS IS JUST DOING THE PERCENTAGE TIME USED
    print(((1 - timeUsed / 86400) * 100).round());
    return ((1 - timeUsed / 86400) * 100).round();
  }


  Future<int> generateScore(DateTime date) {
    return _getTotalTimeScore(date);
  }
}