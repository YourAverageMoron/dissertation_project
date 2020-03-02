import 'package:dissertation_project/data/phone_usage/app_usage_statistic.dart';
import 'package:test/test.dart';

void main(){
  group('Initializing usage statistic', () {
    final String packageName = 'packageName';
    final double timeInForground = 100;
    final int launchCount = 3;

    test('Should create usage statictic from constructor', () {
      final AppUsageStat appUsageStat = AppUsageStat(packageName, timeInForground, launchCount);
      expect(appUsageStat.getPackageName(), packageName);
      expect(appUsageStat.getTimeInForground(), timeInForground);
      expect(appUsageStat.getLaunchCount(), launchCount);
    });

    test('Should create usage statistic from JSON', () {
      final Map<String, dynamic> json = {
        'packageName': packageName,
        'timeInForground': timeInForground,
        'launchCount': launchCount
      };

      final AppUsageStat appUsageStat = AppUsageStat.fromJson(json);
      expect(appUsageStat.getPackageName(), packageName);
      expect(appUsageStat.getTimeInForground(), timeInForground);
      expect(appUsageStat.getLaunchCount(), launchCount);
    });
  });
}