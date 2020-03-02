import 'package:dissertation_project/data/phone_usage/app_usage_statistic.dart';
import 'package:dissertation_project/data/phone_usage/get_app_usage_times.dart';
import 'package:dissertation_project/data/phone_usage/phone_usage_statistics.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:kiwi/kiwi.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockGetAppUsageTimes extends Mock implements GetAppUsageTimes {}

void main() {
  final AppUsageStat appUsageStat1 = AppUsageStat.fromJson(
      {'packageName': 'package1', 'timeInForground': 100, 'launchCount': 3});
  final AppUsageStat appUsageStat2 = AppUsageStat.fromJson(
      {'packageName': 'package2', 'timeInForground': 200, 'launchCount': 6});

  final Future<List<AppUsageStat>> futureUsageStats =
      new Future(() => [appUsageStat1, appUsageStat2]);

  final DateTime startDate = DateTime(2020, 01, 12, 16, 30);
  final DateTime endDate = DateTime(2020, 01, 12, 18, 00);
  final double scaleFactor = 3;

  setUpAll(() {
    Injector.setup();
    Container container = Injector.container;
    container.clear();
    GetAppUsageTimes mockGetAppUsageTimes = MockGetAppUsageTimes();
    when(mockGetAppUsageTimes.getUsageStats(startDate, endDate))
        .thenAnswer((_) => futureUsageStats);
    container.registerInstance(mockGetAppUsageTimes);
  });

  test('Should colculate the total app usage time between two dates', () async {
    PhoneUsageStatistics phoneUsageStatistics = PhoneUsageStatistics();

    double totalAppUsageTime =
        await phoneUsageStatistics.getTotalAppUsageTime(startDate, endDate);

    double expectedAppUsageTime =
        appUsageStat1.getTimeInForground() + appUsageStat2.getTimeInForground();

    expect(totalAppUsageTime, expectedAppUsageTime);
  });

  test(
      'Should colculate the total app usage time between two dates and adjust to scale factor',
      () async {
    PhoneUsageStatistics phoneUsageStatistics = PhoneUsageStatistics();

    double totalAppUsageTime = await phoneUsageStatistics
        .getTotalAppUsageTime(startDate, endDate, scaleFactor: scaleFactor);

    double expectedAppUsageTime = (appUsageStat1.getTimeInForground() +
            appUsageStat2.getTimeInForground()) *
        scaleFactor;

    expect(totalAppUsageTime, expectedAppUsageTime);
  });

  test('Should colculate the total app launches between two dates', () async {
    PhoneUsageStatistics phoneUsageStatistics = PhoneUsageStatistics();

    double totalAppUsageTime =
        await phoneUsageStatistics.getTotalApplicationOpens(startDate, endDate);

    double expectedAppUsageTime =
        (appUsageStat1.getLaunchCount() + appUsageStat2.getLaunchCount())
            .toDouble();

    expect(totalAppUsageTime, expectedAppUsageTime);
  });

  test(
      'Should colculate the total app launches between two dates and adjust for scale factor',
      () async {
    PhoneUsageStatistics phoneUsageStatistics = PhoneUsageStatistics();

    double totalAppUsageTime = await phoneUsageStatistics
        .getTotalApplicationOpens(startDate, endDate, scaleFactor: scaleFactor);

    double expectedAppUsageTime =
        (appUsageStat1.getLaunchCount() + appUsageStat2.getLaunchCount()) *
            scaleFactor;

    expect(totalAppUsageTime, expectedAppUsageTime);
  });
}
