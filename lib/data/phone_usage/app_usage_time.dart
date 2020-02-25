//TODO COULD GET THE APP NAMES AND ICONS AND STUFF HERE?
class AppUsageTime{

  String _packageName;
  double _timeInForground;
  int _launchCount;

  AppUsageTime(this._packageName, this._timeInForground, this._launchCount);

  AppUsageTime.fromJson(Map<String, dynamic> json) {
    _packageName = json['packageName'];
    _timeInForground = json['timeInForground'];
    _launchCount = json['launchCount'];
  }

  String getPackageName(){ return _packageName; }
  double getTimeInForground(){ return _timeInForground; }
  int getLaunchCount(){ return _launchCount; }
}