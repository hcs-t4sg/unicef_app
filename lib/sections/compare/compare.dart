import 'dart:core';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:unicef_app/sections/compare/multiCountryChart.dart';
import 'bar_series.dart';
import './../../model.dart';
import "package:collection/collection.dart";
import './../../multiSelect/lib/multi_select_flutter.dart';
import 'dropDown.dart';
import './../../multiSelect/multidropDown.dart';
import './infoPage.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class ComparePage extends StatefulWidget {
  ComparePage({required this.title});

  String title;

  @override
  _ComparePageState createState() => _ComparePageState();
}

class A {
  Future<int> getInt() {
    return Future.value(10);
  }
}

class _ComparePageState extends State<ComparePage> {
  List<String> _compareby = [];
  List<String> _comparisonindicators = [];
  List<String> _subareas = [];
  Map _colors = {};
  List _selectedCountries = [];
  String _selectedCompareBy = 'on select';
  String _selectedComparisonIndex = 'on select';
  double dataVal = 0;
  List<Container> _list = [];

  Future<double> _getData(String compareBy, String comparisonIndex,
      String subIndex, String subArea) async {
    bool exists = await SQLiteDbProvider.db
        .inDatabase(compareBy, comparisonIndex, subIndex, subArea);
    if (!exists) {
      return 0;
    }
    List<Map> data = await SQLiteDbProvider.db
        .getData(compareBy, comparisonIndex, subIndex, subArea);
    try {
      dataVal = double.parse(data[0]["Value"]);
    } on FormatException {
      dataVal = 0;
    }
    //print("dataVal");
    //print(dataVal);
    return dataVal;
  }

  // Creates a graph with countries as ind variable and comparisonIndex as dep variable
  Future _createGraphs() async {
    if (_selectedCountries.isEmpty) {
      //display message asking user to select countries
      List<Text> message = [
        new Text("Please select countries using top menu.")
      ];
      return message;
    }
    if (_selectedCompareBy == 'on select' ||
        _selectedComparisonIndex == 'on select') {
      List<Text> message = [
        new Text('Please make selections with dropdown menus.')
      ];
      return message;
    }
    List<String> subComparisonList = await _getSubcomparison();
    //print("subcomparisonlist");
    //print(subComparisonList);
    List<Container> list = [];
    for (String _selectedSubIndex in subComparisonList) {
      List<BarSeries> graphData = [];
      for (String country in _selectedCountries) {
        double number = await _getData(_selectedCompareBy,
            _selectedComparisonIndex, _selectedSubIndex, country);
        print(number.toString());
        if (number == 0) {
          graphData.add(BarSeries(
              country: country,
              dataValue: number,
              barColor: charts.ColorUtil.fromDartColor(
                  Color(int.parse("0xFF" + this._colors[country]))),
              label: "Data is not in dataset"));
        } else {
          graphData.add(BarSeries(
              country: country,
              dataValue: number,
              barColor: charts.ColorUtil.fromDartColor(
                  Color(int.parse("0xFF" + this._colors[country]))),
              label: number.toString()));
        }
      }
      list.add(Container(
          constraints: BoxConstraints(maxHeight: 500, maxWidth: 350),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: MultiCountryChart(
              data: graphData,
              graphTitle: _selectedSubIndex.capitalize(),
              yTitle: _selectedComparisonIndex)));
    }
    //print("list");
    //print(list);
    return list;
  }

  // Function to push section for category
  void _pushInfo() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Comparison Indicator Info"),
              automaticallyImplyLeading: true,
            ),
            body: Center(
              // Container with info on category
              child: Container(
                child: DescriptorPage(),
              ),
            ),
          );
        },
      ),
    );
  }

  // TODO: Remove hardcoded values here
  final List<BarSeries> graphData = [
    BarSeries(
        country: "Afghanistan",
        dataValue: 23,
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
        label: "23"),
    BarSeries(
        country: "Nepal",
        dataValue: 33,
        barColor: charts.ColorUtil.fromDartColor(Colors.orange),
        label: "33"),
  ];

  void _getCompareBy() async {
    List<Map> compareby = await SQLiteDbProvider.db.getCompareby();
    var comparebydynamic = compareby.map((i) => i['CompareByText']).toList();
    var comparebystring = List<String>.from(comparebydynamic);
    setState(() {
      this._compareby = comparebystring;
    });
  }

  Future<List<String>> _getSubcomparison() async {
    List<Map> subcomparison = await SQLiteDbProvider.db
        .getSubComparisonIndicatorSpecific(_selectedCompareBy);
    var subcomparisondynamic = subcomparison
        .map((i) => i['SubComparisonIndexText'])
        .toList()
        .toSet()
        .toList();
    // TODO: May be redundant, change later?

    var subcomparisonstring = List<String>.from(subcomparisondynamic);
    return subcomparisonstring;
  }

  void _getComparisonIndicators() async {
    List<Map> comparisonindicators =
        await SQLiteDbProvider.db.getComparisonIndicator();
    var comparisonindicatorsdynamic =
        comparisonindicators.map((i) => i['ComparisonIndexText']).toList();
    var comparisonindicatorsstring =
        List<String>.from(comparisonindicatorsdynamic);
    // print("yeet");
    // print(comparisonindicatorsstring);
    setState(() {
      this._comparisonindicators = comparisonindicatorsstring;
    });
  }

  void _getSubareas() async {
    List<Map> subareas = await SQLiteDbProvider.db.getSubareas();
    Map colors = await SQLiteDbProvider.db.getColors();
    var subareasdynamic = subareas.map((i) => i['SubAreaDisplayName']).toList();
    var subareastring = List<String>.from(subareasdynamic);
    setState(() {
      this._subareas = subareastring;
      this._colors = colors;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCompareBy();
    _getComparisonIndicators();
    _getSubareas();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Container(
                child: MultiSelectDialogField(
                  items: _subareas.map((e) => MultiSelectItem(e, e)).toList(),
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
                padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    CustomDropdown<String>(
                      icon: Icon(Icons.keyboard_arrow_down),
                      child: Text('SELECT INDICATOR',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      onChange: (String value, int index) {
                        //print("yeet");
                        //print(value);
                        setState(() {
                          this._selectedComparisonIndex = value;
                        });
                        //print(this._selectedComparisonIndex);
                      },
                      // TODO: Update onChange() to update the corresponding state variable
                      dropdownButtonStyle: DropdownButtonStyle(
                        mainAxisAlignment: MainAxisAlignment.center,
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        width: 320,
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
                      items: _comparisonindicators
                          .asMap()
                          .entries
                          .map(
                            (item) => DropdownItem<String>(
                              value: item.value,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item.value),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Container(
                      width: 30,
                      child: TextButton(
                        onPressed: () => {_pushInfo()},
                        child: Icon(MdiIcons.informationOutline,
                            color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomDropdown<String>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  child: Text('COMPARE BY',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  onChange: (String value, int index) {
                    setState(() {
                      this._selectedCompareBy = value;
                    });
                  },
                  // TODO: Update onChange() to update the corresponding state variable
                  dropdownButtonStyle: DropdownButtonStyle(
                    mainAxisAlignment: MainAxisAlignment.center,
                    padding: EdgeInsets.fromLTRB(15, 2, 10, 2),
                    width: 350,
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
                  items: _compareby
                      .asMap()
                      .entries
                      .map(
                        (item) => DropdownItem<String>(
                          value: item.value,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.value),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              FutureBuilder(
                  future: _createGraphs(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null &&
                          snapshot.connectionState != ConnectionState.none) {
                        return Container(
                            child: Column(children: snapshot.data));
                      } else {
                        return Text("Is null");
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ]))),
      ),
    );
  }
}
