import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './../compare/dropDownData.dart';
import './../../model.dart';
import "./reportingCard.dart";

//Report Page Class
//Page showing all of the reports in a single list view, with select country functionality
class ReportPage extends StatefulWidget {
  ReportPage({
    Key? key,
  });

  @override
  _ReportPageState createState() => _ReportPageState();
}

// ReportPage State
class _ReportPageState extends State<ReportPage> {
  // Select country
  String _selectedCountry = '';

  // List of countries and reports instantiated to null
  List<String> _countries = [];
  List<Report> _reports = [];

  // Async function to get reports from [subarea]
  // Sets _reports in state to queried reports
  void _getReports(String subarea) async {
    final List<Report> reports = await SQLiteDbProvider.db.getReports(subarea);
    setState(() {
      _reports = reports;
    });
  }

  // Async function to get list of all countries (subareas)
  // Default initializes selected country to the first subarea
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

    // On initialization, reports are of first country
    _getReports(_selectedCountry);
  }

  @override
  // Initialization of state, get all subareas and initialize defaults
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
                    // DropDown for country list that sets _selectedCountry to selected value
                    // Once selected, gets reports for said country
                    Container(
                      child: DropDownData(
                        list: _countries,
                        hint: _selectedCountry,
                        callback: (val) => {
                          setState(
                            () {
                              _selectedCountry = val;
                              _getReports(_selectedCountry);
                            },
                          )
                        },
                      ),
                    ),
                  ] +
                  // Display reports as series of reporting cards
                  _reports
                      .map(
                        (report) => ReportingCard(report),
                      )
                      .toList()),
        ),
      ),
      // Botton Bar that serves as legend for how to use reporting page
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
