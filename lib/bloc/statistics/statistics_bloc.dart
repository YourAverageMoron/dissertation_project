import 'package:dissertation_project/bloc/statistics/statistics_events.dart';
import 'package:dissertation_project/bloc/statistics/statistics_state.dart';
import 'package:dissertation_project/data/phone_usage/phone_usage_statistics.dart';
import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final PhoneUsageStatistics _phoneUsageStatistics =
      Injector.resolve<PhoneUsageStatistics>();

  @override
  StatsState get initialState => StatsEmpty();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is FetchStats) {
      yield StatsLoading();
      try {
        DateTime now = DateTime.now();
        DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);

        final double applicationOpens = await _phoneUsageStatistics
            .getTotalApplicationOpens(startOfDay, now);
        final double appScreenTime =
            await _phoneUsageStatistics.getTotalAppUsageTime(startOfDay, now);
        yield StatsLoaded(
          applicationOpens: applicationOpens.round().toInt(),
          appScreenTime: appScreenTime,
        );
      } catch (_) {
        yield StatsError();
      }
    }
  }
}
