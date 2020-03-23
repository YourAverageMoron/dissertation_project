import 'package:equatable/equatable.dart';

abstract class StatsEvent extends Equatable{
  const StatsEvent();
}

class FetchStats extends StatsEvent{

  List<Object> get props => [];
}