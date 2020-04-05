import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';
import 'package:dissertation_project/helpers/shared_preferences/scaled_score_times_preferences.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';

import '../data/time_scaler/comparable_time_of_day.dart';

class ScaledTimeRepository {
  ScaledScoreTimesPreferences _scaledScoreTimesPreferences =
      Injector.resolve<ScaledScoreTimesPreferences>();

  void storeScaledTimes(List<Object> scaledScoreTimes) {
    _scaledScoreTimesPreferences.storeScaleScoreTimes(scaledScoreTimes);
  }

  Future<List<ScaledScoreTime>> getAllScaledTimes(
      ComparableTimeOfDay endTime) async {
    List<ScaledScoreTime> scaledScoreTimes =
        _orderByStartTime(await _scaledScoreTimesPreferences.getScaledTimes());

    List<ScaledScoreTime> allTimes =
        _addScaledTimesToList(scaledScoreTimes, endTime);

    return allTimes;
  }

  List<ScaledScoreTime> _orderByStartTime(
      List<ScaledScoreTime> scaledScoreTimeList) {
    scaledScoreTimeList.sort((scaledScoreTimeA, scaledScoreTimeB) =>
        scaledScoreTimeA.compareTo(scaledScoreTimeB));
    return scaledScoreTimeList;
  }

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
}
