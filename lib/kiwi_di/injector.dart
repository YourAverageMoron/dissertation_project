import 'package:dissertation_project/data/phone_usage/get_app_usage_times.dart';
import 'package:dissertation_project/data/score/score.dart';
import 'package:kiwi/kiwi.dart';

part 'injector.g.dart';

abstract class Injector {
  static void setup() {
    container = Container();
    new _$Injector().configure();
  }

  static Container container;

  static final resolve = container.resolve;

  @Register.singleton(ScoreRepository)
  @Register.singleton(GetAppUsageTimes)
  void configure();
}
