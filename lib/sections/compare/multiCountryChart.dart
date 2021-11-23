import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'bar_series.dart';

class MultiCountryChart extends StatelessWidget {
  final List<BarSeries> data;
  MultiCountryChart({required this.data});

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
    return charts.BarChart(series, animate: true, vertical: false);
  }
}
