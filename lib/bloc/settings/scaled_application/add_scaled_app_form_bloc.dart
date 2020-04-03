import 'package:dissertation_project/bloc/settings/scaled_application/scaled_app_list_bloc.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app_repository.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fuzzy/fuzzy.dart';

class AddScaledAppFormBloc extends FormBloc<String, String> {
  final _scaledAppRepository = Injector.resolve<ScaledAppRepository>();


  static final List<ScaledApp> unselectedApps = [
    ScaledApp(
        appName: "name1", packageName: "package1", icon: null, scaleFactor: 1),
    ScaledApp(
        appName: "name2", packageName: "package2", icon: null, scaleFactor: 1),
  ];
  static final List<String> unselectedStrings = ["name1", "name2"];

  final List<ScaledApp> selectedApps = [];

  AddScaledAppFormBloc() {
    addFieldBlocs(fieldBlocs: [
      textField,
    ]);
  }

  static Future<List<String>> getSuggestions(String pattern) {
    final fuse = Fuzzy(unselectedStrings);
    final List<String> results =
        fuse.search(pattern, 5).map((e) => e.item).toList();
    return new Future(() => results);
  }

  final textField = TextFieldBloc(
    suggestions: getSuggestions,
  );

  void addScaledApp(ScaledAppListBloc scaledAppListBloc, double scaleFactor) {
    int chosenAppIndex = unselectedApps
        .indexWhere((element) => element.getAppName() == textField.value);
    if (chosenAppIndex >= 0) {
      unselectedApps[chosenAppIndex].setScaleFactor(scaleFactor);
      selectedApps.add(unselectedApps[chosenAppIndex]);
      scaledAppListBloc.add(UpdateScaledAppList(scaledApps: selectedApps));
      unselectedApps.removeAt(chosenAppIndex);
      unselectedStrings.remove(textField.value);
      textField.clear();
      //TODO SAVE THESE TO A UNION OF SELECTEDAPPS AND UNSELECTEDAPPS
        //OR I MIGHT JUST SAVE THE SELECTED APPS (LOOK AT OLD VERSION)
    }else{
      //TODO YOU COULD RETURN A COMMENT SAYING APP DOESNT EXITS OR SOMETHING
    }
  }

  void removeScaledApp(
      ScaledAppListBloc scaledAppListBloc, ScaledApp scaledApp) {
    int chosenAppIndex = selectedApps
        .indexWhere((element) => element == scaledApp);
    if (chosenAppIndex >= 0) {
      selectedApps[chosenAppIndex].setScaleFactor(1);
      unselectedApps.add(scaledApp);
      selectedApps.removeAt(chosenAppIndex);
      scaledAppListBloc.add(UpdateScaledAppList(scaledApps: selectedApps));
      unselectedStrings.add(scaledApp.getAppName());
      //TODO SAVE THESE TO A UNION OF SELECTEDAPPS AND UNSELECTEDAPPS
        //OR I MIGHT JUST SAVE THE SELECTED APPS (LOOK AT OLD VERSION)
    }else{
      //TODO THIS SHOULD NEVER HAPPEN
    }

  }

  @override
  void onSubmitting() {
    //TODO implement
  }

  @override
  Stream<void> onEvent(FormBlocEvent event) async* { //TODO MAYBE NEEDS TO YEILD A STATE?
    if (event is LoadFormBloc) {
      final Map<String, ScaledApp> scaledApps =
          await _scaledAppRepository.getAllScaledApps();

      for(ScaledApp scaledApp in scaledApps.values){
        if(scaledApp.getScaleFactor() == 2.0){
          //todo Add to scaled apps list
        }
        else{
          //todo ADD TO UNSCALED APPS LIST
        }
      }
    }
  }
}
