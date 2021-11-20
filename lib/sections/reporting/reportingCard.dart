import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ReportingCard extends StatelessWidget {
  String _name = "";
  String _date = "";
  String _ratificationDate = "";
  String _country = "";
  String _status = "";
  Map<String, Icon> icons = {
    'Next Report':
        Icon(MdiIcons.chevronRightCircleOutline, size: 20, color: Colors.blue),
    'Submitted': Icon(MdiIcons.checkboxMarkedCircleOutline,
        size: 20, color: Colors.green),
    'Not submitted':
        Icon(MdiIcons.closeCircleOutline, size: 20, color: Colors.red),
  };

  ReportingCard(String name, String date, String ratificationDate,
      String country, String status) {
    this._name = name;
    this._date = date;
    this._ratificationDate = ratificationDate;
    this._country = country;
    this._status = status;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
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
              _name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
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
                  _ratificationDate,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
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
                  _date,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: icons[_status])
              ],
            ),
          )
        ],
      ),
    );
  }
}
