import 'package:dissertation_project/data/phone_usage/phone_usage_statistics.dart';
import 'package:dissertation_project/data/time_scaler/comparable_time_of_day.dart';
import 'package:dissertation_project/helpers/shared_preferences/scaled_score_times_preferences.dart';
import 'package:mockito/mockito.dart';

import 'scaled_repository_test_data.dart';

class MockPhoneUsageStatistics extends Mock implements PhoneUsageStatistics {}

PhoneUsageStatistics createMockPhoneUsageStatistics() {
  PhoneUsageStatistics mockPhoneUsageStatistics = MockPhoneUsageStatistics();

  when(mockPhoneUsageStatistics.getTotalAppUsageTime(startDate1, endDate1))
      .thenAnswer((_) => futureAppUsageTime1);
  when(mockPhoneUsageStatistics.getTotalApplicationOpens(startDate1, endDate1))
      .thenAnswer((_) => futureApplicationOpens1);

  when(mockPhoneUsageStatistics.getTotalAppUsageTime(startDate2, endDate2, scaleFactor: 2))
      .thenAnswer((_) => futureAppUsageTime2);
  when(mockPhoneUsageStatistics.getTotalApplicationOpens(startDate2, endDate2, scaleFactor: 2))
      .thenAnswer((_) => futureApplicationOpens2);

  when(mockPhoneUsageStatistics.getTotalAppUsageTime(startDate3, endDate3))
      .thenAnswer((_) => futureAppUsageTime3);
  when(mockPhoneUsageStatistics.getTotalApplicationOpens(startDate3, endDate3))
      .thenAnswer((_) => futureApplicationOpens3);

  return mockPhoneUsageStatistics;
}

class MockScaledScoreTimesPreferences extends Mock
    implements ScaledScoreTimesPreferences {}

ScaledScoreTimesPreferences createMockScaledScoreTimesPreferences() {
  ScaledScoreTimesPreferences mockScaledScoreTimesPreferences =
      MockScaledScoreTimesPreferences();

  ComparableTimeOfDay timeOfDay =
      ComparableTimeOfDay(hour: date.hour, minute: date.minute);

  when(mockScaledScoreTimesPreferences.getAllTimesScaled(timeOfDay))
      .thenAnswer((_) => futureScaledTimes);

  return mockScaledScoreTimesPreferences;
}
