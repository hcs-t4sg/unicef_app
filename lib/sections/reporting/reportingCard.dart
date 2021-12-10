import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './../../model.dart';

// ReportingCard class
// Stateless widget that displays report information for a single report
class ReportingCard extends StatelessWidget {
  // Default initialized with empty report
  Report _report = Report.empty();

  // Mappings of icon types to actual icons
  Map<String, Icon> icons = {
    'blue':
        Icon(MdiIcons.chevronRightCircleOutline, size: 20, color: Colors.blue),
    'green': Icon(MdiIcons.checkboxMarkedCircleOutline,
        size: 20, color: Colors.green),
    'red': Icon(MdiIcons.closeCircleOutline, size: 20, color: Colors.red),
  };

  // Create ReportingCard where _report is [report]
  ReportingCard(Report report) {
    this._report = report;
  }

  // Build card
  @override
  Widget build(BuildContext context) {
    return Container(
      // Exterior decoration of card
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      margin: EdgeInsets.all(10),
      // Contents of card
      child: Column(
        children: [
          // Name of the report
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey),
              ),
            ),
            child: Text(
              (_report.name != null) ? _report.name : "",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          // Ratification Date of the report
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Ratification Date: ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  (_report.ratificationdate != null)
                      ? _report.ratificationdate
                      : "",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          // Report date of the report
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              children: [
                Text(
                  "Report Date: ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  (_report.reportdate != null) ? _report.reportdate : "",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: _report.reportstatus != null
                      ? icons[_report.reportstatus]
                      : null,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
