import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class BarSeries {
  final String country;
  final int dataValue;
  final charts.Color barColor;

  BarSeries(
      {required this.country, required this.dataValue, required this.barColor});
}
