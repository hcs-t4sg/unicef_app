import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class BirthSeries {
  final String country;
  final int birthAttendance;
  final charts.Color barColor;

  BirthSeries(
      {required this.country,
      required this.birthAttendance,
      required this.barColor});
}
