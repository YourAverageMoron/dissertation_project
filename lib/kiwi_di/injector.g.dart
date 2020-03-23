// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void configure() {
    final Container container = Container();
    container.registerSingleton((c) => ScaledScoreTimesPreferences());
    container.registerSingleton((c) => DateTimeHelpers());
    container.registerSingleton((c) => StatsBlocHelper());
    container.registerSingleton((c) => PhoneUsageStatistics());
    container.registerSingleton((c) => ScaledAppRepository());
    container.registerSingleton((c) => ScaledAppPreferences());
    container.registerSingleton((c) => PackageManagerRepository());
    container.registerSingleton((c) => ScoreRepository());
    container.registerSingleton((c) => GetAppUsageTimes());
  }
}
