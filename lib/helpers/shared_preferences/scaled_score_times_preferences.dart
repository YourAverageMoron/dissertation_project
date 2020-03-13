import 'dart:convert';

import 'package:dissertation_project/data/time_scaler/comparable_time_of_day.dart';
import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';
import 'package:dissertation_project/helpers/shared_preferences/preference_keys.dart';
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

//TODO I THINK I SHOULD PULL SOME OF THE LOGIC OUT OF HERE
  // JUST HAVE SET AND GET JSON
class ScaledScoreTimesPreferences {

  void storeScaleScoreTimes(List<Object> scaledScoreTimes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = scaledScoreTimes.map((time) => jsonEncode(time)).toList();
    prefs.setStringList(SCALED_SCORE_TIMES_PREFS, list);
  }

  Future<List<ScaledScoreTime>> getScaledScoreTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringTimes =
        prefs.getStringList(SCALED_SCORE_TIMES_PREFS); //sort out the key
    List<Object> objectTimes = stringTimes
        .map((stringTime) => ScaledScoreTime.fromJson(jsonDecode(stringTime)))
        .toList();

    return _orderByStartTime(objectTimes);
  }

  Future<List<ScaledScoreTime>> getAllTimesScored(
      ComparableTimeOfDay endTime) async {
    List<ScaledScoreTime> scaledScoreTimes = await getScaledScoreTimes();

    List<ScaledScoreTime> allTimes =
        _addScaledTimesToList(scaledScoreTimes, endTime);

    return allTimes;
  }

  //TODO CAN YOU TIDY THIS UP ITS A BIT GRIM
  List<ScaledScoreTime> _addScaledTimesToList(
      List<ScaledScoreTime> scaledScoreTimes, ComparableTimeOfDay endTime) {

    List<ScaledScoreTime> allTimes = [];
    ComparableTimeOfDay startTime = ComparableTimeOfDay(hour: 0, minute: 0);

    for (ScaledScoreTime scaledTime in scaledScoreTimes) {
      if(scaledTime.getStartTime().compareTo(endTime) < 0) {
        allTimes = _addIndividualScaledTimeToList(
            ScaledScoreTime.fromTimeOfDay(
                startTime, scaledTime.getStartTime(), 1),
            allTimes);

        if(scaledTime.getEndTime().compareTo(endTime) < 0) {
          allTimes = _addIndividualScaledTimeToList(scaledTime, allTimes);
          startTime = scaledTime.getEndTime();
        }
        else{
          allTimes = _addIndividualScaledTimeToList(
              ScaledScoreTime.fromTimeOfDay(
                  scaledTime.getStartTime(), endTime, scaledTime.getScaleFactor()),
              allTimes);
          break;
        }
      }
      else{
        allTimes = _addIndividualScaledTimeToList(
            ScaledScoreTime.fromTimeOfDay(
                startTime, endTime, 1),
            allTimes);
        break;
      }
    }
    return allTimes;
  }

  List<ScaledScoreTime> _addIndividualScaledTimeToList(
      ScaledScoreTime scaledScoreTime,
      List<ScaledScoreTime> listOfScaledTimes) {
    if (scaledScoreTime.calculateTimeDifference() > 0) {
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
