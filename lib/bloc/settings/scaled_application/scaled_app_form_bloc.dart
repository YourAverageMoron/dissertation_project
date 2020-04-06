import 'package:dissertation_project/bloc/settings/scaled_application/scaled_app_list_bloc.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fuzzy/fuzzy.dart';

class ScaledAppFormBloc extends FormBloc<String, String> {
  /// Blocs
  final ScaledAppListBloc scaledAppListBloc = ScaledAppListBloc();
  // ignore: close_sinks
  TextFieldBloc textField;

  List<ScaledApp> selectedApps = [];
  List<String> unselectedStrings = [];
  double scaleFactor;

  ScaledAppFormBloc({@required Map<String, ScaledApp> scaledApps,
    @required this.scaleFactor}) {
    textField = TextFieldBloc(
        suggestions: _getSuggestions,
        validators: [_textFieldValidator],
        asyncValidatorDebounceTime: Duration(milliseconds: 300),
    );
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
    scaledAppListBloc.add(UpdateScaledAppList(scaledApps: selectedApps));
  }

  @override
  void onSubmitting() {}

  Future<List<String>> _getSuggestions(String pattern) {
    final fuse = Fuzzy(unselectedStrings);
    final List<String> results =
    fuse.search(pattern).map((e) => e.item).toList();
    return new Future(() => results);
  }

  String _textFieldValidator(String string){
    if(unselectedStrings.contains(string)){
      return null;
    }
    return "Not an installed application";
  }
}
