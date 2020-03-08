// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void configure() {
    final Container container = Container();
    container.registerSingleton((c) => ScaledAppPreferences());
    container.registerSingleton((c) => PackageManagerRepository());
    container.registerSingleton((c) => ScoreRepository());
    container.registerSingleton((c) => GetAppUsageTimes());
  }
}
