import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:unicef_app/sections/compare/multiCountryChart.dart';
import 'bar_series.dart';
import './../../model.dart';
import "package:collection/collection.dart";
import './../../multiSelect/lib/multi_select_flutter.dart';
import 'dropDown.dart';
import './../../multiSelect/multidropDown.dart';

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
  List<String> _subcomparison = [];
  List<String> _comparisonindicators = [];
  List<String> _subareas = [];
  List _sortBy = ["Greatest to least", "Least to greatest", "Alphabetical"];
  List _selectedCountries = ["Afghanistan", "Pakistan"];
  String _selectedCompareBy = 'wealth quintile';
  String _selectedComparisonIndex = 'Under-five mortality (#/1,000)';
  int dataVal = 0;
  Future<List<Widget>> _graphs = [] as Future<List<Widget>>;

  get child => null;

  @override
  initState() {
    super.initState();
    _graphs = _createGraphs();
    _getCompareBy();
    _getSubcomparison();
    _getComparisonIndicators();
    _getSubareas();
  }

  Future<int> _getData(String compareBy, String comparisonIndex,
      String subIndex, String subArea) async {
    List<Map> data = await SQLiteDbProvider.db
        .getData(compareBy, comparisonIndex, subIndex, subArea);
    dataVal = int.parse(data[0]["Value"]);
    return dataVal;
    //TODO: change int to double
  }

  // Creates a graph with countries as ind variable and comparisonIndex as dep variable
  Future<List<Widget>> _createGraphs() async {
    List<Container> list = [];
    print(_subcomparison.length);

    for (String _selectedSubIndex in _subcomparison) {
      List<BarSeries> graphData = [];
      for (String country in _selectedCountries) {
        print("DEBUGGING");
        print(_selectedCompareBy);
        print(_selectedComparisonIndex);
        print(_selectedSubIndex);
        print(country);
        int number = await _getData(_selectedCompareBy,
            _selectedComparisonIndex, _selectedSubIndex, country);
        graphData.add(BarSeries(
            country: country,
            dataValue: number,
            barColor: charts.ColorUtil.fromDartColor(Colors.red)));
      }
      list.add(Container(
          constraints: BoxConstraints(maxHeight: 500, maxWidth: 350),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: MultiCountryChart(data: graphData)));
    }
    return list;
  }

  void _getCompareBy() async {
    List<Map> compareby = await SQLiteDbProvider.db.getCompareby();
    var comparebydynamic = compareby.map((i) => i['CompareByText']).toList();
    var comparebystring = List<String>.from(comparebydynamic);
    setState(() {
      this._compareby = comparebystring;
    });
  }

  void _getSubcomparison() async {
    List<Map> subcomparison = await SQLiteDbProvider.db
        .getSubComparisonIndicatorSpecific(_selectedCompareBy);
    var subcomparisondynamic = subcomparison
        .map((i) => i['SubComparisonIndexText'])
        .toList()
        .toSet()
        .toList();
    // TODO: May be redundant, change later?

    var subcomparisonstring = List<String>.from(subcomparisondynamic);
    setState(() {
      this._subcomparison = subcomparisonstring;
    });
  }

  void _getComparisonIndicators() async {
    List<Map> comparisonindicators =
        await SQLiteDbProvider.db.getComparisonIndicator();
    var comparisonindicatorsdynamic =
        comparisonindicators.map((i) => i['ComparisonIndexText']).toList();
    var comparisonindicatorsstring =
        List<String>.from(comparisonindicatorsdynamic);
    setState(() {
      this._comparisonindicators = comparisonindicatorsstring;
    });
  }

  void _getSubareas() async {
    List<Map> subareas = await SQLiteDbProvider.db.getSubareas();
    var subareasdynamic = subareas.map((i) => i['SubAreaDisplayName']).toList();
    var subareastring = List<String>.from(subareasdynamic);
    setState(() {
      this._subareas = subareastring;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            child: FutureBuilder<List<Widget>>(
                future: _graphs,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<Widget>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [Text("Waiting")],
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return Container(
                          child: ListView(children: <Widget>[
                        Container(
                          child: MultiSelectDialogField(
                            items: _subareas
                                .map((e) => MultiSelectItem(e, e))
                                .toList(),
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
                            // TODO: Update onChange() to update the corresponding state variable
                            dropdownButtonStyle: DropdownButtonStyle(
                              mainAxisAlignment: MainAxisAlignment.center,
                              padding: EdgeInsets.fromLTRB(15, 2, 10, 2),
                              width: 170,
                              height: 40,
                              elevation: 1,
                              backgroundColor: Colors.white,
                              primaryColor: Colors.black87,
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height - 15,
                              ),
                            ),
                            dropdownStyle: DropdownStyle(
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height - 15,
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
                            // TODO: Update onChange() to update the corresponding state variable
                            dropdownButtonStyle: DropdownButtonStyle(
                              mainAxisAlignment: MainAxisAlignment.center,
                              padding: EdgeInsets.fromLTRB(15, 2, 10, 2),
                              width: 170,
                              height: 40,
                              elevation: 1,
                              backgroundColor: Colors.white,
                              primaryColor: Colors.black87,
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height - 15,
                              ),
                            ),
                            dropdownStyle: DropdownStyle(
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height - 15,
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
                            // TODO: Update onChange() to update the corresponding state variable
                            dropdownButtonStyle: DropdownButtonStyle(
                              mainAxisAlignment: MainAxisAlignment.center,
                              padding: EdgeInsets.fromLTRB(15, 2, 10, 2),
                              width: 170,
                              height: 40,
                              elevation: 1,
                              backgroundColor: Colors.white,
                              primaryColor: Colors.black87,
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height - 15,
                              ),
                            ),
                            dropdownStyle: DropdownStyle(
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height - 15,
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
                            child: Column(
                          children: snapshot.data,
                        ))
                      ]));
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text("Not waiting or done");
                  }
                })),
      ),
    );
  }
}
