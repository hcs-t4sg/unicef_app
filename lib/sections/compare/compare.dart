import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:unicef_app/sections/compare/multiCountryChart.dart';
import 'birth_attendance_series.dart';

class ComparePage extends StatelessWidget {
  final List<BirthSeries> data = [
    BirthSeries(
        country: "Afghanistan",
        birthAttendance: 23,
        barColor: charts.ColorUtil.fromDartColor(Colors.red)),
    BirthSeries(
        country: "Nepal",
        birthAttendance: 33,
        barColor: charts.ColorUtil.fromDartColor(Colors.orange)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MultiCountryChart(
          data: data,
        ),
      ),
    );
  }
}
