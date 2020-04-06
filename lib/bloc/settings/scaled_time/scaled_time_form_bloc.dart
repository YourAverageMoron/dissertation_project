import 'package:dissertation_project/bloc/settings/scaled_time/scaled_time_list_bloc.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:dissertation_project/data/time_scaler/comparable_time_of_day.dart';
import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';
import 'package:dissertation_project/helpers/datetime_helpers.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ScaledTimeFormBloc extends FormBloc<String, String> {
  DateTimeHelpers _dateTimeHelpers = Injector.resolve<DateTimeHelpers>();

  List<ScaledScoreTime> _scaledTimes;

  /// Blocs
  final ScaledTimeListBloc scaledTimeListBloc = ScaledTimeListBloc();

  // ignore: close_sinks
  InputFieldBloc startTimeFieldBloc;

  // ignore: close_sinks
  InputFieldBloc endTimeFieldBloc;
  List<ScaledApp> selectedTimes = [];
  double scaleFactor;

  ScaledTimeFormBloc(
      {@required List<ScaledScoreTime> scaledTimes,
      @required this.scaleFactor}) {
    _scaledTimes = scaledTimes;
    startTimeFieldBloc = InputFieldBloc<TimeOfDay, Object>();
    endTimeFieldBloc = InputFieldBloc<TimeOfDay, Object>();

    startTimeFieldBloc
      ..subscribeToFieldBlocs([endTimeFieldBloc])
      ..addValidators(
        [
          _startTimeIsBeforeEndTimeValidator(endTimeFieldBloc),
          _startTimeOverlapValidator(endTimeFieldBloc)
        ],
      );

    endTimeFieldBloc
      ..subscribeToFieldBlocs([startTimeFieldBloc])
      ..addValidators(
        [
          _endTimeIsAfterStartTimeValidator(startTimeFieldBloc),
          _endTimeOverlapValidator(startTimeFieldBloc)
        ],
      );

    addFieldBlocs(fieldBlocs: [startTimeFieldBloc, endTimeFieldBloc]);
  }

  void updateScaledTimes(List<ScaledScoreTime> scaledTimes) {
    _scaledTimes = scaledTimes;
    scaledTimeListBloc.add(UpdateScaledTimesList(scaledTimes: scaledTimes));
  }

  Validator<dynamic> _startTimeOverlapValidator(
      InputFieldBloc endTimeFieldBloc) {
    return (dynamic startTimeOfDay) {
      if (startTimeOfDay != null && endTimeFieldBloc.value != null) {
        ScaledScoreTime scaledTime = ScaledScoreTime(
            ComparableTimeOfDay.fromTimeOfDay(startTimeOfDay),
            ComparableTimeOfDay.fromTimeOfDay(endTimeFieldBloc.value),
            1);
        List<ScaledScoreTime> overlappingTimes = _scaledTimes
            .where((ScaledScoreTime element) => element.overlap(scaledTime))
            .toList();
        if (overlappingTimes.length > 0) {
          return "Time frame overlaps with:";
        }
      }
      return null;
    };
  }

  Validator<dynamic> _endTimeOverlapValidator(
      InputFieldBloc startTimeFieldBloc) {
    return (dynamic endTimeOfDay) {
      if (endTimeOfDay != null && startTimeFieldBloc.value != null) {
        ScaledScoreTime scaledTime = ScaledScoreTime(
            ComparableTimeOfDay.fromTimeOfDay(startTimeFieldBloc.value),
            ComparableTimeOfDay.fromTimeOfDay(endTimeOfDay),
            1);
        List<ScaledScoreTime> overlappingTimes = _scaledTimes
            .where((ScaledScoreTime element) => element.overlap(scaledTime))
            .toList();
        if (overlappingTimes.length > 0) {
          return "${overlappingTimes[0].getScaleFactor() == 2 ? "Good" : "Bad"} - ${overlappingTimes[0].toString()}";
        }
      }
      return null;
    };
  }

  Validator<dynamic> _startTimeIsBeforeEndTimeValidator(
      InputFieldBloc endTimeFieldBloc) {
    return (dynamic startTimeOfDay) {
      if (startTimeOfDay != null && endTimeFieldBloc.value != null) {
        if (_startTimeBeforeEndTime(startTimeOfDay, endTimeFieldBloc.value)) {
          return "Start time must be";
        }
      }
      return null;
    };
  }

  Validator<dynamic> _endTimeIsAfterStartTimeValidator(
      InputFieldBloc startTimeFieldBloc) {
    return (dynamic endTimeOfDay) {
      if (endTimeOfDay != null && startTimeFieldBloc.value != null) {
        if (_startTimeBeforeEndTime(startTimeFieldBloc.value, endTimeOfDay)) {
          return "before the end time";
        }
      }
      return null;
    };
  }

  bool _startTimeBeforeEndTime(TimeOfDay startTime, TimeOfDay endTime) {
    return _calculateDifference(startTime, endTime) <= 0;
  }

  int _calculateDifference(TimeOfDay startTime, TimeOfDay endTime) {
    DateTime date = DateTime.now();
    DateTime startDateTime = _dateTimeHelpers.timeOfDayToDate(date, startTime);
    DateTime endDateTime = _dateTimeHelpers.timeOfDayToDate(date, endTime);
    return endDateTime.difference(startDateTime).inMilliseconds;
  }

  @override
  void onSubmitting() {}
}
