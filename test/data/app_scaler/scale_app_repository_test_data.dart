import 'package:flutter_package_manager/flutter_package_manager.dart';

final List<Map<String, dynamic>> scaledApps = [
  {
    'packageName': 'Instagram',
    'scaleFactor': 5,
  },
  {
    'packageName': 'Twitter',
    'scaleFactor': 2,
  },
  {
    'packageName': 'Medium',
    'scaleFactor': 0.5,
  },
  {
    'packageName': 'Facebook',
    'scaleFactor': 3,
  },
];
final Future<List<Map<String, dynamic>>> futureScaledApps =
    new Future(() => scaledApps);
List scaledAppsNames = ['Instagram', 'Twitter', 'Medium', 'Facebook'];

final List<String> installedPackages = [
  'Instagram',
  'Twitter',
  'Medium',
  'Facebook',
  'Youtube',
];
final Future<List<String>> futureInstalledPackages =
    new Future(() => installedPackages);

final PackageInfo packageInfo = PackageInfo.fromMap(
    {'packageName': "PackageName", 'appName': "AppName", 'appIcon': null});

final Future<PackageInfo> futurePackageInfo = new Future(() => packageInfo);
