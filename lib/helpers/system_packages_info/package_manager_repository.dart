import 'package:flutter_package_manager/flutter_package_manager.dart';

class PackageManagerRepository{

  Future<List> getInstalledPackages() async {
    List packages = await FlutterPackageManager.getInstalledPackages();
    return packages;
  }

  Future<PackageInfo> getPackageInfo(String packageName) async {
    final PackageInfo info =
    await FlutterPackageManager.getPackageInfo(packageName);
    return info;
  }
}