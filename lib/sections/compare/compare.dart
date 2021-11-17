import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:unicef_app/sections/compare/multiCountryChart.dart';
import 'bar_series.dart';
import 'dropDownData.dart';
import './../../model.dart';
import "package:collection/collection.dart";
import './../../multiSelect/lib/multi_select_flutter.dart';
import 'dropDown.dart';

class ComparePage extends StatefulWidget {
  String title;

  ComparePage({required this.title, required this.data});

  List<Indicator> data;
  _ComparePageState createState() => _ComparePageState(data);
}

class _ComparePageState extends State<ComparePage> {
  List _countries = [];
  List _compareBy = [
    "Gender",
    "Location",
    "Wealth Quintile",
    "Division",
    "Mother's education",
    "Caste and ethnicity",
    "Religion",
    "Disparity Gap"
  ];
  List _comparisonIndex = [
    "Skilled birth attendance (%)",
    "Birth registration (%)",
    "Child under-nutrition (%)",
    "Immunization (%)",
    "Neonatal mortality (#/1,000)",
    "Under-five morality (#/1,000)",
    "Improved sanitation (%)",
    "Primary school net attendance (%)",
    "Secondary school net attendance (%)"
  ];
  List _sortBy = ["Greatest to least", "Least to greatest", "Alphabetical"];
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomDropdown<int>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  child: Text('SELECT COUNTRIES',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  onChange: (int value, int index) => print(value),
                  dropdownButtonStyle: DropdownButtonStyle(
                    mainAxisAlignment: MainAxisAlignment.center,
                    padding: EdgeInsets.fromLTRB(15, 2, 10, 2),
                    width: 170,
                    height: 40,
                    elevation: 1,
                    backgroundColor: Colors.white,
                    primaryColor: Colors.black87,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 15,
                    ),
                  ),
                  dropdownStyle: DropdownStyle(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 15,
                    ),
                    width: 50,
                    offset: Offset(0, 45),
                    borderRadius: BorderRadius.circular(8),
                    elevation: 6,
                    padding: EdgeInsets.all(5),
                  ),
                  items: _countries
                      .asMap()
                      .entries
                      .map(
                        (item) => DropdownItem<int>(
                          value: item.key + 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.value),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomDropdown<int>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  child: Text('SELECT INDICATOR',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  onChange: (int value, int index) => print(value),
                  dropdownButtonStyle: DropdownButtonStyle(
                    mainAxisAlignment: MainAxisAlignment.center,
                    padding: EdgeInsets.fromLTRB(15, 2, 10, 2),
                    width: 170,
                    height: 40,
                    elevation: 1,
                    backgroundColor: Colors.white,
                    primaryColor: Colors.black87,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 15,
                    ),
                  ),
                  dropdownStyle: DropdownStyle(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 15,
                    ),
                    width: 50,
                    offset: Offset(0, 45),
                    borderRadius: BorderRadius.circular(8),
                    elevation: 6,
                    padding: EdgeInsets.all(5),
                  ),
                  items: _comparisonIndex
                      .asMap()
                      .entries
                      .map(
                        (item) => DropdownItem<int>(
                          value: item.key + 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.value),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomDropdown<int>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  child: Text('COMPARE BY',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  onChange: (int value, int index) => print(value),
                  dropdownButtonStyle: DropdownButtonStyle(
                    mainAxisAlignment: MainAxisAlignment.center,
                    padding: EdgeInsets.fromLTRB(15, 2, 10, 2),
                    width: 170,
                    height: 40,
                    elevation: 1,
                    backgroundColor: Colors.white,
                    primaryColor: Colors.black87,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 15,
                    ),
                  ),
                  dropdownStyle: DropdownStyle(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 15,
                    ),
                    width: 50,
                    offset: Offset(0, 45),
                    borderRadius: BorderRadius.circular(8),
                    elevation: 6,
                    padding: EdgeInsets.all(5),
                  ),
                  items: _compareBy
                      .asMap()
                      .entries
                      .map(
                        (item) => DropdownItem<int>(
                          value: item.key + 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.value),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomDropdown<int>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  child: Text('SORT BY',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  onChange: (int value, int index) => print(value),
                  dropdownButtonStyle: DropdownButtonStyle(
                    mainAxisAlignment: MainAxisAlignment.center,
                    padding: EdgeInsets.fromLTRB(15, 2, 10, 2),
                    width: 170,
                    height: 40,
                    elevation: 1,
                    backgroundColor: Colors.white,
                    primaryColor: Colors.black87,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 15,
                    ),
                  ),
                  dropdownStyle: DropdownStyle(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height - 15,
                    ),
                    width: 50,
                    offset: Offset(0, 45),
                    borderRadius: BorderRadius.circular(8),
                    elevation: 6,
                    padding: EdgeInsets.all(5),
                  ),
                  items: _sortBy
                      .asMap()
                      .entries
                      .map(
                        (item) => DropdownItem<int>(
                          value: item.key + 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.value),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Container(
                  constraints: BoxConstraints(maxHeight: 500, maxWidth: 350),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: MultiCountryChart(
                    data: graphData,
                  ))
            ])),
      ),
    );
  }
}
