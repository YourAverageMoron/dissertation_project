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
  void configure();
}
