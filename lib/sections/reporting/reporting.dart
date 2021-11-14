import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './../compare/dropDownData.dart';
import './../../model.dart';
import "package:collection/collection.dart";
import "./reportingCard.dart";

class ReportPage extends StatefulWidget {
  ReportPage({Key? key, required this.data});

  final List<Indicator> data;
  @override
  _ReportPageState createState() => _ReportPageState(data);
}

class _ReportPageState extends State<ReportPage> {
  String _selectedCountry = '';
  List _countries = ["Data not yet loaded"];
  List<Report> _reports = [
    Report(
        name: "Report 1",
        ratificationDate: "2021-01-01",
        date: "2021-10-05",
        status: "Submitted",
        country: "Afghanistan"),
    Report(
        name: "Report 2",
        ratificationDate: "2021-02-01",
        date: "2021-10-05",
        status: "Not submitted",
        country: "Afghanistan"),
    Report(
        name: "Report 3",
        ratificationDate: "2021-03-01",
        date: "2021-10-05",
        status: "Submitted",
        country: "Afghanistan"),
    Report(
        name: "Report 4",
        ratificationDate: "2021-04-01",
        date: "2021-10-05",
        status: "Submitted",
        country: "Pakistan"),
    Report(
        name: "Report 5",
        ratificationDate: "2021-05-01",
        date: "2021-10-05",
        status: "Not submitted",
        country: "Bhutan"),
  ];

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
              children: <Widget>[
                    Container(
                      child: DropDownData(
                        list: _countries,
                        hint: "Select country...",
                        callback: (val) => {
                          setState(() {
                            _selectedCountry = val;
                          })
                        },
                      ),
                    ),
                  ] +
                  _reports
                      .where((report) => report.country == _selectedCountry)
                      .map((report) => ReportingCard(
                          report.name,
                          report.date,
                          report.ratificationDate,
                          report.country,
                          report.status))
                      .toList()),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 95,
          color: Colors.blue.shade100,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Icon(MdiIcons.closeCircleOutline,
                          size: 20, color: Colors.red),
                    ),
                    Text(
                      "LAST REPORT WAS NOT SUBMITTED",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Icon(MdiIcons.checkboxMarkedCircleOutline,
                          size: 20, color: Colors.green),
                    ),
                    Text(
                      "LAST REPORT SUBMISSION DATE",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Icon(MdiIcons.chevronRightCircleOutline,
                          size: 20, color: Colors.blue),
                    ),
                    Text(
                      "NEXT REPORT SUBMISSION DATE",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
