import 'package:dissertation_project/bloc/statistics/statistics_bloc.dart';
import 'package:dissertation_project/bloc/statistics/statistics_events.dart';
import 'package:dissertation_project/bloc/statistics/statistics_state.dart';
import 'package:dissertation_project/widgets/statistics/bar_charts.dart';
import 'package:dissertation_project/widgets/statistics/pie_charts.dart';
import 'package:dissertation_project/widgets/statistics/statistics_container.dart';
import 'package:dissertation_project/widgets/statistics/written_statistics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text("Statistics"),
        ),
        body: BlocBuilder<StatsBloc, StatsState>(builder: (context, state) {
          if (state is StatsEmpty) {
            BlocProvider.of<StatsBloc>(context).add(FetchStats());
          }
          return ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: AppsScreenTimeStatistic(
                    padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
                  )),
                  Expanded(
                    child: AppsOpenedStatistic(
                      padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                    ),
                  )
                ],
              ),
              StatisticsContainer(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  height: 300,
                  child: Column(
                    children: <Widget>[
                      FittedBox(
                          child: Text(
                        "Weekly score comparison",
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.ellipsis,
                      )),
                      Expanded(child: SimpleBarChart.withSampleData()),
                    ],
                  )),
              StatisticsContainer(
                  height: 200,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Column(children: <Widget>[
                    FittedBox(
                        child: Text(
                      "Application screen time breakdown",
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                    )),
                    Expanded(child: PieOutsideLabelChart.withSampleData())
                  ])),
            ],
          );
        }));
  }
}
