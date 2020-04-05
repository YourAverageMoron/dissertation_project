import 'package:flutter_package_manager/flutter_package_manager.dart';

class PackageManagerRepository {
  Future<List> getInstalledPackages() async {
    List packages = await FlutterPackageManager.getInstalledPackages();
    return packages;
  }

  Future<PackageInfo> getPackageInfo(String packageName) async {
    PackageInfo info =
        await FlutterPackageManager.getPackageInfo(packageName);
    if (info == null) {
      //TODO IS THERE A BETTER WAY TO HANDLE THIS?
      info = PackageInfo.fromMap({
        'packageName': "Package name not found",
        'appIcon': null,
        'appName': "App Info not found"
      });
    }
    return info;
  }
}
