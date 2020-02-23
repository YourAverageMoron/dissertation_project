import 'dart:convert';

import 'package:dissertation_project/data/shared_preferences/preference_keys.dart';
import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO **REMOVE THIS** just for testing stuff if it is needed (also shows format)
var timeOfDay = [
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

  Future<List<ScaledScoreTime>> getScaledScoreTimes() async {
    //TODO HAVE THIS AS A CLASS LEVEL OBJECT -> WILL OTHER METHODS NEED IT?
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringTimes =
        prefs.getStringList(SCALED_SCORE_TIMES); //sort out the key
    //TODO TIDY THIS UP?
    return stringTimes
        .map((stringTime) => ScaledScoreTime.fromJson(jsonDecode(stringTime)))
        .toList();
  }
}
