import 'package:flutter/cupertino.dart';

class ScaledApp {
  String _packageName;
  String _appName;
  Image _icon;
  double _scaleFactor;

  ScaledApp(
      {@required String packageName,
        @required String appName,
        @required double scaleFactor,
        @required Image icon}) {
    _packageName = packageName;
    _appName = appName;
    _scaleFactor = scaleFactor;
    _icon = icon;
  }

  String getPackageName() {
    return _packageName;
  }

  String getAppName() {
    return _appName;
  }

  double getScaleFactor() {
    return _scaleFactor;
  }

  void setScaleFactor(double scaleFactor) {
    _scaleFactor = scaleFactor;
  }

  Image getIcon() {
    return _icon;
  }
}
