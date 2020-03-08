import 'dart:convert';

import 'package:dissertation_project/helpers/shared_preferences/preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO THIS IS A TEMPLATE -> ALSO PACKAGE NAME IS V WRONG
List<Map<String, dynamic>> scaledApps = [
  {
    'packageName': 'Instagram',
    'scaleFactor': 5,
  },
  {
    'packageName': 'Twitter',
    'scaleFactor': 2,
  },
  {
    'packageName': 'Medium',
    'scaleFactor': 0.5,
  },
  {
    'packageName': 'Facebook',
    'scaleFactor': 3,
  },
];

class ScaledAppPreferences {
  void storeScaledApps(List<Object> scaledApps) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = scaledApps.map((app) => jsonEncode(app)).toList();
    prefs.setStringList(SCALED_APPS_PREFS, list);
  }

  Future<List<Map<String, dynamic>>> getScaledApps() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> stringApps = prefs.getStringList(SCALED_APPS_PREFS);
      List<Map<String, dynamic>> list = [];
      stringApps.forEach((app) => list.add(jsonDecode(app)));
      return list;
    } catch (e) {
      //TODO is there a better way to handle this?
      print(e);
      return [];
    }
  }
}
