import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:unicef_app/sections/compare/multiCountryChart.dart';
import 'bar_series.dart';
import 'dropDownData.dart';
import './../../model.dart';
import "package:collection/collection.dart";
import './../../multiSelect/lib/multi_select_flutter.dart';

class ComparePage extends StatefulWidget {
  String title;

  ComparePage({required this.title, required this.data});

  List<Indicator> data;
  _ComparePageState createState() => _ComparePageState(data);
}

class _ComparePageState extends State<ComparePage> {
  List _countries = [];
  List _selectedCountries = [];
  List _indicators = [];
  List<Indicator> _data = [];

  final List<BarSeries> graphData = [
    BarSeries(
        country: "Afghanistan",
        dataValue: 23,
        barColor: charts.ColorUtil.fromDartColor(Colors.red)),
    BarSeries(
        country: "Nepal",
        dataValue: 33,
        barColor: charts.ColorUtil.fromDartColor(Colors.orange)),
  ];

  _ComparePageState(data) {
    _data = data;
    _countries = groupBy(data, (Indicator obj) => obj.country).keys.toList();
    _indicators = groupBy(data, (Indicator obj) => obj.index).keys.toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                child: MultiSelectDialogField(
                  items: _countries.map((e) => MultiSelectItem(e, e)).toList(),
                  listType: MultiSelectListType.LIST,
                  searchable: true,
                  searchHint: "Search countries",
                  buttonText: Text("Select Countries"),
                  chipDisplay: MultiSelectChipDisplay.none(),
                  onConfirm: (values) => setState(
                    () {
                      _selectedCountries = values;
                    },
                  ),
                ),
              ),
              Container(
                child:
                    DropDownData(list: _indicators, hint: "SELECT INDICATOR"),
              ),
              Container(
                child: DropDownData(list: _countries, hint: "COMPARE BY"),
              ),
              Container(
                child: DropDownData(list: _countries, hint: "SORT BY"),
              ),
              Container(
                constraints: BoxConstraints(maxHeight: 500, maxWidth: 350),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: MultiCountryChart(
                  data: graphData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
