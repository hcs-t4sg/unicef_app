import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './../compare/dropDownData.dart';
import './../../model.dart';
import "package:collection/collection.dart";

class ReportPage extends StatefulWidget {
  ReportPage({Key? key, required this.data});

  final List<Indicator> data;
  @override
  _ReportPageState createState() => _ReportPageState(data);
}

class _ReportPageState extends State<ReportPage> {
  String _selectedCountry = '';
  List _countries = [];

  _ReportPageState(countries) {
    _countries =
        groupBy(countries, (Indicator obj) => obj.country).keys.toList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reporting',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
          child: Column(
            children: [
              DropDownData(
                  list: _countries,
                  hint: "Select country...",
                  callback: (val) => {setState(_selectedCountry = val)}),
              Text("This is the Reporting Page Page", textScaleFactor: 2),
              Icon(MdiIcons.pin, size: 150, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
