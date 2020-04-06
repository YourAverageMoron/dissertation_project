import 'package:dissertation_project/bloc/statistics/statistics_bloc_helper.dart';
import 'package:dissertation_project/data/phone_usage/get_app_usage_times.dart';
import 'package:dissertation_project/data/phone_usage/phone_usage_statistics.dart';
import 'package:dissertation_project/helpers/datetime_helpers.dart';
import 'package:dissertation_project/helpers/shared_preferences/scaled_apps_preferences.dart';
import 'package:dissertation_project/helpers/shared_preferences/scaled_score_times_preferences.dart';
import 'package:dissertation_project/repositories/package_manager_repository.dart';
import 'package:dissertation_project/repositories/scaled_app_repository.dart';
import 'package:dissertation_project/repositories/scaled_time_repository.dart';
import 'package:dissertation_project/repositories/score_repository.dart';
import 'package:kiwi/kiwi.dart';

part 'injector.g.dart';

abstract class Injector {
  static void setup() {
    container = Container();
    new _$Injector().configure();
  }

  static Container container;

  static final resolve = container.resolve;

  @Register.singleton(ScaledTimeRepository)
  @Register.singleton(ScaledScoreTimesPreferences)
  @Register.singleton(DateTimeHelpers)
  @Register.singleton(StatsBlocHelper)
  @Register.singleton(PhoneUsageStatistics)
  @Register.singleton(ScaledAppRepository)
  @Register.singleton(ScaledAppPreferences)
  @Register.singleton(PackageManagerRepository)
  @Register.singleton(ScoreRepository)
  @Register.singleton(GetAppUsageTimes)
  void configure();
}
