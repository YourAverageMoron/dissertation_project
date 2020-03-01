
import 'package:dissertation_project/data/score/score.dart';
import 'package:kiwi/kiwi.dart';

part 'injector.g.dart';

abstract class Injector {
  @Register.singleton(Score)
  void configure();
}

void setup() {
  new _$Injector().configure();
}