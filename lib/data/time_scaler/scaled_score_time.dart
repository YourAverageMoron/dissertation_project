import 'package:flutter/material.dart';

class ScaledScoreTime {

  TimeOfDay _startTime;
  TimeOfDay _endTime;
  double _scaleFactor;

  ScaledScoreTime(this._startTime, this._endTime, this._scaleFactor);

  ScaledScoreTime.fromJson(Map<String, dynamic> json){
  final _startTimeJson = json['startTime'];
  final _endTimeJson = json['endTime'];
  _startTime = new TimeOfDay(hour: _startTimeJson['hour'], minute: _startTimeJson['minute']);
  _endTime = new TimeOfDay(hour: _endTimeJson['hour'], minute: _endTimeJson['minute']);
  _scaleFactor = json['scaleFactor'];
}

  Map<String, dynamic> toJson() =>
      {
        'startTime': {
          'hour': _startTime.hour,
          'minute':_startTime.minute,
        },
        'endTime': {
          'hour': _endTime.hour,
          'minute':_endTime.minute,
        },
        'scaleFactor': _scaleFactor
      };

  TimeOfDay getStartTime(){
    return _startTime;
  }

  TimeOfDay getEndTime(){
    return _endTime;
  }

  double getScaleFactor(){
    return _scaleFactor;
  }

  void setStartTime(TimeOfDay startTime){
    _startTime = startTime;
  }

  void setEndTime(TimeOfDay endTime){
    _endTime = endTime;
  }

  void setScaleFactor(double scaleFactor){
    _scaleFactor = scaleFactor;
  }
}