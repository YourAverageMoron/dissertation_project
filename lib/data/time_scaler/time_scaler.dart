import 'package:flutter/material.dart';

//TODO BUILDER PATTERN? OR SOMETHING LIKE THAT
class TimeScaler {

  TimeOfDay _startTime;
  TimeOfDay _endTime;
  double _scaleFactor;

  TimeScaler(TimeOfDay startTime, TimeOfDay endTime, double scaleFactor){
    _startTime = startTime;
    _endTime = endTime;
    _scaleFactor = scaleFactor;
  }

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