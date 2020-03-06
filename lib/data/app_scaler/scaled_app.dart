class ScaledApp{
  String _packageName;
  String _appName;
  //TODO WHAT FORMAT IS THE IMAGE?
  double _scaleFactor;

  ScaledApp(String packageName, String appName, double scaleFactor){
    _packageName = packageName;
    _appName = appName;
    _scaleFactor = scaleFactor;
  }

  String getPackageName(){
    return _packageName;
  }

  String getAppName(){
    return _appName;
  }

  double getScaleFactor(){
    return _scaleFactor;
  }
}