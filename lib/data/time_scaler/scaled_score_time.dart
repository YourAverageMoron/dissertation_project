import 'package:dissertation_project/helpers/datetime_helpers.dart';

import 'comparable_time_of_day.dart';

class ScaledScoreTime extends Comparable {
  ComparableTimeOfDay _startTime;
  ComparableTimeOfDay _endTime;
  double _scaleFactor;
  DateTimeHelpers _dateTimeHelpers = DateTimeHelpers();

  ScaledScoreTime(this._startTime, this._endTime, this._scaleFactor);

  ScaledScoreTime.fromTimeOfDay(ComparableTimeOfDay startTime,
      ComparableTimeOfDay endTime, double scaleFactor) {
    _startTime = startTime;
    _endTime = endTime;
    _scaleFactor = scaleFactor;
  }

  ScaledScoreTime.fromJson(Map<String, dynamic> json) {
    final _startTimeJson = json['startTime'];
    final _endTimeJson = json['endTime'];
    _startTime = new ComparableTimeOfDay(
        hour: _startTimeJson['hour'], minute: _startTimeJson['minute']);
    _endTime = new ComparableTimeOfDay(
        hour: _endTimeJson['hour'], minute: _endTimeJson['minute']);
    _scaleFactor = json['scaleFactor'].toDouble();
  }

  Map<String, dynamic> toJson() => {
        'startTime': {
          'hour': _startTime.hour,
          'minute': _startTime.minute,
        },
        'endTime': {
          'hour': _endTime.hour,
          'minute': _endTime.minute,
        },
        'scaleFactor': _scaleFactor
      };

  ComparableTimeOfDay getStartTime() {
    return _startTime;
  }

  ComparableTimeOfDay getEndTime() {
    return _endTime;
  }

  double getScaleFactor() {
    return _scaleFactor;
  }

  void setStartTime(ComparableTimeOfDay startTime) {
    _startTime = startTime;
  }

  void setEndTime(ComparableTimeOfDay endTime) {
    _endTime = endTime;
  }

  void setScaleFactor(double scaleFactor) {
    _scaleFactor = scaleFactor;
  }

  @override
  int compareTo(other) {
    return _startTime.compareTo(other.getStartTime());
  }

  int calculateTimeDifference() {
    DateTime date = DateTime.now();
    DateTime startDateTime = _dateTimeHelpers.timeOfDayToDate(date, _startTime);
    DateTime endDateTime = _dateTimeHelpers.timeOfDayToDate(date, _endTime);
    return endDateTime.difference(startDateTime).inMilliseconds;
  }
}
