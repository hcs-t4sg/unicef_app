import 'package:flutter/material.dart';
import 'dropDownData.dart';
import './../../model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ComparePage extends StatefulWidget {
  ComparePage({required this.title, required this.data});

  String title;
  List<Indicator> data;

  @override
  _ComparePageState createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compare')),
      body: Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(child: DropDownData()),
              Container(child: DropDownData()),
              Container(child: DropDownData()),
              Container(child: DropDownData()),
            ],
          ),
        ),
      ),
    );
  }
}
