import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class StatsEvent extends Equatable{
  const StatsEvent();
}

class FetchStats extends StatsEvent{

  List<Object> get props => [];
}