import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dissertation_project/bloc/statistics/statistics_bloc.dart';
import 'package:dissertation_project/bloc/statistics/statistics_events.dart';
import 'package:dissertation_project/bloc/statistics/statistics_state.dart';
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

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('Tues', 50),
      new OrdinalSales('Wed', 25),
      new OrdinalSales('Thurs', 10),
      new OrdinalSales('Fri', 80),
      new OrdinalSales('Sat', 75),
      new OrdinalSales('Sun', 45),
      new OrdinalSales('Mon', 77),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class PieOutsideLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PieOutsideLabelChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory PieOutsideLabelChart.withSampleData() {
    return new PieOutsideLabelChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Add an [ArcLabelDecorator] configured to render labels outside of the
        // arc with a leader line.
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.outside)
        ]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
