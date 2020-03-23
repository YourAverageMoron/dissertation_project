import 'package:dissertation_project/helpers/datetime_helpers.dart';
import 'package:flutter/material.dart';

class ComparableTimeOfDay extends TimeOfDay {

  final DateTimeHelpers _dateTimeHelpers = DateTimeHelpers();

  ComparableTimeOfDay({ @required hour, @required minute }): super(hour:hour, minute:minute);

  int compareTo(other){
    final now = new DateTime.now();
    DateTime thisDate = _dateTimeHelpers.timeOfDayToDate(now, this);
    DateTime otherDate = _dateTimeHelpers.timeOfDayToDate(now, other);
    return thisDate.compareTo(otherDate);
  }
}