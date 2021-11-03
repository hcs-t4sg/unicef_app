import 'package:flutter/material.dart';
import 'dropDownData.dart';
import './../../model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import "package:collection/collection.dart";

class ComparePage extends StatefulWidget {
  ComparePage({required this.title, required this.data});

  String title;
  List<Indicator> data;

  @override
  _ComparePageState createState() => _ComparePageState(data);
}

class _ComparePageState extends State<ComparePage> {
  List _countries = [];
  List _indicators = [];
  List<Indicator> _data = [];

  _ComparePageState(data) {
    _data = data;
    _countries = groupBy(data, (Indicator obj) => obj.country).keys.toList();
    _indicators = groupBy(data, (Indicator obj) => obj.index).keys.toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compare')),
      body: Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                  child:
                      DropDownData(list: _countries, hint: "SELECT COUNTRIES")),
              Container(
                  child:
                      DropDownData(list: _countries, hint: "SELECT INDICATOR")),
              Container(
                  child: DropDownData(list: _countries, hint: "COMPARE BY")),
              Container(child: DropDownData(list: _countries, hint: "SORT BY")),
            ],
          ),
        ),
      ),
    );
  }
}
