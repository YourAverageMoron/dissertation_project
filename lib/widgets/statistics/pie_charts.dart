import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dissertation_project/bloc/statistics/statistics_bloc.dart';
import 'package:dissertation_project/bloc/statistics/statistics_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppScreenTimeBreakdown extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(builder: (context, state) {
      if (state is StatsLoaded) {
        print(state.appScreenTimePieData);
        return PieOutsideLabelChart(state.appScreenTimePieData);
      }
      return Text("Loading");
    });
  }
}

class PieOutsideLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PieOutsideLabelChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
      animate: false,
      behaviors: [
        new charts.DatumLegend(
          position: charts.BehaviorPosition.bottom,
          horizontalFirst: false,
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          showMeasures: true,
          legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
          measureFormatter: (num value) {
            return value == null ? '-' : '${(value/1000/60).round()} mins';
          },
        )
      ],
    );
  }
}
