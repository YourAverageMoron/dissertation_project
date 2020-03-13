import 'package:dissertation_project/bloc/settings/scaled_application/scaled_application_event.dart';
import 'package:dissertation_project/bloc/settings/scaled_application/scaled_application_state.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app_repository.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScaledApplicationBloc
    extends Bloc<ScaledApplicationEvent, ScaledApplicationState> {
  final ScaledAppRepository _scaledAppRepository =
      Injector.resolve<ScaledAppRepository>();

  @override
  ScaledApplicationState get initialState => ScaledApplicationsLoading();

  @override
  Stream<ScaledApplicationState> mapEventToState(
      ScaledApplicationEvent event) async* {
    if (event is LoadScaledApp) {
      yield* _mapLoadScaledAppToState();
    } else if (event is AddScaledApp) {
      yield* _mapAddScaledAppToState(event);
    } else if (event is UpdateScaledApp) {
      yield* _mapUpdateScaledAppToState(event);
    } else if (event is DeleteScaledApp) {
      yield* _mapDeleteScaledAppToState(event);
    } else if (event is ScaledAppFormEvent) {
      yield* _mapScaledAppFormToState(event);
    }
  }

  Stream<ScaledApplicationState> _mapLoadScaledAppToState() async* {
    try {
      final Map<String, ScaledApp> scaledApps =
          await _scaledAppRepository.getUserScaledApps();

      yield ScaledApplicationsLoaded(scaledApps);
    } catch (e) {
      yield ScaledApplicationsNotLoaded();
    }
  }

  Stream<ScaledApplicationState> _mapAddScaledAppToState(
      AddScaledApp event) async* {
    if (state is ScaledApplicationFormState) {
      final Map<String, ScaledApp> scaledApps =
        await _scaledAppRepository.getUserScaledApps();
      scaledApps[event.scaledApp.getPackageName()] = event.scaledApp;
      yield ScaledApplicationsLoaded(scaledApps);
      _saveScaledApps(scaledApps);
    }
  }

  Stream<ScaledApplicationState> _mapUpdateScaledAppToState(
      UpdateScaledApp event) async* {
    if (state is ScaledApplicationsLoaded) {
      final Map<String, ScaledApp> scaledApps =
          Map.from((state as ScaledApplicationsLoaded).scaledApps);
      scaledApps[event.scaledApp.getPackageName()] = event.scaledApp;
      yield ScaledApplicationsLoaded(scaledApps);
      _saveScaledApps(scaledApps);
    }
  }

  Stream<ScaledApplicationState> _mapDeleteScaledAppToState(
      DeleteScaledApp event) async* {
    if (state is ScaledApplicationsLoaded) {
      final Map<String, ScaledApp> scaledApps =
          Map.from((state as ScaledApplicationsLoaded).scaledApps);
      scaledApps.remove(event.scaledApp.getPackageName());
      yield ScaledApplicationsLoaded(scaledApps);
      _saveScaledApps(scaledApps);
    }
  }

  Stream<ScaledApplicationState> _mapScaledAppFormToState(
      ScaledAppFormEvent event) async* {
    yield ScaledApplicationFormState(event.scaledApp);
  }

  void _saveScaledApps(Map<String, ScaledApp> scaledApps) {
    _scaledAppRepository.saveScaledApps(scaledApps);
  }
}
