import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:dissertation_project/helpers/shared_preferences/scaled_apps_preferences.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:dissertation_project/repositories/package_manager_repository.dart';
import 'package:dissertation_project/repositories/scaled_app_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiwi/kiwi.dart';
import 'package:mockito/mockito.dart';

import 'scale_app_repository_test_data.dart';

class MockScaledAppPreferences extends Mock implements ScaledAppPreferences {}

class MockPackageManagerRepository extends Mock
    implements PackageManagerRepository {}

void main() {
  setUpAll(() {
    Injector.setup();
    Container container = Injector.container;
    container.clear();

    ScaledAppPreferences scaledAppPreferences = MockScaledAppPreferences();
    when(scaledAppPreferences.getScaledApps())
        .thenAnswer((_) => futureScaledApps);
    container.registerInstance(scaledAppPreferences);

    PackageManagerRepository packageManagerRepository =
        MockPackageManagerRepository();
    when(packageManagerRepository.getInstalledPackages())
        .thenAnswer((_) => futureInstalledPackages);
    when(packageManagerRepository.getPackageInfo(argThat(isNotNull)))
        .thenAnswer((_) => futurePackageInfo);
    container.registerInstance(packageManagerRepository);
  });

  test('Should generate all scaled apps for all packages', () async {
    ScaledAppRepository scaledAppRepository = ScaledAppRepository();
    Map<String, ScaledApp> result =
        await scaledAppRepository.getAllScaledApps();
    for (String installedPackage in installedPackages) {
      expect(result[installedPackage].getPackageName(), installedPackage);
      expect(result[installedPackage].getAppName(), packageInfo.appName);
      expect(result[installedPackage].getIcon(), null);

      if (scaledAppsNames.contains(installedPackage)) {
        expect(result[installedPackage].getScaleFactor(),
            result[installedPackage].getScaleFactor());
      } else {
        expect(result[installedPackage].getScaleFactor(), 1);
      }
    }
  });

  test('Should generate scaled apps for user edited scaled apps', () async {
    ScaledAppRepository scaledAppRepository = ScaledAppRepository();
    Map<String, ScaledApp> result =
        await scaledAppRepository.getUserScaledApps();
    for (String scaledAppsName in scaledAppsNames) {
      expect(result[scaledAppsName].getPackageName(), scaledAppsName);
      expect(result[scaledAppsName].getAppName(), packageInfo.appName);
      expect(result[scaledAppsName].getIcon(), null);
      expect(result[scaledAppsName].getScaleFactor(),
          result[scaledAppsName].getScaleFactor());
    }
  });
}
