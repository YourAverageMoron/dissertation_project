import 'package:dissertation_project/data/phone_usage/get_app_usage_times.dart';
import 'package:dissertation_project/data/shared_preferences/scaled_score_times_preferences.dart';
import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';
import 'package:flutter/material.dart';

class Score {
  //TODO create a constructor?
  final GetAppUsageTimes _appUsageTime = GetAppUsageTimes();
  final ScaledScoreTimesPreferences _scaledScoreTimesPreferences =
      ScaledScoreTimesPreferences();

  Future<int> _getTotalTimeScore(DateTime date) async {
    List<ScaledScoreTime> scaledScoreTimeList =
        await _scaledScoreTimesPreferences.getScaledScoreTimes();

    int year = date.year;
    int month = date.month;
    int day = date.day;

    DateTime startTime = new DateTime(year, month, day, 0, 0);
    DateTime endTime = new DateTime(year, month, day, 23, 59);

    double totalTime = 0;

    return 3;
//    Map<String, double> usageTimes =
//        await _appUsageTime.getUsageStats(startTime, endTime);
//
//    usageTimes.forEach((name, time) => {
//          totalTime += time // TODO CHECK THAT THIS IS THE BEST WAY TO DO THIS
//        });
//
//    return _calculateTotalTimeScore(totalTime);
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
