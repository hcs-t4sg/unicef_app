import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'bar_series.dart';

class MultiCountryChart extends StatelessWidget {
  final List<BarSeries> data;
  final String graphTitle;
  final String yTitle;
  MultiCountryChart(
      {required this.data, required this.graphTitle, required this.yTitle});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarSeries, String>> series = [
      charts.Series(
        id: "horizontal_bar",
        data: data,
        domainFn: (BarSeries series, _) => series.country,
        measureFn: (BarSeries series, _) => series.dataValue,
        colorFn: (BarSeries series, _) => series.barColor,
      )
    ];
    return charts.BarChart(
      series,
      animate: false,
      vertical: false,
      behaviors: [
        new charts.ChartTitle(graphTitle,
            behaviorPosition: charts.BehaviorPosition.top),
        new charts.ChartTitle(yTitle,
            behaviorPosition: charts.BehaviorPosition.bottom)
      ],
    );
  }
}
