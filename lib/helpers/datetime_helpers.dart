import 'package:flutter/material.dart';

class DateTimeHelpers {

  DateTime timeOfDayToDate(DateTime dateTime, TimeOfDay timeOfDay) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, timeOfDay.hour,
        timeOfDay.minute);
  }
}
