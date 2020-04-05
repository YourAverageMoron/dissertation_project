import 'package:dissertation_project/bloc/settings/scaled_application/scaled_app_form_bloc.dart';
import 'package:dissertation_project/bloc/settings/scaled_time/scaled_time_form_bloc.dart';
import 'package:dissertation_project/bloc/settings/settings_event.dart';
import 'package:dissertation_project/bloc/settings/settings_state.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:dissertation_project/repositories/scaled_app_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  ScaledAppRepository _scaledAppRepository =
      Injector.resolve<ScaledAppRepository>();

  @override
  SettingsState get initialState => SettingsEmpty();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is LoadSettings) {
      try {
        final Map<String, ScaledApp> scaledApps =
            await _scaledAppRepository.getAllScaledApps();

        yield SettingsLoaded(
          scaledApps: scaledApps,
          doubleAppBloc:
              ScaledAppFormBloc(scaledApps: scaledApps, scaleFactor: 2.0),
          halfAppBloc:
              ScaledAppFormBloc(scaledApps: scaledApps, scaleFactor: 0.5),
          doubleTimeBloc:
              ScaledTimeFormBloc(scaledTimes: null, scaleFactor: 2.0),
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
    print(bloc.startTimeFieldBloc.value);
    print(bloc.endTimeFieldBloc.value);
  }
}
