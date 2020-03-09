import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Statistics"),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: StatisticsContainer(
                    padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
                    child: WrittenStatistic(
                      header: "Total screen time today",
                      statistic: "5h 15m", //TODO INSERT STAT HERE
                    ),
                  ),
                ),
                Expanded(
                  child: StatisticsContainer(
                    padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                    child: WrittenStatistic(
                      header: "Total app opens today",
                      statistic: "50", //TODO INSERT STAT HERE
                    ),
                  ),
                ),
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
        ));
  }
}

class StatisticsContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double height;

  StatisticsContainer(
      {@required this.child,
      this.padding = const EdgeInsets.all(10),
      this.height = 150.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: new BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
              bottomLeft: const Radius.circular(10.0),
              bottomRight: const Radius.circular(10.0),
            )),
        height: height,
        child: Padding(padding: EdgeInsets.all(10), child: child),
      ),
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
