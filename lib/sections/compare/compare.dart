import 'package:flutter/material.dart';
import 'dropDownData.dart';
import './../../model.dart';

class ComparePage extends StatefulWidget {
  ComparePage({required this.title});

  String title;

  @override
  _ComparePageState createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {    
  List<String> _compareby = [];
  List<String> _subcomparison = [];
  List<String> _comparisonindicators = [];
  List<String> _subareas = [];

  void _getCompareBy() async {
    List<Map> compareby = await SQLiteDbProvider.db.getCompareby();
    var comparebydynamic = compareby.map((i) => i['CompareByText']).toList();
    var comparebystring = List<String>.from(comparebydynamic);
    setState(() {
      this._compareby = comparebystring;
    });
  }

  void _getSubcomparison() async {
    List<Map> subcomparison = await SQLiteDbProvider.db.getSubComparisonIndicator();
    var subcomparisondynamic = subcomparison.map((i) => i['SubComparisonIndexText']).toList();
    var subcomparisonstring = List<String>.from(subcomparisondynamic);
    setState(() {
      this._subcomparison = subcomparisonstring;
    });
  }

  void _getComparisonIndicators() async {
    List<Map> comparisonindicators = await SQLiteDbProvider.db.getComparisonIndicator();
    var comparisonindicatorsdynamic = comparisonindicators.map((i) => i['ComparisonIndexText']).toList();
    var comparisonindicatorsstring = List<String>.from(comparisonindicatorsdynamic);
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

  @override
  void initState() {
    super.initState();
    _getCompareBy();
    _getSubcomparison();
    _getComparisonIndicators();
    _getSubareas();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compare')),
      body: Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                child: DropDownData(
                    list: _compareby,
                    hint: "",
                    callback: (val) => {print(val)}),
              ),
              Container(
                child: DropDownData(
                    list: _comparisonindicators,
                    hint: "",
                    callback: (val) => {print(val)}),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Select Countries'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
