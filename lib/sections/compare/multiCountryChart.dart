import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import "birth_attendance_series.dart";

class MultiCountryChart extends StatelessWidget {
  final List<BirthSeries> data;
  MultiCountryChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<BirthSeries, String>> series = [
      charts.Series(
        id: "birth_attendance_percentage",
        data: data,
        domainFn: (BirthSeries series, _) => series.country,
        measureFn: (BirthSeries series, _) => series.birthAttendance,
        colorFn: (BirthSeries series, _) => series.barColor,
      )
    ];
    return charts.BarChart(series, animate: true);
  }
}
