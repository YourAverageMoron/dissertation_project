//TODO COULD GET THE APP NAMES AND ICONS AND STUFF HERE?
class AppUsageStat{

  String _packageName;
  double _timeInForground;
  int _launchCount;

  AppUsageStat(this._packageName, this._timeInForground, this._launchCount);

  AppUsageStat.fromJson(Map<String, dynamic> json) {
    _packageName = json['packageName'];
    _timeInForground = json['timeInForground'].toDouble();
    _launchCount = json['launchCount'];
  }

  String getPackageName(){ return _packageName; }
  double getTimeInForground(){ return _timeInForground; }
  int getLaunchCount(){ return _launchCount; }
}