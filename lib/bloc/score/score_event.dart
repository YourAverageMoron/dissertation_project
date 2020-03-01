
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ScoreEvent extends Equatable{
  const ScoreEvent();
}

class FetchScore extends ScoreEvent{
  final DateTime date;

  const FetchScore({@required this.date}) : assert(date != null);

  @override
  List<Object> get props => [date];
}