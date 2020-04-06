import 'package:dissertation_project/bloc/settings/scaled_application/scaled_app_form_bloc.dart';
import 'package:dissertation_project/bloc/settings/scaled_time/scaled_time_form_bloc.dart';
import 'package:dissertation_project/bloc/settings/settings_event.dart';
import 'package:dissertation_project/bloc/settings/settings_state.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:dissertation_project/data/scaling_data/scale_values.dart';
import 'package:dissertation_project/data/time_scaler/comparable_time_of_day.dart';
import 'package:dissertation_project/data/time_scaler/scaled_score_time.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:dissertation_project/repositories/scaled_app_repository.dart';
import 'package:dissertation_project/repositories/scaled_time_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  ScaledAppRepository _scaledAppRepository =
      Injector.resolve<ScaledAppRepository>();

  ScaledTimeRepository _scaledTimeRepository =
      Injector.resolve<ScaledTimeRepository>();

  @override
  SettingsState get initialState => SettingsEmpty();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is LoadSettings) {
      try {
        final Map<String, ScaledApp> scaledApps =
            await _scaledAppRepository.getAllScaledApps();

        final List<ScaledScoreTime> scaledTimes =
            await _scaledTimeRepository.getScaledTimes();

        yield SettingsLoaded(
          scaledApps: scaledApps,
          scaledTimes: scaledTimes,
          doubleAppBloc:
              ScaledAppFormBloc(scaledApps: scaledApps, scaleFactor: BAD_SCALE),
          halfAppBloc: ScaledAppFormBloc(
              scaledApps: scaledApps, scaleFactor: GOOD_SCALE),
          doubleTimeBloc: ScaledTimeFormBloc(
              scaledTimes: scaledTimes, scaleFactor: BAD_SCALE),
          halfTimeBloc: ScaledTimeFormBloc(
              scaledTimes: scaledTimes, scaleFactor: GOOD_SCALE),
        );
      } catch (e) {
        print(e);
      }
    }
  }

  void addScaledApp(double scaleFactor, ScaledAppFormBloc bloc) {
    SettingsLoaded settingsLoaded = state as SettingsLoaded;
    int index = settingsLoaded.scaledApps.values
        .toList()
        .indexWhere((element) => element.getAppName() == bloc.textField.value);
    if (index >= 0) {
      settingsLoaded.scaledApps.values
          .toList()[index]
          .setScaleFactor(scaleFactor);
      settingsLoaded.doubleAppBloc
          .updateScaledApps((settingsLoaded.scaledApps));
      settingsLoaded.halfAppBloc.updateScaledApps((settingsLoaded.scaledApps));
      bloc.textField.clear();
      _scaledAppRepository.saveScaledApps(settingsLoaded.scaledApps);
    }
  }

  void removeScaledApp(ScaledApp scaledApp) {
    SettingsLoaded settingsLoaded = state as SettingsLoaded;
    settingsLoaded.scaledApps[scaledApp.getPackageName()].setScaleFactor(1);
    settingsLoaded.doubleAppBloc.updateScaledApps((settingsLoaded.scaledApps));
    settingsLoaded.halfAppBloc.updateScaledApps((settingsLoaded.scaledApps));
    _scaledAppRepository.saveScaledApps(settingsLoaded.scaledApps);
  }

  void addScaledTime(double scaleFactor, ScaledTimeFormBloc bloc) {
    SettingsLoaded settingsLoaded = state as SettingsLoaded;
    ScaledScoreTime scaledTime = ScaledScoreTime(
        ComparableTimeOfDay.fromTimeOfDay(bloc.startTimeFieldBloc.value),
        ComparableTimeOfDay.fromTimeOfDay(bloc.endTimeFieldBloc.value),
        scaleFactor);

    if (scaledTime.calculateTimeDifference() > 0) {
      List<ScaledScoreTime> overlappingTimes = settingsLoaded.scaledTimes
          .where((ScaledScoreTime element) => element.overlap(scaledTime))
          .toList();
      if (overlappingTimes.length > 0) {
        // TODO ASK IF USER WANTS TO REMOVE OTHERS
      } else {
        _addToScaleTimeList(scaledTime);
        settingsLoaded.doubleTimeBloc.updateScaledTimes(settingsLoaded.scaledTimes);
        settingsLoaded.halfTimeBloc.updateScaledTimes(settingsLoaded.scaledTimes);
        bloc.startTimeFieldBloc.clear();
        bloc.endTimeFieldBloc.clear();
        _scaledTimeRepository.storeScaledTimes(settingsLoaded.scaledTimes);
      }
    }
  }

  void removeScaledTime(ScaledScoreTime scaledTime) {
    SettingsLoaded settingsLoaded = state as SettingsLoaded;
    print(scaledTime.toString());
    print(scaledTime.getScaleFactor());
    settingsLoaded.scaledTimes.remove(scaledTime);
    settingsLoaded.doubleTimeBloc.updateScaledTimes(settingsLoaded.scaledTimes);
    settingsLoaded.halfTimeBloc.updateScaledTimes(settingsLoaded.scaledTimes);
    _scaledTimeRepository.storeScaledTimes(settingsLoaded.scaledTimes);
  }

  void _addToScaleTimeList(ScaledScoreTime scaleTime) {
    SettingsLoaded settingsLoaded = state as SettingsLoaded;
    settingsLoaded.scaledTimes.add(scaleTime);
  }
}
