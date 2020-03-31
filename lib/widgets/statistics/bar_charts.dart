import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dissertation_project/bloc/statistics/statistics_bloc.dart';
import 'package:dissertation_project/bloc/statistics/statistics_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }
}

class WeeklyScoreBarChart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(builder: (context, state) {
      if(state is StatsLoaded){
        return SimpleBarChart(state.barChartScoreData);
      }
      else{
        return Text("Loading");
      }
    });
  }

}
