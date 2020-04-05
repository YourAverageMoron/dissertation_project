import 'dart:convert';

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

  Future<List<ScaledScoreTime>> getScaledTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringTimes =
        prefs.getStringList(SCALED_SCORE_TIMES_PREFS); //sort out the key
    List<ScaledScoreTime> objectTimes = [];
    if (stringTimes != null) {
      objectTimes = stringTimes
          .map((stringTime) => ScaledScoreTime.fromJson(jsonDecode(stringTime)))
          .toList();
    }
    return objectTimes;
  }
}
