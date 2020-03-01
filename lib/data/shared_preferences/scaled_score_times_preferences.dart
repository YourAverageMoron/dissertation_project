import 'dart:convert';

import 'package:dissertation_project/data/shared_preferences/preference_keys.dart';
import 'package:dissertation_project/data/time_scaler/comparable_time_of_day.dart';
import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO **REMOVE THIS** just for testing stuff if it is needed (also shows format)
var timeOfDay = [
  {
    'startTime': {
      'hour': 20,
      'minute': 0,
    },
    'endTime': {
      'hour': 22,
      'minute': 0,
    },
    'scaleFactor': 0.5
  },
  {
    'startTime': {
      'hour': 4,
      'minute': 0,
    },
    'endTime': {
      'hour': 5,
      'minute': 0,
    },
    'scaleFactor': 0.5
  },
  {
    'startTime': {
      'hour': 14,
      'minute': 0,
    },
    'endTime': {
      'hour': 16,
      'minute': 0,
    },
    'scaleFactor': 5
  },
];

class ScaledScoreTimesPreferences {
  //TODO tidy this ups
  void storeScaleScoreTimes(List<Object> scaledScoreTimes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = scaledScoreTimes.map((time) => jsonEncode(time)).toList();
    prefs.setStringList(SCALED_SCORE_TIMES, list);
  }

  //TODO THIS WILL NEED A TRY CATCH TO RETURN A [] IF THERE ISNT A KEY MATCHING
  Future<List<ScaledScoreTime>> getScaledScoreTimes() async {
    //TODO HAVE THIS AS A CLASS LEVEL OBJECT -> WILL OTHER METHODS NEED IT?
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringTimes =
        prefs.getStringList(SCALED_SCORE_TIMES); //sort out the key
    //TODO TIDY THIS UP?
    List<Object> objectTimes = stringTimes
        .map((stringTime) => ScaledScoreTime.fromJson(jsonDecode(stringTime)))
        .toList();

    return _orderByStartTime(objectTimes);
  }

  Future<List<ScaledScoreTime>> getAllTimesScored() async {
    List<ScaledScoreTime> scaledScoreTime = await getScaledScoreTimes();

    List<ScaledScoreTime> allTimes = [];
    ComparableTimeOfDay startTime = ComparableTimeOfDay(hour: 0, minute: 0);

    for (ScaledScoreTime scaledTime in scaledScoreTime) {
      allTimes = _addScaledTimeToList(ScaledScoreTime.fromTimeOfDay(
          startTime, scaledTime.getStartTime(), 1), allTimes);
      allTimes = _addScaledTimeToList(scaledTime, allTimes);
      startTime = scaledTime.getEndTime();
    }

    allTimes.add(ScaledScoreTime.fromTimeOfDay(
        startTime, ComparableTimeOfDay(hour: 23, minute: 59), 1));

    return allTimes;
  }

  List<ScaledScoreTime> _addScaledTimeToList(ScaledScoreTime scaledScoreTime,
      List<ScaledScoreTime> listOfScaledTimes) {
    if(scaledScoreTime.calculateTimeDifference() > 0) {
      listOfScaledTimes.add(scaledScoreTime);
    }
    return listOfScaledTimes;
  }

  List<ScaledScoreTime> _orderByStartTime(
      List<ScaledScoreTime> scaledScoreTimeList) {
    scaledScoreTimeList.sort((scaledScoreTimeA, scaledScoreTimeB) =>
        scaledScoreTimeA.compareTo(scaledScoreTimeB));
    return scaledScoreTimeList;
  }
}
