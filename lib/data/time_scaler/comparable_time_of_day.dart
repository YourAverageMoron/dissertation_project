import 'package:flutter/material.dart';

class ComparableTimeOfDay extends TimeOfDay {

  ComparableTimeOfDay({ @required hour, @required minute }): super(hour:hour, minute:minute);

  int compareTo(other){
    final now = new DateTime.now();
    DateTime thisDate = new DateTime(
        now.year, now.month, now.day, this.hour, this.minute);
    DateTime otherDate = new DateTime(now.year, now.month, now.day,
        other.hour, other.minute);
    return thisDate.compareTo(otherDate);
  }
}