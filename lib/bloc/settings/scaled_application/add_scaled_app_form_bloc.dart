import 'package:dissertation_project/bloc/settings/scaled_application/scaled_app_list_bloc.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fuzzy/fuzzy.dart';

class AddScaledAppFormBloc extends FormBloc<String, String> {
  /// Blocs
  final ScaledAppListBloc scaledAppListBloc = ScaledAppListBloc();
  // ignore: close_sinks
  TextFieldBloc textField;

  List<ScaledApp> selectedApps = [];
  List<String> unselectedStrings = [];
  double scaleFactor;

  AddScaledAppFormBloc(
      {@required Map<String, ScaledApp> scaledApps,
      @required this.scaleFactor}) {
    textField = TextFieldBloc(suggestions: getSuggestions);
    addFieldBlocs(fieldBlocs: [textField]);
    updateScaledApps(scaledApps);
  }

  void updateScaledApps(Map<String, ScaledApp> scaledApps) {
    selectedApps = [];
    unselectedStrings = [];
    for (ScaledApp scaledApp in scaledApps.values) {
      if (scaledApp.getScaleFactor() == scaleFactor) {
        selectedApps.add(scaledApp);
      } else {
        unselectedStrings.add(scaledApp.getAppName());
      }
    }
    selectedApps.forEach((element) {
      print(element);
    });
    scaledAppListBloc.add(UpdateScaledAppList(scaledApps: selectedApps));
  }

  Future<List<String>> getSuggestions(String pattern) {
    final fuse = Fuzzy(unselectedStrings);
    final List<String> results =
        fuse.search(pattern).map((e) => e.item).toList();
    return new Future(() => results);
  }

  @override
  void onSubmitting() {
    //TODO implement
  }
}
