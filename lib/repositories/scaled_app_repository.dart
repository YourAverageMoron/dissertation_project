import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:dissertation_project/helpers/shared_preferences/scaled_apps_preferences.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:dissertation_project/repositories/package_manager_repository.dart';
import 'package:flutter_package_manager/flutter_package_manager.dart';

class ScaledAppRepository {
  ScaledAppPreferences _scaledAppPreferences =
  Injector.resolve<ScaledAppPreferences>();
  PackageManagerRepository _packageManagerRepository =
  Injector.resolve<PackageManagerRepository>();

  Future<Map<String, ScaledApp>> getAllScaledApps() async {
    List<dynamic> packages =
    await _packageManagerRepository.getInstalledPackages();

    Map<String, ScaledApp> scaledApps = {};
    for (String package in packages) {
      scaledApps[package] = await _createScaledApp(package, 1);
    }

    List<Map<String, dynamic>> jsonApps =
    await _scaledAppPreferences.getScaledApps();

    for (Map<String, dynamic> jsonApp in jsonApps) {
      scaledApps[jsonApp['packageName']]
          .setScaleFactor(jsonApp['scaleFactor'].toDouble());
    }

    return scaledApps;
  }

  Future<Map<String, ScaledApp>> getUserScaledApps() async {
    List<Map<String, dynamic>> jsonApps =
    await _scaledAppPreferences.getScaledApps();

    Map<String, ScaledApp> scaledApps = {};
    for (Map<String, dynamic> jsonApp in jsonApps) {
      scaledApps[jsonApp['packageName']] = await _createScaledApp(
          jsonApp['packageName'], jsonApp['scaleFactor'].toDouble());
    }
    return scaledApps;
  }

  Future<void> saveScaledApps(Map<String, ScaledApp> scaledApps) async {
    List<Map<String, dynamic>> jsonScaledApps = [];
    scaledApps.forEach((key, value) =>
        jsonScaledApps.add(
            {
              'packageName': value.getPackageName(),
              'scaleFactor': value.getScaleFactor()
            }));

    _scaledAppPreferences.storeScaledApps(jsonScaledApps);
  }

  Future<ScaledApp> _createScaledApp(String packageName,
      double scaleFactor) async {
    PackageInfo packageInfo =
    await _packageManagerRepository.getPackageInfo(packageName);
    return ScaledApp(
        packageName: packageName,
        appName: packageInfo.appName,
        icon: packageInfo.getAppIcon(),
        scaleFactor: scaleFactor);
  }
}
