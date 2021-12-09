import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class BarSeries {
  final String country;
  final double dataValue;
  final charts.Color barColor;
  final String label;

  BarSeries(
      {required this.country,
      required this.dataValue,
      required this.barColor,
      required this.label});
}
