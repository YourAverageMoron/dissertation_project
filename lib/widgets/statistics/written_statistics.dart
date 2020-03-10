import 'package:dissertation_project/bloc/statistics/statistics_bloc.dart';
import 'package:dissertation_project/bloc/statistics/statistics_state.dart';
import 'package:dissertation_project/widgets/statistics/statistics_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppsOpenedStatistic extends StatelessWidget {
  final EdgeInsets padding;

  AppsOpenedStatistic({this.padding});

  @override
  Widget build(BuildContext context) {
    return StatisticsContainer(
      padding: padding,
      child: BlocBuilder<StatsBloc, StatsState>(builder: (context, state) {
        if (state is StatsLoaded) {
          return WrittenStatistic(
            header: "Total app opens today",
            statistic: state.applicationOpens.toString(),
          );
        } else {
          return WrittenStatistic(
            header: "Total app opens today",
            statistic: "Not loaded".toString(),
          );
        }
      }),
    );
  }
}

class AppsScreenTimeStatistic extends StatelessWidget {

  final EdgeInsets padding;

  AppsScreenTimeStatistic({this.padding});

  @override
  Widget build(BuildContext context) {
    return StatisticsContainer(
      padding: padding,
      child: BlocBuilder<StatsBloc, StatsState>(builder: (context, state) {
        if (state is StatsLoaded) {
          return WrittenStatistic(
            header: "Total app opens today",
            statistic: state.appScreenTime.toString(),
          );
        } else {
          return WrittenStatistic(
            header: "Total app opens today",
            statistic: "Not loaded".toString(),
          );
        }
      }),
    );
  }
}

class WrittenStatistic extends StatelessWidget {
  final String header;
  final String statistic;

  WrittenStatistic({@required this.header, @required this.statistic});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: FittedBox(
                child: Text(
              header,
              style: Theme.of(context).textTheme.subtitle1,
              overflow: TextOverflow.ellipsis,
            ))),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            statistic,
            style: Theme.of(context).textTheme.headline2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
