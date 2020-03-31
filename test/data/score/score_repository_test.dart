import 'package:dissertation_project/data/score/score_repository.dart';
import 'package:dissertation_project/helpers/datetime_helpers.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiwi/kiwi.dart';

import 'scaled_repoaitory_test_helper.dart';
import 'scaled_repository_test_data.dart';


void main() {
  setUpAll(() {
    Injector.setup();
    Container container = Injector.container;
    container.clear();
    container.registerInstance(createMockPhoneUsageStatistics());
    container.registerInstance(createMockScaledScoreTimesPreferences());
    container.registerInstance(DateTimeHelpers());
  });

  test('Should generate score', () async {
    ScoreRepository scoreRepository = ScoreRepository();
    int score = await scoreRepository.generateScore(date);

    print(score);
  });
}
