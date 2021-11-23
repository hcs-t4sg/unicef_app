import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './../compare/dropDownData.dart';
import './../../model.dart';
import "./reportingCard.dart";

class ReportPage extends StatefulWidget {
  ReportPage({
    Key? key,
  });

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String _selectedCountry = '';
  List<String> _countries = [];
  List<Report> _reports = [];

  void _getReports(String subarea) async {
    final List<Report> reports = await SQLiteDbProvider.db.getReports(subarea);
    setState(() {
      _reports = reports;
    });
  }

  void _getSubareas() async {
    final List<Map> countrymap = await SQLiteDbProvider.db.getReportSubareas();
    var countrydynamic = countrymap.map((Map<dynamic, dynamic> countrymap) {
      return countrymap['SubAreaDisplayName'];
    }).toList();
    var countries = List<String>.from(countrydynamic);
    setState(() {
      _countries = countries;
      _selectedCountry = _countries[0];
    });

    _getReports(_selectedCountry);
  }

  @override
  void initState() {
    super.initState();
    _getSubareas();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // NOTE: Fixed overflow/scroll behavior using the second solution in link below
      // https://stackoverflow.com/questions/54156420/flutter-bottom-overflowed-by-119-pixels
      appBar: AppBar(
        title: const Text(
          'Reporting',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
          child: Column(
              children: <Widget>[
                    Container(
                      child: DropDownData(
                        list: _countries,
                        hint: _selectedCountry,
                        callback: (val) => {
                          setState(() {
                            _selectedCountry = val;
                            _getReports(_selectedCountry);
                          })
                        },
                      ),
                    ),
                  ] +
                  _reports
                      .map(
                        (report) => ReportingCard(report),
                      )
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
