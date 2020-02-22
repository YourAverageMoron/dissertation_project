import 'package:dissertation_project/data/phone_usage/app_usage_time.dart';
import 'package:dissertation_project/data/time_scaler/time_scaler.dart';
import 'package:flutter/material.dart';

// TODO JUST USE JSON OBJECTS SHARED PREFERENCES?
final doubleTimes = [new TimeScaler(TimeOfDay(hour:4, minute: 0), TimeOfDay(hour:5,minute: 0), 5)];

// TODO Static?
class Score {


  //TODO handle different time periods in this
  static Future<int> _getTotalTimeScore(DateTime date) async{

    int year = date.year;
    int month = date.month;
    int day = date.day;

    DateTime startTime = new DateTime(year, month, day, 0, 0);
    DateTime endTime = new DateTime(year, month, day, 23, 59);

    double totalTime = 0;

    Map<String, double> usageTimes = await AppUsageTime.getUsageStats(startTime, endTime);

    usageTimes.forEach((name, time) => {
      totalTime += time // TODO CHECK THAT THIS IS THE BEST WAY TO DO THIS
    });

    return _calculateTotalTimeScore(totalTime);
  }


  static int _calculateTotalTimeScore(double timeUsed){
    // TODO THIS IS JUST DOING THE PERCENTAGE TIME USED
    print(((1 - timeUsed/86400)*100).round());
    return ((1 - timeUsed/86400)*100).round();
  }


  static Future<int> generateScore(DateTime date){
    return _getTotalTimeScore(date);
  }



}